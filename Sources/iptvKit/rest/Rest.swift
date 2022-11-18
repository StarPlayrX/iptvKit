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
        urlReq.cachePolicy = .reloadRevalidatingCacheData
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.current)
        
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
    
    public func textAsync(url: String, TextHandler: @escaping TextHandler)  {

        guard let url = URL(string: url) else { TextHandler("error1"); return}
                
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.timeoutInterval = TimeInterval(60)
        urlReq.cachePolicy = .reloadIgnoringCacheData
        let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in

            guard
                let data = data,
                let text = String(data: data, encoding: .utf8)
            else { TextHandler("error2"); return }
            
            TextHandler(text)
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
        urlReq.timeoutInterval = TimeInterval(60)
        urlReq.cachePolicy = .reloadIgnoringCacheData
   
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
    

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else { return }
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
    }
}
