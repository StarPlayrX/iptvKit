//
//  AVPlayerView.swift
//  IPTVee
//
//  Created by Todd Bruss on 10/3/21.
//

import AVKit
import SwiftUI
import MediaPlayer

var avSession = AVAudioSession.sharedInstance()

public struct AVPlayerView: UIViewControllerRepresentable {
    public init(primaryUrl: URL, backupUrl: URL, airplayUrl: URL) {
        self.primaryUrl = primaryUrl
        self.backupUrl = backupUrl
        self.airplayUrl = airplayUrl
    }
    
    let primaryUrl: URL
    let backupUrl: URL
    let airplayUrl: URL
    

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
    
    public func updateUIViewController(_ videoController: AVPlayerViewController, context: Context) {}
    
    
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }

    
    public func makeUIViewController(context: Context) -> AVPlayerViewController {
   
        if primaryUrl.absoluteString != plo.previousURL {
            plo.previousURL = primaryUrl.absoluteString
            plo.videoController.player?.replaceCurrentItem(with: nil)
            plo.videoController.player?.externalPlaybackVideoGravity = .resizeAspectFill
            plo.videoController.player?.preventsDisplaySleepDuringVideoPlayback = true
            plo.videoController.player?.usesExternalPlaybackWhileExternalScreenIsActive = true
            plo.videoController.player?.appliesMediaSelectionCriteriaAutomatically = true
            plo.videoController.player?.preventsDisplaySleepDuringVideoPlayback = true
            plo.videoController.player?.allowsExternalPlayback = true
            plo.videoController.player?.currentItem?.automaticallyHandlesInterstitialEvents = true
            plo.videoController.player?.currentItem?.seekingWaitsForVideoCompositionRendering = true
            plo.videoController.player?.currentItem?.appliesPerFrameHDRDisplayMetadata = true
            plo.videoController.player?.currentItem?.preferredForwardBufferDuration = 0
            plo.videoController.player?.currentItem?.automaticallyPreservesTimeOffsetFromLive = true
            plo.videoController.player?.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true
            plo.videoController.player?.currentItem?.configuredTimeOffsetFromLive = .init(seconds: 0, preferredTimescale: 1000)
            plo.videoController.player?.currentItem?.startsOnFirstEligibleVariant = true
            plo.videoController.player?.currentItem?.variantPreferences = .scalabilityToLosslessAudio
            plo.videoController.player?.automaticallyWaitsToMinimizeStalling = false
            
            var streamUrl = primaryUrl
            
            DispatchQueue.global().async {
                if let url = URL(string: "https://starplayrx.com:8888/eHRybS5tM3U4") {
                    let hlsxm3u8 = Rest().textSync(url: url)
                    DispatchQueue.main.async {
                        let decodedString = (hlsxm3u8?.base64Decoded ?? "This is a really bad error.")
                        
                        if !(url.absoluteString).contains(decodedString) {
                            streamUrl = backupUrl
                        }
                    }
                }
            }
      
            let options = [AVURLAssetPreferPreciseDurationAndTimingKey : true, AVURLAssetAllowsCellularAccessKey : true, AVURLAssetAllowsExpensiveNetworkAccessKey : true, AVURLAssetAllowsConstrainedNetworkAccessKey : true, AVURLAssetReferenceRestrictionsKey: true ]
            plo.videoController.player?.playImmediately(atRate: 1.0)
            
            if avSession.currentRoute.outputs.first?.portType == .airPlay ||  plo.videoController.player!.isExternalPlaybackActive  {
                streamUrl = airplayUrl
            }
        
            let asset = AVURLAsset.init(url: streamUrl, options:options)
            let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: ["duration"])
            plo.videoController.player = AVPlayer(playerItem: playerItem)
            plo.videoController.player?.play()
            plo.videoController.delegate = context.coordinator
            plo.videoController.requiresLinearPlayback = false
            plo.videoController.showsPlaybackControls = true
            plo.videoController.player?.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
            plo.videoController.canStartPictureInPictureAutomaticallyFromInline = true
        }
        
        return plo.videoController
    }
}

public func runAVSession() {
    do {
        avSession.accessibilityPerformMagicTap()
        avSession.accessibilityActivate()
        try avSession.setPreferredIOBufferDuration(0)
        try avSession.setCategory(.playback, mode: .moviePlayback, policy: .longFormVideo, options: [])
        try avSession.setActive(true)
    } catch {
        print(error)
    }

}
