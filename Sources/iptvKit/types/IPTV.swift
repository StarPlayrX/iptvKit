//
//  File.swift
//  
//
//  Created by M1 on 9/26/21.
//

import Foundation

// MARK: - IPTV
public struct IPTV {
    public init(scheme: String, host: String, path: String, port: Int) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.port = port
    }
    
    public var scheme: String
    public var host: String
    public var path: String
    public var port: Int
}
