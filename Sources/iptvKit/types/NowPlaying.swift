//
//  File.swift
//  
//
//  Created by M1 on 10/22/21.
//

import Foundation

// MARK: - NowPlayingValue
public struct NowPlayingValue: Codable {
    public init(channelID: String, id: String, title: String, epgID: String, nowPlayingDescription: String, start: String) {
        self.channelID = channelID
        self.id = id
        self.title = title
        self.epgID = epgID
        self.nowPlayingDescription = nowPlayingDescription
        self.start = start
    }
    
    
    public let channelID: String
    public let id: String
    public let title: String
    public let epgID: String
    public let nowPlayingDescription: String
    public let start: String

    public enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case id, title
        case epgID = "epg_id"
        case nowPlayingDescription = "description"
        case start
    }
}

public typealias NowPlaying = [String: NowPlayingValue]
