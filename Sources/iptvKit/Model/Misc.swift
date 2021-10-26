//
//  File.swift
//  
//
//  Created by M1 on 10/21/21.
//

import Foundation
import MediaPlayer
import AVKit

public func setupVideoController(_ plo: PlayerObservable) {
    
    plo.videoController.showsTimecodes = false
    plo.videoController.showsPlaybackControls = true
    plo.videoController.requiresLinearPlayback = false
    plo.videoController.entersFullScreenWhenPlaybackBegins = false
    plo.videoController.showsPlaybackControls = true
    plo.videoController.updatesNowPlayingInfoCenter = false
    plo.videoController.player = AVPlayer(playerItem: nil)
    
    if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
        plo.videoController.player?.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
    }


    plo.videoController.view.backgroundColor = UIColor.clear
    
    commandCenter(plo)
    
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


func commandCenter(_ plo: PlayerObservable) {
    
    let commandCenter = MPRemoteCommandCenter.shared()
    
    
    func skipForward(_ videoController: AVPlayerViewController ) {
       let seekDuration: Double = 10
       videoController.player?.pause()
       
       guard
           let player = videoController.player
       else {
           return
       }
       
       var playerCurrentTime = CMTimeGetSeconds( player.currentTime() )
       playerCurrentTime += seekDuration
       
       let time: CMTime = CMTimeMake(value: Int64(playerCurrentTime * 1000 as Double), timescale: 1000)
       videoController.player?.seek(to: time)
       videoController.player?.play()
    }

    func skipBackward(_ videoController: AVPlayerViewController ) {
       let seekDuration: Double = 10
       videoController.player?.pause()
       
       guard
           let player = videoController.player
       else {
           return
       }
       
       var playerCurrentTime = CMTimeGetSeconds( player.currentTime() )
       playerCurrentTime -= seekDuration
       
       let time: CMTime = CMTimeMake(value: Int64(playerCurrentTime * 1000 as Double), timescale: 1000)
       videoController.player?.seek(to: time)
       videoController.player?.play()
    }

    
    commandCenter.accessibilityActivate()
    
    commandCenter.playCommand.addTarget(handler: { (event) in
        plo.videoController.player?.play()
        print("play")
        return MPRemoteCommandHandlerStatus.success}
    )
    
    commandCenter.pauseCommand.addTarget(handler: { (event) in
        plo.videoController.player?.pause()
        print("pause")
        return MPRemoteCommandHandlerStatus.success}
    )
    
    commandCenter.togglePlayPauseCommand.addTarget(handler: { (event) in
        plo.videoController.player?.rate == 1 ? plo.videoController.player?.pause() : plo.videoController.player?.play()
        print("toggle")

        return MPRemoteCommandHandlerStatus.success}
    )
    
    commandCenter.skipBackwardCommand.addTarget(handler: { (event) in
        skipBackward(plo.videoController)
        print("seekBackwardCommand")
        return MPRemoteCommandHandlerStatus.success}
    )
        
    commandCenter.skipForwardCommand.addTarget(handler: { (event) in
        skipForward(plo.videoController)
        print("seekForwardCommand")

        return MPRemoteCommandHandlerStatus.success}
    )
    
   
}

