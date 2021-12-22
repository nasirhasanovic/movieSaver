//
//  SearchViewModel.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import Foundation

class SearchViewModel{
    var movieName: Box<String> = Box("")
    var results : [Results] = []
    var reloader : Box<Bool> = Box(false)
    
    
    
    func updateMovieName(movie: String){
        movieName.value = movie
        searchForMovies(movie: movieName.value)
    }
    
    func searchForMovies(movie: String){
        self.results.removeAll()
        MoviewWorker().searchMovies(movieName: movie) { [weak self] movies in
            if let resluts = movies.results{
                self?.results.append(contentsOf: resluts)
                self?.reloader.value = true
            }
            print(movies)
        } failure: { error in
            print(error)
        }

    }
}
