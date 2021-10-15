//
//  File.swift
//  
//
//  Created by M1 on 10/15/21.
//

import Foundation
import AVKit

//MARK: - 1
public class LoginObservable: ObservableObject {
    static public var shared = LoginObservable()
    @Published public var status: String = "Update"
    @Published public var port: String = "826"
    @Published public var isLoggedIn: Bool = false
    @Published public var isAutoSwitchCat: Bool = false
    @Published public var isCatActive: Bool = false
    @Published public var config: Config = nil
}

//MARK: - 2
public class CategoriesObservable: ObservableObject {
    static var cto = CategoriesObservable()
    @Published var status: String = "test"
    @Published var loggedIn: Bool = false
}

//MARK: - 3
public class ChannelsObservable: ObservableObject {
    static var shared = ChannelsObservable()
}

//MARK: - 4
public class PlayerObservable: ObservableObject {
    static public var plo = PlayerObservable()
    @Published public var miniEpg: [EpgListing] = []
    @Published public var videoController = AVPlayerViewController()
    @Published public var pip: Bool = false
    @Published public var fullscreen: Bool = false
    @Published public var reset: Bool = false
    @Published public var streamID: String = ""
    @Published public var channelName: String = ""
    @Published public var imageURL: String = ""
}
