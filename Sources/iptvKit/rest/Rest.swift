//
//  Data.swift
//  
//  Created by Todd Bruss on 9/24/21.

import Foundation

//MARK: Data
public class Rest: NSObject, URLSessionDelegate {
    public func getRequest(endpoint: URLComponents, DataHandler: @escaping DataHandler)  {
        
        guard
            let url = endpoint.url
        else {
            DataHandler(nil)
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.timeoutInterval = TimeInterval(15)
        urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        
        let task = session.dataTask(with: urlReq) { ( data, response, error ) in
                        
            guard
                let data = data
            else {
                DataHandler(nil)
                return
            }
                              
            DataHandler(data)
        }
        
        task.resume()
    }
    
    public func textAsync(url: String, TextArrayHandler: @escaping TextArrayHandler)  {

        guard let url = URL(string: url) else { TextArrayHandler(["error1"]); return}
        
        var array = [String]()
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.timeoutInterval = TimeInterval(10)
        urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let task = URLSession.shared.dataTask(with: urlReq ) { ( data, resp, errr ) in
            guard
                let d = data,
                let text = String(data: d, encoding: .utf8),
                let respUrl = resp?.url
            else { TextArrayHandler(["error2"]); return }
            
            array.append(text)
            array.append(respUrl.absoluteString)
            TextArrayHandler(array)
        }
        
        task.resume()
    }
    
    public func videoAsync(url: URL?, VideoHandler: @escaping VideoHandler)  {
        
        guard
            let url = url
        else {
            VideoHandler(Data())
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.timeoutInterval = TimeInterval(5)
        urlReq.cachePolicy = .returnCacheDataElseLoad
   
        let task = URLSession.shared.dataTask(with: urlReq) {(data, _, _) in

            guard
                let data = data
            else {
                VideoHandler(Data())
                return
            }
            
            VideoHandler(data)
        }
        
        task.resume()
    }
    
    /* app.get("eHRybS5tM3U4") { req -> String in
           "aGxzeC5tM3U4" //hlsx.m3u8
       } */
    
    public func textSync(url: URL?) -> String?  {

        //MARK: - for Sync
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = url else { return nil }
        
        var urlReq = URLRequest(url: url)
        var retStr = ""
        urlReq.httpMethod = "GET"
        urlReq.timeoutInterval = TimeInterval(10)
        urlReq.cachePolicy = .returnCacheDataElseLoad
        let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in
            guard
                let data = data
            else { return }
            
            retStr = String(decoding: data, as: UTF8.self)
            
            //MARK: - for Sync
            semaphore.signal()
        }
        
        task.resume()
        
        //MARK: - for Sync
        _ = semaphore.wait(timeout: .distantFuture)
        
        return retStr
    }

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else { return }
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
    }
}
