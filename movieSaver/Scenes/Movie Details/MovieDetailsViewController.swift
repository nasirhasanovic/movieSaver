//
//  MovieDetailsViewController.swift
//  movieSaver
//
//  Created by NasirHasanovic on 22. 12. 2021..
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImage: UIImageView!{
        didSet{
            posterImage.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var hiddenBtn: UIButton!
    @IBOutlet weak var plotText: UILabel!
    
    private var viewModel = MovieDetailsViewModel()
    private var baseUrl = "https://www.themoviedb.org/t/p/original"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        viewModel.getMovieDetails()
        setBindings()
    }
    
    func setUpId(id: Int) {
        viewModel.updateMovieId(id: id)
    }
    
    func setView() {
        addBtn.layer.cornerRadius = addBtn.frame.height / 2
        hiddenBtn.layer.cornerRadius = hiddenBtn.frame.height / 2
        
    }
    
    func setUI(movieData: MovieDetailsModel) {
        baseUrl += movieData.posterPath ?? ""
        if let posterUrl = URL(string: baseUrl) {
            posterImage.load(url: posterUrl)
        }
        titleLabel.text = movieData.originalTitle
        plotText.text = movieData.overview
        
        
    }

}

private extension MovieDetailsViewController{
    func setBindings() {
        self.viewModel.dataLoaded.bind{ [weak self] in
            if $0{
                if let movieData = self?.viewModel.movieDetals{
                    self?.setUI(movieData: movieData)
                }
            }
        }
    }
}
