//
//  Category.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

// MARK: - Category
public struct Category: Codable, Identifiable {
    public let id = UUID()
    public let categoryID: String
    public var categoryName: String
    public let parentID: Int
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case parentID = "parent_id"
    }
}
