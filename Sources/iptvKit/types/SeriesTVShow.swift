//
//  File.swift
//  
//
//  Created by M1 on 11/22/21.
//

import Foundation


// MARK: - SeriesTVShow
public struct SeriesTVShow: Codable {
    public let num: Int
    public let name: String
    public let seriesID: Int
    public let cover: String
    public let plot: String
    public let cast: String
    public let director: String
    public let genre: String
    public let releaseDate: String
    public let lastModified: String
    public let rating: String
    public let rating5Based: Double
    public let youtubeTrailer: String
    public let episodeRunTime: String
    public let categoryID: String
    public var uuid: UUID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case num = "num"
        case name = "name"
        case seriesID = "series_id"
        case cover = "cover"
        case plot = "plot"
        case cast = "cast"
        case director = "director"
        case genre = "genre"
        case releaseDate = "releaseDate"
        case lastModified = "last_modified"
        case rating = "rating"
        case rating5Based = "rating_5based"
        case youtubeTrailer = "youtube_trailer"
        case episodeRunTime = "episode_run_time"
        case categoryID = "category_id"
    }
}



typealias TVShow = [SeriesTVShow]


