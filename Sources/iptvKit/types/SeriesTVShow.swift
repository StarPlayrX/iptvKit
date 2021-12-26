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
    public let name, title: String
    public let year: String?
    public let seriesID: Int
    public let cover: String?
    public let plot, cast, director, genre: String?
    public let moviePosterReleaseDate, releaseDate: String?
    public let lastModified, rating: String
    public let rating5Based: Double
    public let backdropPath: [String]
    public let youtubeTrailer: String?
    public let episodeRunTime, categoryID: String
    public let categoryIDS: [Int]
    public var uuid: UUID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case num, name, title, year
        case seriesID = "series_id"
        case cover, plot, cast, director, genre
        case moviePosterReleaseDate = "release_date"
        case releaseDate
        case lastModified = "last_modified"
        case rating
        case rating5Based = "rating_5based"
        case backdropPath = "backdrop_path"
        case youtubeTrailer = "youtube_trailer"
        case episodeRunTime = "episode_run_time"
        case categoryID = "category_id"
        case categoryIDS = "category_ids"
    }
}

