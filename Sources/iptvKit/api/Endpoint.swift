//
//  File.swift
//  
//
//  Created by Todd Bruss on 9/26/21.
//

import Foundation

func endpoint(_ creds: Credentials, iptv: IPTV, actn: String) -> URLComponents {
    var endpoint = URLComponents()
    
    endpoint.scheme = iptv.scheme
    endpoint.host = iptv.host
    endpoint.port = iptv.port
    endpoint.path = iptv.path
    
    endpoint.queryItems = [
        URLQueryItem(name: "username", value: creds.username),
        URLQueryItem(name: "password", value: creds.password),
        URLQueryItem(name: "action", value: actn)
    ]
    
    return endpoint
}
