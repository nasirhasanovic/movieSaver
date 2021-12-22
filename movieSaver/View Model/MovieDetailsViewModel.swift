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
    
    private var movieID: Int = 0
    
    func updateMovieId(id: Int){
        movieID = id
    }
    
    func getMovieDetails(){
        MoviewWorker().getMovieDetails(id: movieID) { [weak self ] movieDetals in
            self?.movieDetals = movieDetals
            self?.dataLoaded.value = true
        } failure: { error in
            print(error)
        }

    }
    
}
