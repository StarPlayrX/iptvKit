//
//  Structs.swift
//  
//
//  Created by Todd Bruss on 9/24/21.
//

import Foundation

// MARK: - Credentials
public struct Credentials {
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    let username: String
    let password: String
}

// MARK: - IPTV
public struct IPTV {
    public init(
        scheme: String = "https",
        host: String = "primestreams.tv",
        path: String = "/player_api.php",
        getLiveCategoriesAction: String = "get_live_categories") {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.getLiveCategoriesAction = getLiveCategoriesAction
    }
    
    var scheme: String
    var host: String
    var path: String
    var getLiveCategoriesAction: String
}

// MARK: - Category
public struct Category: Codable {
    let categoryID, categoryName: String
    let parentID: Int
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case parentID = "parent_id"
    }
}
