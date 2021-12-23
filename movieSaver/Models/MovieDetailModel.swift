//
//  MovieDetailModel.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import Foundation

// MARK: - MovieDetailsModel
struct MovieDetailsModel: Codable {
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var imdbID, originalTitle, overview: String?
    var posterPath: String?
    var releaseDate: String?
    var revenue, runtime: Int?
    var status, tagline, title: String?
    var voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre
struct Genre: Codable {
    var name: String
}


