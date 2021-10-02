//
//  Configuration.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

// MARK: - Config
public struct Configuration: Codable {
    public init(userInfo: Configuration.UserInfo, serverInfo: Configuration.ServerInfo) {
        self.userInfo = userInfo
        self.serverInfo = serverInfo
    }
    
    public let userInfo: UserInfo
    public let serverInfo: ServerInfo

    enum CodingKeys: String, CodingKey {
        case userInfo = "user_info"
        case serverInfo = "server_info"
    }
    
    // MARK: - ServerInfo
    public struct ServerInfo: Codable {
        public init(url: String, port: String, httpsPort: String, serverProtocol: String, rtmpPort: String, timezone: String, timestampNow: Int, timeNow: String) {
            self.url = url
            self.port = port
            self.httpsPort = httpsPort
            self.serverProtocol = serverProtocol
            self.rtmpPort = rtmpPort
            self.timezone = timezone
            self.timestampNow = timestampNow
            self.timeNow = timeNow
        }
        
        public let url, port, httpsPort, serverProtocol: String
        public let rtmpPort, timezone: String
        public let timestampNow: Int
        public let timeNow: String

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
        public init(username: String, password: String, message: String, auth: Int, status: String, expDate: String, isTrial: String, activeCons: String, createdAt: String, maxConnections: String, allowedOutputFormats: [String]) {
            self.username = username
            self.password = password
            self.message = message
            self.auth = auth
            self.status = status
            self.expDate = expDate
            self.isTrial = isTrial
            self.activeCons = activeCons
            self.createdAt = createdAt
            self.maxConnections = maxConnections
            self.allowedOutputFormats = allowedOutputFormats
        }
        
        public let username, password, message: String
        public let auth: Int
        public let status, expDate, isTrial, activeCons: String
        public let createdAt, maxConnections: String
        public let allowedOutputFormats: [String]

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
}
