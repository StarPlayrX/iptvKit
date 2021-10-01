//
//  Categories.swift
//
//  Created by Todd Bruss on 9/24/21.

import Foundation

public class Api {
    
    public init() {}
    
    public func getEndpoint(_ creds: Credentials,_ iptv: IPTV,_ actn: String) -> URLComponents  {
        endpoint(creds, iptv: iptv, actn: actn)
    }
}
