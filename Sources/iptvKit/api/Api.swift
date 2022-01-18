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
    
    public func getEpgEndpoint(_ creds: Credentials,_ iptv: IPTV,_ actn: String,_ streamId: Int) -> URLComponents  {
        epgEndpoint(creds, iptv: iptv, actn: actn, streamId: streamId)
    }
    
    public func getTVSeriesEndpoint(_ creds: Credentials,_ iptv: IPTV,_ actn: String,_ categoryID: String) -> URLComponents  {
        tvSeriesEndpoint(creds, iptv: iptv, actn: actn, categoryID: categoryID)
    }
    
    public func getTVSeriesInfoEndpoint(_ creds: Credentials,_ iptv: IPTV,_ actn: String,_ seriesID: String) -> URLComponents  {
        tvSeriesInfoEndpoint(creds, iptv: iptv, actn: actn, seriesID: seriesID)
    }
    
    public func getMovieInfoEndpoint(_ creds: Credentials,_ iptv: IPTV,_ actn: String,_ vodID: String) -> URLComponents  {
        movieInfoEndpoint(creds, iptv: iptv, actn: actn, vodID: vodID)
    }
    
    
    public func getNowPlayingEndpoint() -> URLComponents  {
        nowPlayingEndpoint(path: "/nowplaying")
    }
    
    public func getNowPlayingEndpointBytes() -> URLComponents  {
        nowPlayingEndpoint(path: "/jb")
    }
}
