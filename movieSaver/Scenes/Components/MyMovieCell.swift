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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
