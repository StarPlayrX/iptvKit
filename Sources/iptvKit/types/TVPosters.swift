//
//  File.swift
//  
//
//  Created by M1 on 11/28/21.
//

import Foundation

// MARK: - MoviePoster
public struct TVPoster: Codable {
    public let results: [Result]

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    // MARK: - Result
    public struct Result: Codable {
        public let backdropPath: String
        public let id: Int
        public let name: String
        public let originalName: String
        public let posterPath: String

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case id = "id"
            case name = "name"
            case originalName = "original_name"
            case posterPath = "poster_path"
        }
    }
}


