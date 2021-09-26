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
        service: String = "http://aftv2.ga:826",
        playerAPI: String = "player_api.php",
        getLiveCateogies: String = "get_live_categories") {
        self.service = service
        self.playerAPI = playerAPI
        self.getLiveCateogies = getLiveCateogies
    }
    
    var service: String
    var playerAPI: String
    var getLiveCateogies: String
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
