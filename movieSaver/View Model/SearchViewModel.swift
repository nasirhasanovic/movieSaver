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
    var arrayOfDelleted : [MovieDetailsModel] = []
    
    
    func updateMovieName(movie: String) {
        movieName.value = movie
        searchForMovies(movie: movieName.value)
    }
    
    func searchForMovies(movie: String){
        self.results.removeAll()
        MoviewWorker().searchMovies(movieName: movie) { [weak self] movies in
            if let resluts = movies.results, let hiddenMovies = self?.arrayOfDelleted{
                self?.results.append(contentsOf: resluts)
                for deleted in hiddenMovies {
                    self?.results = self?.results.filter{$0.id != deleted.id} ?? []
                    self?.reloader.value = true
                }
                self?.reloader.value = true
            }
            print(movies)
        } failure: { error in
            print(error)
        }
        
    }
}
