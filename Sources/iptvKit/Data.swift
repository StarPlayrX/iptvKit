//
//  Data.swift
//  
//
//  Created by Todd Bruss on 9/24/21.
//

import Foundation

//MARK: Data
internal func DataAsync(endpoint: String, DataHandler: @escaping DataHandler)  {

    guard
        let url = URL(string: endpoint)
    else {
        DataHandler(nil)
        return
    }
    
    var urlReq = URLRequest(url: url)
    urlReq.httpMethod = "GET"
    urlReq.timeoutInterval = TimeInterval(30)
    urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in
        guard
            let data = data
        else {
            DataHandler(nil)
            return
        }
        print(data)

        DataHandler(data)
    }
    
    task.resume()
}
