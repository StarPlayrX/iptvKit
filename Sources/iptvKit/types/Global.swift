//
//  File.swift
//  
//
//  Created by M1 on 10/14/21.
//

import Foundation

public let api = Api()

public var creds = Creds (
    username: "toddbruss90",
    password: "zzeH7C0xdw"
)

public var iptv = IPTV (
    scheme: "http",
    host: "",
    path: "/player_api.php",
    port: 80) //29971

public let rest = Rest()
public let decoder = JSONDecoder()

public var cats: Categories = Categories()
public var conf: Configuration? = nil
public var chan: Channels = Channels()
public var shortEpg: iptvShortEpg? = nil
