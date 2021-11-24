//
//  Channel.swift
//  
//
//  Created by Todd Bruss on 9/30/21.
//

import Foundation

// MARK: - ConfigElement
public struct iptvChannel: Codable, Identifiable {
    public init(num: Int, name: String, streamID: Int, streamIcon: String, epgChannelID: String?, categoryID: String, nowPlaying: String = "", id: UUID = UUID()) {
        self.num = num
        self.name = name
        self.streamID = streamID
        self.streamIcon = streamIcon
        self.epgChannelID = epgChannelID
        self.categoryID = categoryID
        self.nowPlaying = nowPlaying
        self.id = id
    }
    
    public let num: Int
    public let name: String
    public let streamID: Int
    public let streamIcon: String
    public let epgChannelID: String?
    public let categoryID: String?
    public var nowPlaying: String = ""
    public var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case num = "num"
        case name = "name"
        case streamID = "stream_id"
        case streamIcon = "stream_icon"
        case epgChannelID = "epg_channel_id"
        case categoryID = "category_id"
    }
}

// MARK: - iptvChannel2
public struct iptvChannel2: Codable {
    public init(num: Int, name: String, streamID: Int, streamIcon: String, categoryID: String) {
        self.num = num
        self.name = name
        self.streamID = streamID
        self.streamIcon = streamIcon
        self.categoryID = categoryID

    }
    
    public let num: Int
    public let name: String
    public let streamID: Int
    public let streamIcon: String
    public let categoryID: String?
    
    enum CodingKeys: String, CodingKey {
        case num = "num"
        case name = "name"
        case streamID = "stream_id"
        case streamIcon = "stream_icon"
        case categoryID = "category_id"
    }
}

