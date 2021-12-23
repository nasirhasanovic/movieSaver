//
//  SearchMovieCell.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import UIKit

class SearchMovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    private var imgBase = "https://www.themoviedb.org/t/p/original"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup(results: Results){
        titleLabel.text = results.title
        yearLabel.text = results.releaseDate
        gradeLabel.text = String(format: "%.2f", results.voteAverage ?? 0.0)
    }
    
    func setupDeleted(movies: MovieDetailsModel){
        titleLabel.text = movies.title
        yearLabel.text = movies.releaseDate
        gradeLabel.text = String(format: "%.2f", movies.voteAverage ?? 0.0)
    }
    
}
