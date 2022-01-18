//
//  File.swift
//  
//
//  Created by M1 on 11/23/21.
//

import Foundation


// MARK: - MovieCategory - get_vod_categories
public struct MovieCategory: Codable {
    public let categoryID: String
    public let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}

// MARK: - MovieCategoryInfo
public struct MovieCategoryInfo: Codable {
    public let num: Int?
    public let name: String
    public let streamType: String?
    public let streamID: Int
    public let streamIcon: String?
    public let rating5Based: Double?
    public let added: String?
    public let categoryID: String
    public var containerExtension: ContainerExtension.RawValue?

    enum CodingKeys: String, CodingKey {
        case num = "num"
        case name = "name"
        case streamType = "stream_type"
        case streamID = "stream_id"
        case streamIcon = "stream_icon"
        case rating5Based = "rating_5based"
        case added = "added"
        case categoryID = "category_id"
        case containerExtension = "container_extension"
    }
}

// MARK: - MovieInfoElement
public struct MovieInfoElement: Codable {
    public let name: String
    public let streamID: Int
    public let streamIcon: String?
    public let rating5Based: Double?
    public let categoryID: String
    public var containerExtension: ContainerExtension.RawValue?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case streamID = "stream_id"
        case streamIcon = "stream_icon"
        case rating5Based = "rating_5based"
        case categoryID = "category_id"
        case containerExtension = "container_extension"
    }
}

public enum ContainerExtension: String, Codable {
    case ts = "ts"
    case wmp = "wmp"
    case m4v = "m4v"
    case hls = "hls"
    case mov = "mov"
    case avi = "avi"
    case mkv = "mkv"
    case mp4 = "mp4"
}
