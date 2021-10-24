//
//  File.swift
//  
//
//  Created by M1 on 10/21/21.
//

import Foundation
import MediaPlayer

public func setupVideoController(_ plo: PlayerObservable) {
    plo.videoController.player = AVPlayer(playerItem: nil)
    
    if #available(iOS 15.0, *) {
        #if !targetEnvironment(macCatalyst)
        plo.videoController.player?.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
        plo.videoController.canStartPictureInPictureAutomaticallyFromInline = true
        #endif
    }
  
    plo.videoController.requiresLinearPlayback = false
    plo.videoController.showsTimecodes = false
    plo.videoController.showsPlaybackControls = true
    plo.videoController.requiresLinearPlayback = false
    plo.videoController.entersFullScreenWhenPlaybackBegins = false
    plo.videoController.showsPlaybackControls = true
    plo.videoController.updatesNowPlayingInfoCenter = false
    
    plo.videoController.player?.currentItem?.automaticallyHandlesInterstitialEvents = true
    plo.videoController.player?.currentItem?.seekingWaitsForVideoCompositionRendering = true
    plo.videoController.player?.currentItem?.appliesPerFrameHDRDisplayMetadata = true
    plo.videoController.player?.currentItem?.preferredForwardBufferDuration = 80
    plo.videoController.player?.currentItem?.automaticallyPreservesTimeOffsetFromLive = true
    plo.videoController.player?.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true
    plo.videoController.player?.currentItem?.configuredTimeOffsetFromLive = .init(seconds: 80, preferredTimescale: 600)
    plo.videoController.player?.currentItem?.startsOnFirstEligibleVariant = true
    plo.videoController.player?.currentItem?.variantPreferences = .scalabilityToLosslessAudio
    plo.videoController.player?.allowsExternalPlayback = true
    plo.videoController.player?.externalPlaybackVideoGravity = .resizeAspectFill
    
    if #available(iOS 15.0, *) {
        #if !targetEnvironment(macCatalyst)
            plo.videoController.player?.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
        #endif
    }
    
    plo.videoController.player?.appliesMediaSelectionCriteriaAutomatically = true
    plo.videoController.player?.preventsDisplaySleepDuringVideoPlayback = true
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
