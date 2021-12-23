//
//  ApiManager.swift
//  movieSaver
//
//  Created by NasirHasanovic on 20. 12. 2021..


import Foundation

class MoviewWorker{
    func getMovieDetails(id: Int, success: @escaping (MovieDetailsModel) -> Void, failure: @escaping (Error)  -> Void){
        
        URLSession.shared.request(
            api: .fetchMovie(id),
            expecting: MovieDetailsModel.self,
            parameters: nil,
            method: .get,
            completionHandler: { [weak self] result in
                switch result {
                case .failure(let error):
                    failure(error)
                case .success(let movie):
                    success(movie)
                }
            })
    }
    
    func searchMovies(movieName: String, success: @escaping (SearchMoviesModel) -> Void, failure: @escaping (Error)  -> Void){
        
        URLSession.shared.request(
            api: .searchMovie(movieName),
            expecting: SearchMoviesModel.self,
            parameters: nil,
            method: .get,
            completionHandler: { [weak self] result in
                switch result {
                case .failure(let error):
                    failure(error)
                case .success(let movies):
                    success(movies)
                }
            })
    }
    
}

