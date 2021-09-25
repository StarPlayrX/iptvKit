//
//  Text.swift
//  
//
//  Created by M1 on 9/24/21.
//
import Foundation

typealias TextHandler = (_ text:String?) -> Void
typealias DataHandler = (_ data:Data?) -> Void



//http://aftv2.ga:826//player_api.php?username=toddbruss90&password=zzeH7C0xdw&action=get_live_categories

struct IPTV {
    let service = "http://aftv2.ga:826/"
    let player = "player_api.php?"
    let categoriesAction = "get_live_categories"
}

public func helloworld() {
    print("HELLOWORLD")
}

//MARK: Text
internal func TextAsync(endpoint: String, TextHandler: @escaping TextHandler)  {

    guard let url = URL(string: endpoint) else { TextHandler("error1"); return}
    
    var urlReq = URLRequest(url: url)
    urlReq.httpMethod = "GET"
    urlReq.timeoutInterval = TimeInterval(10)
    urlReq.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    print("urlReq",urlReq)
    let task = URLSession.shared.dataTask(with: urlReq ) { ( data, _, _ ) in
        print("data",data)
        guard
            let d = data,
            let text = String(data: d, encoding: .utf8)
        else { TextHandler("error2"); return }
        
        print(text)
        TextHandler(text)
    }
    
    task.resume()
}

public func getCategories() {
    let source = "http://aftv2.ga:826/player_api.php?username=toddbruss90&password=zzeH7C0xdw&action=get_live_categories"
    
    print(source)
    TextAsync(endpoint: source) { (categories) in
        guard let categories = categories else {
            
            print("NOT GOOD")
            return
        }
        
        print("HELLO")
    }
    
    
}


