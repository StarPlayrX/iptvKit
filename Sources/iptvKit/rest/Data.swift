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
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else { return }
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
    }
}
