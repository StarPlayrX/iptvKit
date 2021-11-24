//
//  Category.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

// MARK: - Category
public struct Category: Codable {
    public let categoryID: String
    public var categoryName: String
    public let parentID: Int
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case parentID = "parent_id"
    }
}


// MARK: - SeriesCategory
public struct SeriesCategory: Codable {
    public let categoryID: String
    public let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}

// MARK: - MovieCategory - get_vod_categories
public struct MovieCategory: Codable {
    public let categoryID: String
    public let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}

// MARK: - MovieCategoryInfo - get_vod_streams&category_id=1777
public struct MovieCategoryInfo: Codable {
    public let num: Int
    public let name: String
    public let streamType: String
    public let streamID: Int
    public let streamIcon: String?
    public let rating: String?
    public let rating5Based: Double
    public let added: String
    public let categoryID: String
    public let containerExtension: String

    enum CodingKeys: String, CodingKey {
        case num = "num"
        case name = "name"
        case streamType = "stream_type"
        case streamID = "stream_id"
        case streamIcon = "stream_icon"
        case rating = "rating"
        case rating5Based = "rating_5based"
        case added = "added"
        case categoryID = "category_id"
        case containerExtension = "container_extension"
    }
}
