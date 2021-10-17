//
//  AVPlayerView.swift
//  IPTVee
//
//  Created by Todd Bruss on 10/3/21.
//

import AVKit
import SwiftUI
import MediaPlayer

public struct AVPlayerView: UIViewControllerRepresentable {
    public init(url: URL) {
        self.url = url
    }
    
    let url: URL
    
    //@State allows updating the variable in SwiftUI
    @State var playedOnce: Bool = false
    
    @ObservedObject var plo = PlayerObservable.plo
    
    public class Coordinator: NSObject, AVPlayerViewControllerDelegate, UINavigationControllerDelegate {
        
        let po = PlayerObservable.plo
        
        public func playerViewController(_ playerViewController: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            po.fullscreen = true
        }
        
        public func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            po.fullscreen = false
        }
        
        public func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            po.pip = true
        }
        
        public func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            po.pip = false
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func updateUIViewController(_ videoController: AVPlayerViewController, context: Context) {
        plo.videoController.updatesNowPlayingInfoCenter = false
    }
    
    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        plo.videoController.updatesNowPlayingInfoCenter = false
        let options = [AVURLAssetPreferPreciseDurationAndTimingKey : true, AVURLAssetAllowsCellularAccessKey : true, AVURLAssetAllowsExpensiveNetworkAccessKey : true, AVURLAssetAllowsConstrainedNetworkAccessKey : true ]
        let asset = AVURLAsset.init(url: url, options:options)
      
        let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: ["duration"])
      
        plo.videoController.player?.replaceCurrentItem(with: playerItem)
        plo.videoController.player?.currentItem?.seekingWaitsForVideoCompositionRendering = false
        plo.videoController.player?.currentItem?.appliesPerFrameHDRDisplayMetadata = true
        plo.videoController.player?.currentItem?.preferredForwardBufferDuration = 0
        plo.videoController.player?.currentItem?.automaticallyPreservesTimeOffsetFromLive = true
        plo.videoController.player?.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true
        plo.videoController.player?.currentItem?.configuredTimeOffsetFromLive = .init(seconds: 10, preferredTimescale: 1000)
        plo.videoController.player?.currentItem?.startsOnFirstEligibleVariant = true
        plo.videoController.player?.currentItem?.variantPreferences = .scalabilityToLosslessAudio
        
        if #available(iOS 15.0, *) {
        #if !targetEnvironment(macCatalyst)
            plo.videoController.player?.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
        #endif
        } else {
            // Fallback on earlier versions
        }
        
        plo.videoController.player?.appliesMediaSelectionCriteriaAutomatically = true
        plo.videoController.player?.preventsDisplaySleepDuringVideoPlayback = true
        plo.videoController.delegate = context.coordinator
        plo.videoController.player?.playImmediately(atRate: 1.0)
        
        return plo.videoController
    }
    
    
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
    
}



