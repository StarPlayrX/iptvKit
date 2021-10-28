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
    
    @Published public var streamID: Int = -1
    @Published public var previousStreamID: Int = -2
    @Published public var previousCategoryID: String? = "-Cat"
    
    @Published public var channelName: String = ""
    @Published public var imageURL: String = ""
    
    @Published public var nowPlayingUrl: String = ""
}

public class SettingsObservable: ObservableObject {
    static public var shared = SettingsObservable()
    @Published public var deviceHLSXtrem: Bool = true
    @Published public var deviceHLSApple: Bool = true
    @Published public var airplayThirdParty: Bool = true
    @Published public var airplayAppleBranded: Bool = true
    @Published public var autoPlayOnSelect: Bool = true
    @Published public var stopWhenExitingPlayer: Bool = false
    @Published public var backgroundPlayback: Bool = true
}

public func savePlayerSettings() {
     let settings = SettingsObservable.shared

    UserDefaults.standard.set(settings.deviceHLSXtrem, forKey: "deviceHLSXtrem")
    UserDefaults.standard.set(settings.deviceHLSApple, forKey: "deviceHLSApple")
    UserDefaults.standard.set(settings.airplayThirdParty, forKey: "airplayThirdParty")
    UserDefaults.standard.set(settings.airplayAppleBranded, forKey: "airplayAppleBranded")
    UserDefaults.standard.set(settings.autoPlayOnSelect, forKey: "autoPlayOnSelect")
    UserDefaults.standard.set(settings.stopWhenExitingPlayer, forKey: "stopWhenExitingPlayer")
    UserDefaults.standard.set(settings.backgroundPlayback, forKey: "backgroundPlayback")
}

public func readPlayerSettings() {
     let settings = SettingsObservable.shared

    settings.deviceHLSXtrem = UserDefaults.standard.bool(forKey: "deviceHLSXtrem")
    settings.deviceHLSApple = UserDefaults.standard.bool(forKey: "deviceHLSApple")
    settings.airplayThirdParty = UserDefaults.standard.bool(forKey: "airplayThirdParty")
    settings.airplayAppleBranded = UserDefaults.standard.bool(forKey: "airplayAppleBranded")
    settings.autoPlayOnSelect = UserDefaults.standard.bool(forKey: "autoPlayOnSelect")
    settings.stopWhenExitingPlayer = UserDefaults.standard.bool(forKey: "stopWhenExitingPlayer")
    settings.backgroundPlayback = UserDefaults.standard.bool(forKey: "backgroundPlayback")
}
