//
//  File.swift
//  
//
//  Created by M1 on 10/22/21.
//

import Foundation

public typealias NowPlaying = [String: [NowPlayingValue]]

public var NowPlayingLive = NowPlaying()

public struct NowPlayingValue: Codable {
    public let id: String
    public let start: String
    public let stop: String
    public let startTimestamp: Int
    public let stopTimestamp: Int
    public let title: String
    public let desc: String?
}
