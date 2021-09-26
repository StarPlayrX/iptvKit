//
//  Categories.swift
//
//  Created by Todd Bruss on 9/24/21.

import Foundation

//zzeH7C0xdw
public func getCategories(_ creds: Credentials, _ iptv: IPTV) {
  
    var endpoint = URLComponents()
    endpoint.scheme = iptv.scheme
    endpoint.host = iptv.host
    endpoint.port = 29971
    endpoint.path = iptv.path
    endpoint.queryItems = [
        URLQueryItem(name: "username", value: creds.username),
        URLQueryItem(name: "password", value: creds.password),
        URLQueryItem(name: "action", value: iptv.getLiveCategoriesAction)
    ]
    
    Test().DataAsync(endpoint: endpoint) { (categories) in
        guard let categories = categories else {
            return
        }
        
       let decoder = JSONDecoder()
       let cats = try? decoder.decode(Categories.self, from: categories)
       print(cats as Any)
    }
}

