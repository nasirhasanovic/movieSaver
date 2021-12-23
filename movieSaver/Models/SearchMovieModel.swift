//
//  SearchMovieModel.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import Foundation

struct SearchMoviesModel: Codable {
    var results: [Results]?

}

// MARK: - Result
struct Results: Codable {
    var adult: Bool?
    var id: Int?
    var originalTitle, overview: String?
    var popularity: Double
    var posterPath, releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
