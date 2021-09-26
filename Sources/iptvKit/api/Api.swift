//
//  Categories.swift
//
//  Created by Todd Bruss on 9/24/21.

import Foundation

public class Api {
    
    public init() {}
    
    let rest = Rest()
    
    public func getCategories(_ creds: Creds,_ iptv: IPTV) {
        
        let actn = Actions.getLiveCategoriesAction.rawValue
        let endpoint = endpoint(creds, iptv: iptv, actn: actn)
        
        rest.getRequest(endpoint: endpoint) { (categories) in
            guard let categories = categories else {
                return
            }
            
           let decoder = JSONDecoder()
           let cats = try? decoder.decode(Categories.self, from: categories)
           print(cats as Any)
        }
    }
    
    public func getConfiguration(_ creds: Creds,_ iptv: IPTV) {
        
        let actn = ""
        let endpoint = endpoint(creds, iptv: iptv, actn: actn)
        
        rest.getRequest(endpoint: endpoint) { (categories) in
            guard let categories = categories else {
                return
            }
            
           let decoder = JSONDecoder()
           let cats = try? decoder.decode(Configuration.self, from: categories)
           print(cats as Any)
        }
    }
}


