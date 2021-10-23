//
//  Actions.swift
//  iptvKit
//
//  Created by Todd Bruss on 9/27/21.
//


import Foundation
import UIKit

public enum Actions: String {
    case start = "start"
    case getLiveCategoriesAction = "get_live_categories"
    case getLiveStreams = "get_live_streams"
    case getshortEpg = "get_short_epg"
    case configAction = ""
}

func getCategories() {
    let action = Actions.getLiveCategoriesAction.rawValue
    let endpoint = api.getEndpoint(creds, iptv, action)
    
    rest.getRequest(endpoint: endpoint) {  (categories) in
        guard let categories = categories else {
            LoginObservable.shared.status = "Get Categories Error"
            setCurrentStep = .CategoriesError
            awaitDone = false
            return
        }
        
        if let catz = try? decoder.decode(Categories.self, from: categories) {
            cats = catz
            for (i,cat) in catz.enumerated() {
                
                let nam = cat.categoryName.components(separatedBy: " ")
                var catName = ""
                
                for x in nam {
                    if x.count > 5 {
                        catName.append(contentsOf: x.localizedCapitalized)
                    } else {
                        catName.append(contentsOf: x)
                    }
                    
                    catName += " "
                }
                
                cats[i].categoryName = catName
                cats[i].categoryName.removeLast()
                
            }
        }
        
        if cats.count > 3 { cats.removeLast() }
        
        awaitDone = true
    }
}

func getConfig() {
    let action = Actions.configAction.rawValue
    let endpoint = api.getEndpoint(creds, iptv, action)
    
    func loginError() {
        LoginObservable.shared.status = "Login Error"
        setCurrentStep = .ConfigurationError
        awaitDone = false
    }
    
    rest.getRequest(endpoint: endpoint) { login in
        guard let login = login else {
            loginError()
            return
        }
        
        if let config = try? decoder.decode(Configuration.self, from: login) {
            LoginObservable.shared.config = config
            LoginObservable.shared.password = config.userInfo.password
            LoginObservable.shared.username = config.userInfo.username
            LoginObservable.shared.port = config.serverInfo.port
            LoginObservable.shared.url = config.serverInfo.url
            saveUserDefaults()
            awaitDone = true
        } else {
            loginError()
        }
    }
}

public func getShortEpg(streamId: String, channelName: String, imageURL: String) {
    let action = Actions.getshortEpg.rawValue
    let endpoint = api.getEpgEndpoint(creds, iptv, action, streamId)
    
    rest.getRequest(endpoint: endpoint) { (programguide) in
        guard let programguide = programguide else {
            LoginObservable.shared.status = "Get Short EPG Error"
            return
        }
        
        if let epg = try? decoder.decode(ShortIPTVEpg.self, from: programguide) {
            shortEpg = epg
            PlayerObservable.plo.miniEpg = shortEpg?.epgListings ?? []
            
            DispatchQueue.global().async {
                if let url = URL(string: imageURL) {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        
                        if let data = data, let image = UIImage(data: data), !channelName.isEmpty {
                            setnowPlayingInfo(channelName: channelName, image: image)
                        } else if !channelName.isEmpty {
                            setnowPlayingInfo(channelName: channelName, image: nil)
                        }
                    }
                }
            }
        }
    }
}

var channelData = Data()

func getChannels() {
    let action = Actions.getLiveStreams.rawValue
    let endpoint = api.getEndpoint(creds, iptv, action)
    
    rest.getRequest(endpoint: endpoint) { (data) in
        
        guard let data = data else {
            LoginObservable.shared.status = "Get Live Streams Error"
            setCurrentStep = .ConfigurationError
            awaitDone = false
            return
        }
        
        channelData = data
        
        getNowPlayingHelper()
        
        awaitDone = true
    }
}


public func getNowPlayingHelper() {
    if let channels = try? decoder.decode(Channels.self, from: channelData) {
        ChannelsObservable.shared.chan = channels
        getNowPlayingEpg(channelz: ChannelsObservable.shared.chan)
    }
}

public func getNowPlayingEpg(channelz: Channels?) {
    
    guard var chnlz = channelz else { return }

    let endpoint = api.getNowPlayingEndpoint()
    rest.getRequest(endpoint: endpoint) { (programguide) in
        guard let programguide = programguide else {
            print("getNowPlayingEpg Error")
            return
        }
        
        if let nowplaying = try? decoder.decode(NowPlaying.self, from: programguide) {
            
            if !chnlz.isEmpty {
                for (index, ch) in chnlz.enumerated() {
                    if let nowplaying = Optional(nowplaying), let chid = ch.epgChannelID {
                        chnlz[index].nowPlaying = nowplaying[chid]?.title.base64Decoded ?? ""
                    } else {
                        chnlz[index].nowPlaying = ""
                    }
                }
                
                ChannelsObservable.shared.chan = chnlz

            }
        }
    }
}
