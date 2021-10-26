//
//  File.swift
//  
//
//  Created by M1 on 10/15/21.
//

import Foundation
import AVKit
import Combine

//MARK: - 1
public class LoginObservable: ObservableObject {
    static public var shared = LoginObservable()
    @Published public var status: String = "Update"
    @Published public var isLoggedIn: Bool = false
    @Published public var isAutoSwitchCat: Bool = false
    @Published public var isCatActive: Bool = false
    @Published public var config: Config = nil
    @Published public var url: String = ""
    @Published public var port: String = ""
    @Published public var username: String = ""
    @Published public var password: String = ""
}
//MARK: - 2
public class CategoriesObservable: ObservableObject {
    static var cto = CategoriesObservable()
    @Published var status: String = "test"
    @Published var loggedIn: Bool = false
}

//MARK: - 3
public class ChannelsObservable: ObservableObject {
    static public var shared = ChannelsObservable()
    @Published public var chan: [iptvChannel] = [iptvChannel]()

}

//MARK: - 4
public class PlayerObservable: ObservableObject {
    static public var plo = PlayerObservable()
    @Published public var miniEpg: [EpgListing] = []
    @Published public var nowPlayingEpg: [String: NowPlayingValue]? = nil

    @Published public var videoController: AVPlayerViewController = AVPlayerViewController()
    @Published public var pip: Bool = false
    @Published public var fullscreen: Bool = false
    @Published public var reset: Bool = false
    @Published public var previousURL: String = "previousUrlString"
    @Published public var previousStreamID: Int? = -1
    @Published public var previousCategoryID: String? = "-Cat"

    @Published public var streamID: String = ""
    @Published public var lastStreamID: String = ""

    @Published public var channelName: String = ""
    @Published public var imageURL: String = ""
    @Published public var allowPlayback: Bool = false

}



public class PlayerItemObserver {

    @Published public var currentStatus: AVPlayer.TimeControlStatus?
    public var itemObservation: AnyCancellable?

    public init(player: AVPlayer) {

        itemObservation = player.publisher(for: \.timeControlStatus).sink { newStatus in
            print(newStatus.rawValue)
        }

    }

}
