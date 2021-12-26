//
//  Configuration.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

// MARK: - Config
public struct Configuration: Codable {
    public init(userInfo: UserInfo, serverInfo: ServerInfo) {
        self.userInfo = userInfo
        self.serverInfo = serverInfo
    }
    
    public let userInfo: UserInfo
    public let serverInfo: ServerInfo

    enum CodingKeys: String, CodingKey {
        case userInfo = "user_info"
        case serverInfo = "server_info"
    }
}

// MARK: - ServerInfo
public struct ServerInfo: Codable {
    public init(rtmpPort: String, timezone: String, timestampNow: Int, timeNow: String, url: String, port: String, httpsPort: String, serverProtocol: String) {
        self.rtmpPort = rtmpPort
        self.timezone = timezone
        self.timestampNow = timestampNow
        self.timeNow = timeNow
        self.url = url
        self.port = port
        self.httpsPort = httpsPort
        self.serverProtocol = serverProtocol
    }
    
    

    public let rtmpPort: String
    public let timezone: String
    public let timestampNow: Int
    public let timeNow: String
    public let url, port, httpsPort, serverProtocol: String

    enum CodingKeys: String, CodingKey {
        case url, port
        case httpsPort = "https_port"
        case serverProtocol = "server_protocol"
        case rtmpPort = "rtmp_port"
        case timezone
        case timestampNow = "timestamp_now"
        case timeNow = "time_now"
    }
}

// MARK: - UserInfo
public struct UserInfo: Codable {
   
    public let username, password, message: String
    public let status, expDate: String
    public let allowedOutputFormats: [String]

    enum CodingKeys: String, CodingKey {
         case username, password, message, status
         case expDate = "exp_date"
         case allowedOutputFormats = "allowed_output_formats"
    }
}


/*
 
 import Foundation

 // MARK: - LoginInfo
 struct LoginInfo: Codable {
     let userInfo: UserInfo
     let serverInfo: ServerInfo

     enum CodingKeys: String, CodingKey {
         case userInfo = "user_info"
         case serverInfo = "server_info"
     }
 }

 // MARK: - ServerInfo
 struct ServerInfo: Codable {
     let xui: Bool
     let version: String
     let revision: Int
     let url, port, httpsPort, serverProtocol: String
     let rtmpPort: String
     let timestampNow: Int
     let timeNow, timezone: String

     enum CodingKeys: String, CodingKey {
         case xui, version, revision, url, port
         case httpsPort = "https_port"
         case serverProtocol = "server_protocol"
         case rtmpPort = "rtmp_port"
         case timestampNow = "timestamp_now"
         case timeNow = "time_now"
         case timezone
     }
 }

 // MARK: - UserInfo
 struct UserInfo: Codable {
     let username, password, message: String
     let auth: Int
     let status, expDate, isTrial: String
     let activeCons: Int
     let createdAt, maxConnections: String
     let allowedOutputFormats: [String]

     enum CodingKeys: String, CodingKey {
         case username, password, message, auth, status
         case expDate = "exp_date"
         case isTrial = "is_trial"
         case activeCons = "active_cons"
         case createdAt = "created_at"
         case maxConnections = "max_connections"
         case allowedOutputFormats = "allowed_output_formats"
     }
 }

 
 */
