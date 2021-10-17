//
//  Actions.swift
//  iptvKit
//
//  Created by Todd Bruss on 9/27/21.
//

import Foundation
import MediaPlayer

public enum Actions: String {
    case start = "start"
    case getLiveCategoriesAction = "get_live_categories"
    case getLiveStreams = "get_live_streams"
    case getshortEpg = "get_short_epg"
    case configAction = ""
}

public let userSettings = "userSettings"

public func saveUserDefaults() {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(LoginObservable.shared.config), forKey:userSettings)
}


public func setupVideoController(_ plo: PlayerObservable) {
    plo.videoController.player = AVPlayer()
    plo.videoController.player?.replaceCurrentItem(with: nil)
    
    if #available(iOS 15.0, *) {
    #if !targetEnvironment(macCatalyst)
        plo.videoController.player?.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
        plo.videoController.canStartPictureInPictureAutomaticallyFromInline = true
    #endif
    } else {
        // Fallback on earlier versions
    }
  

    plo.videoController.requiresLinearPlayback = false
    plo.videoController.showsTimecodes = false
    plo.videoController.showsPlaybackControls = true
    plo.videoController.requiresLinearPlayback = false
    plo.videoController.entersFullScreenWhenPlaybackBegins = false
    plo.videoController.showsPlaybackControls = true
    plo.videoController.updatesNowPlayingInfoCenter = false
    
    commandCenter(plo)
    
}

func commandCenter(_ plo: PlayerObservable) {
    
    let commandCenter = MPRemoteCommandCenter.shared()
    
    commandCenter.accessibilityActivate()
    
    commandCenter.playCommand.addTarget(handler: { (event) in
        plo.videoController.player?.play()
        return MPRemoteCommandHandlerStatus.success}
    )
    
    commandCenter.pauseCommand.addTarget(handler: { (event) in
        plo.videoController.player?.pause()
        return MPRemoteCommandHandlerStatus.success}
    )
    
    commandCenter.togglePlayPauseCommand.addTarget(handler: { (event) in
        plo.videoController.player?.rate == 1 ? plo.videoController.player?.pause() : plo.videoController.player?.play()
        return MPRemoteCommandHandlerStatus.success}
    )
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
    
    rest.getRequest(endpoint: endpoint) { (login) in
        guard let login = login else {
            loginError()
            return
        }
        
        if let config = try? decoder.decode(Configuration.self, from: login) {
            LoginObservable.shared.config = config
            saveUserDefaults()
        } else {
            loginError()
        }
        
        awaitDone = true
    }
}

var epgGuide = [String:EpgListing]()

func getChannels() {
    let action = Actions.getLiveStreams.rawValue
    let endpoint = api.getEndpoint(creds, iptv, action)
    
    rest.getRequest(endpoint: endpoint) { (config) in
        
        guard let config = config else {
            
            LoginObservable.shared.status = "Get Live Streams Error"
            setCurrentStep = .ConfigurationError
            awaitDone = false
            return
        }
        
        if let channels = try? decoder.decode(Channels.self, from: config) {
            chan = channels
            
            DispatchQueue.global().async {
                
                //for ch in chan {
                 //   usleep(useconds_t(500 * 1000))
                    //getShortEpgBulk(String(ch.streamID))
                //}
                
            }
        }
        
        
        func getShortEpgBulk(_ streamId: String) {
            DispatchQueue.global().async {
                let action = Actions.getshortEpg.rawValue
                let endpoint = api.getEpgEndpoint(creds, iptv, action, streamId)
                
                rest.getRequest(endpoint: endpoint) { (programguide) in
                    guard let programguide = programguide else {
                        print("ERROR")
                        return
                    }
                    
                    if let epg = try? decoder.decode(ShortIPTVEpg.self, from: programguide) {
                        print(streamId)
                        epgGuide[streamId] = epg.epgListings.first
                        //print(epgGuide[streamId])
                    }
                    
                }
            }
         
        }

        
        
        awaitDone = true
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


func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
    
    UIGraphicsBeginImageContextWithOptions( targetSize, false, 1.0)
    
    image.draw(in: rect)
    
    if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
        UIGraphicsEndImageContext()
        return newImage
    }
    
    return UIImage()
}


public func setnowPlayingInfo(channelName:String, image: UIImage?) {
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
    
    if let image = image {
        let img = image.squareMe()
        
        let artwork = MPMediaItemArtwork(boundsSize: img.size, requestHandler: {  (_) -> UIImage in
            return img
        })
        
        nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
    } else {
        nowPlayingInfo[MPMediaItemPropertyArtwork] = nil
    }
    
    let title = PlayerObservable.plo.miniEpg.first?.title.base64Decoded ?? "IPTvee"
    nowPlayingInfo[MPMediaItemPropertyTitle] = channelName
    nowPlayingInfo[MPMediaItemPropertyArtist] = title
    nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "IPTVee"
    nowPlayingInfo[MPMediaItemPropertyMediaType] = 1
    nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
    nowPlayingInfo[MPMediaItemPropertyAlbumTitle] =  PlayerObservable.plo.miniEpg.first?.start.toDate()?.toString()
    nowPlayingInfo[MPNowPlayingInfoPropertyDefaultPlaybackRate] = 1.0
    
    if  PlayerObservable.plo.videoController.player?.timeControlStatus == .waitingToPlayAtSpecifiedRate {
        nowPlayingInfoCenter.playbackState = .paused
    } else {
        nowPlayingInfoCenter.playbackState = PlayerObservable.plo.videoController.player?.timeControlStatus == .playing  ? .playing : .stopped
    }
    
    nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo

}



func loopOverChannelsNowPlaying() {
    
}

/*
 
 
 
 
 */
