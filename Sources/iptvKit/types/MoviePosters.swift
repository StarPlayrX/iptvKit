//
//  File.swift
//  
//
//  Created by M1 on 11/25/21.
//

import Foundation

// MARK: - MoviePoster
public struct MoviePoster: Codable {
    public let results: [Result]

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    // MARK: - Result
    public struct Result: Codable {
        public let backdropPath: String?
        public let id: Int
        public let originalTitle: String?
        public let posterPath: String?
        public let releaseDate: String?
        public let title: String

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case id = "id"
            case originalTitle = "original_title"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title = "title"
        }
    }
}
