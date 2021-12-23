//
//  MovieDetailsViewModel.swift
//  movieSaver
//
//  Created by NasirHasanovic on 22. 12. 2021..
//


import Foundation

class MovieDetailsViewModel{
    
    var movieDetals : MovieDetailsModel?
    var dataLoaded : Box<Bool> = Box(false)
    var deletedMovies : [MovieDetailsModel] = []
    var isFavourit : Box<Bool> = Box(false)
    var arrayOfMovies : [MovieDetailsModel] = []
    
    private var movieID: Int = 0
    
    func updateMovieId(id: Int) {
        movieID = id
    }
    
    func getMovieDetails() {
        MoviewWorker().getMovieDetails(id: movieID) { [weak self ] movieDetals in
            self?.movieDetals = movieDetals
            if let fav = self?.arrayOfMovies{
                for movies in fav{
                    if self?.movieDetals?.id == movies.id {
                        self?.isFavourit.value = true
                    }
                }
            }
            self?.dataLoaded.value = true
        } failure: { error in
            print(error)
        }
    }
    
    func deleteMovie() {
        let ID = movieDetals?.id
        arrayOfMovies = arrayOfMovies.filter{$0.id != ID}
    }
    
    func addMovie() {
        if let fav = movieDetals {
            self.arrayOfMovies.append(fav)
            
        }
    }
}
