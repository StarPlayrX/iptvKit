//
//  ShortEpg.swift
//  
//
//  Created by Todd Bruss on 10/6/21.
//

import Foundation

// MARK: - ShortEpg
public struct iptvShortEpg: Codable {
    public init(epgListings: [iptvShortEpg.EpgListing]) {
        self.epgListings = epgListings
    }
    
    let epgListings: [EpgListing]

    enum CodingKeys: String, CodingKey {
        case epgListings = "epg_listings"
    }
    
    // MARK: - EpgListing
    public struct EpgListing: Codable {
        public init(id: String, epgID: String, title: String, lang: String, start: String, end: String, epgListingDescription: String, channelID: String, startTimestamp: String, stopTimestamp: String) {
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
        
        let id, epgID, title, lang: String
        let start, end, epgListingDescription, channelID: String
        let startTimestamp, stopTimestamp: String

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
}
