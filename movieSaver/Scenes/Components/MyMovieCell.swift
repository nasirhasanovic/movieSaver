//
//  MyMovieCell.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import UIKit

class MyMovieCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var movieImg: UIImageView!{
        didSet{
            movieImg.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!{
        didSet{
            descriptionLabel.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    
    private let baseUrl = "https://www.themoviedb.org/t/p/original"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if DeviceManager.isSmallScreen(){
            posterHeight.constant = 100
        }
    }
    
    func setup(movie: MovieDetailsModel) {
        var imageURL = ""
        titleLabel.text = movie.originalTitle
        descriptionLabel.text = movie.overview
        
        if let poster = movie.posterPath{
            imageURL = baseUrl + poster
        } else {
            print("blah")
        }
        
        if let urlPoster = URL(string: imageURL){
            DispatchQueue.main.async {
                self.movieImg.loadThumbnail(url: urlPoster)
            }
        }
    }
}
