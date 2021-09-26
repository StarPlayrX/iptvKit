//
//  Config.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

// MARK: - Config
public struct Configuration: Codable {
    init(userInfo: Configuration.UserInfo, serverInfo: Configuration.ServerInfo) {
        self.userInfo = userInfo
        self.serverInfo = serverInfo
    }
    
  
    let userInfo: UserInfo
    let serverInfo: ServerInfo

    enum CodingKeys: String, CodingKey {
        case userInfo = "user_info"
        case serverInfo = "server_info"
    }
    
    // MARK: - ServerInfo
    struct ServerInfo: Codable {
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
        
        let url, port, httpsPort, serverProtocol: String
        let rtmpPort, timezone: String
        let timestampNow: Int
        let timeNow: String

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
    struct UserInfo: Codable {
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
        
        let username, password, message: String
        let auth: Int
        let status, expDate, isTrial, activeCons: String
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
}
