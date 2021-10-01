//
//  Channel.swift
//  
//
//  Created by Todd Bruss on 9/30/21.
//

import Foundation

// MARK: - ConfigElement
public struct Channel: Codable {
    let num: Int
    let name: String
    let streamID: Int
    let streamIcon: String
    let epgChannelID: String?
    let categoryID: String

    enum CodingKeys: String, CodingKey {
        case num = "num"
        case name = "name"
        case streamID = "stream_id"
        case streamIcon = "stream_icon"
        case epgChannelID = "epg_channel_id"
        case categoryID = "category_id"
    }
}
