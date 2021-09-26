//
//  Credentials.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

// MARK: - Creds
public struct Creds {
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    let username: String
    let password: String
}
