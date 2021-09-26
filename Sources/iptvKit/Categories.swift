//
//  Categories.swift
//
//  Created by Todd Bruss on 9/24/21.

import Foundation

//zzeH7C0xdw
public func getCategories(_ creds: Credentials, _ iptv: IPTV) {
    
    let endpoint = "\(iptv.service)/\(iptv.playerAPI)?username=\(creds.username)&password=\(creds.password)&action=\(iptv.getLiveCateogies)"
    print(endpoint)
    DataAsync(endpoint: endpoint) { (categories) in
        guard let categories = categories else {
            print("FUCKER")
            return
        }
        
        print("categories",categories)
        let decoder = JSONDecoder()
       let cats = try? decoder.decode(Categories.self, from: categories)
       print(cats as Any)
    }
}

