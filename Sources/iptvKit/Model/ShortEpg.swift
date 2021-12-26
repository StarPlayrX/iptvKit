//
//  ShortEpg.swift
//  
//
//  Created by Todd Bruss on 10/6/21.
//

import Foundation

// MARK: - ShortEpg
public struct iptvShortEpg: Codable {
    public init(epgListings: [EpgListing]) {
        self.epgListings = epgListings
    }
    
    public let epgListings: [EpgListing]
    
    enum CodingKeys: String, CodingKey {
        case epgListings = "epg_listings"
    }
}

// MARK: - EpgListing
public struct EpgListing: Codable {
    public init(id: SuperString, epgID: String, title: String, lang: String, start: SuperString, end: SuperString, epgListingDescription: String, channelID: String, startTimestamp: SuperString, stopTimestamp: SuperString) {
        self.id = id
        self.epgID = epgID
        self.title = title
        self.lang = lang
        self.start = start
        self.end = end
        self.epgListingDescription = epgListingDescription
        self.channelID = channelID
        self.startTimestamp = startTimestamp
        self.stopTimestamp = stopTimestamp
    }
    public let id: SuperString
    public let epgID, title, lang: String
    public let start, end: SuperString
    public let epgListingDescription, channelID: String
    public let startTimestamp, stopTimestamp: SuperString
    
    enum CodingKeys: String, CodingKey {
        case id
        case epgID = "epg_id"
        case title, lang, start, end
        case epgListingDescription = "description"
        case channelID = "channel_id"
        case startTimestamp = "start_timestamp"
        case stopTimestamp = "stop_timestamp"
    }
}

public struct SuperString: Codable {
    public var value: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let str1 = try? container.decode(String.self) {
            value = String(str1)
            return
        } else if let int1 = try? container.decode(Int.self) {
            value = String(int1)
            return
        }
        
        throw DecodingError.typeMismatch(SuperString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SuperString"))
    }
    
  
}

public struct SuperInt: Codable {
    public var value: Int
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let int1 = try? container.decode(Int.self) {
            value = Int(int1)
            return
        } else if let str1 = try? container.decode(String.self), let str2 = Int(str1) {
            value = str2
            return
        }
        
        throw DecodingError.typeMismatch(SuperInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SuperInt"))
    }
    
    
   
}

public struct SuperStringBean: Codable {
    internal init(value: String) {
        self.value = String(value)
    }
    
    public var value: String
    
   /* public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let int1 = try? container.decode(Int.self) {
            value = Int(int1)
            return
        } else if let str1 = try? container.decode(String.self), let str2 = Int(str1) {
            value = str2
            return
        }
        
        throw DecodingError.typeMismatch(SuperInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SuperInt"))
    } */
    
    
   
}
