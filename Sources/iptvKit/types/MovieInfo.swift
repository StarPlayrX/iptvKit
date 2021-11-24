//
//  File.swift
//  
//
//  Created by M1 on 11/23/21.
//

import Foundation


// MARK: - MovieInfo - get_vod_info&vod_id=444939
public struct MovieInfo: Codable {
    public let info: Info
    public let movieData: MovieData

    enum CodingKeys: String, CodingKey {
        case info
        case movieData = "movie_data"
    }
    
    // MARK: - Info
    public struct Info: Codable {
        public let movieImage: String
        public let genre, plot, rating, releasedate: String
        public let durationSecs: Int
        public let duration: String
        public let bitrate: Int

        enum CodingKeys: String, CodingKey {
            case movieImage = "movie_image"
            case genre = "genre"
            case plot = "plot"
            case rating = "rating"
            case releasedate = "releasedate"
            case durationSecs = "duration_secs"
            case duration = "duration"
            case bitrate = "bitrate"
        }
    }
    
    // MARK: - MovieData
    public struct MovieData: Codable {
        public let streamID: Int
        public let name: String
        public let added: String
        public let categoryID: String
        public let containerExtension: String

        enum CodingKeys: String, CodingKey {
            case streamID = "stream_id"
            case name = "name"
            case added = "added"
            case categoryID = "category_id"
            case containerExtension = "container_extension"
        }
    }
}
