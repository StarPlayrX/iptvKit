//
//  Structs.swift
//  
//
//  Created by Todd Bruss on 9/24/21.
//

import Foundation

// MARK: - Credentials
struct Credentials {
    let username = ""
    let password = ""
}

// MARK: - IPTV
struct IPTV {
    let service = "http://aftv2.ga:826/"
    let player = "player_api.php?"
    let getLiveCateogies = "get_live_categories"
}

// MARK: - Category
struct Category: Codable {
    let categoryID, categoryName: String
    let parentID: Int
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case parentID = "parent_id"
    }
}
