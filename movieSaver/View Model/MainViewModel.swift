//
//  MainViewModel.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import Foundation

class MainViewModel{
    var favouriteMovies : [MovieDetailsModel] = []
    var dataLoad : Box<Bool> = Box(false)
}
