//
//  Text.swift
//  
//
//  Created by Todd Bruss on 9/24/21.
//
import Foundation

//MARK: Text
internal func TextAsync(endpoint: String, TextHandler: @escaping TextHandler)  {

    guard let url = URL(string: endpoint) else { TextHandler("error1"); return}
    
    var urlReq = URLRequest(url: url)
    urlReq.httpMethod = "GET"
    urlReq.timeoutInterval = TimeInterval(10)
    urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in
        guard
            let d = data,
            let text = String(data: d, encoding: .utf8)
        else { TextHandler("error2"); return }
        
        print(text)
        TextHandler(text)
    }
    
    task.resume()
}
