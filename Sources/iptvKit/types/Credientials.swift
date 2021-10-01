//
//  Credentials.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

// MARK: - Creds
public struct Credentials {
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public var username: String
    public var password: String
}
