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
            posterImage.isHidden = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var favouriteLabel: UILabel!
    @IBOutlet weak var hiddenBtn: UIButton!
    @IBOutlet weak var hideLabel: UILabel!
    @IBOutlet weak var plotText: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    
    private var viewModel = MovieDetailsViewModel()
    private var baseUrl = "https://www.themoviedb.org/t/p/original"
    var movieD = MovieDetailsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavourit()
        setView()
        viewModel.getMovieDetails()
        setBindings()
        loadDeletedMovies()
        checkConnection()
    }
    
    func setUpId(id: Int) {
        viewModel.updateMovieId(id: id)
    }
    
    func setView() {
        addBtn.layer.cornerRadius = addBtn.frame.height / 2
        hiddenBtn.layer.cornerRadius = hiddenBtn.frame.height / 2
        
        if DeviceManager.isSmallScreen() {
            posterHeight.constant = 100
        }
    }
    
    func setUI(movieData: MovieDetailsModel) {
        baseUrl += movieData.posterPath ?? ""
        if let posterUrl = URL(string: baseUrl) {
            posterImage.load(url: posterUrl)
        }
        posterImage.isHidden = false
        titleLabel.text = movieData.originalTitle
        plotText.text = movieData.overview
        if movieData.voteAverage == 0{
            ratingLabel.text = "No rating"
        } else {
            ratingLabel.text = "Rating: \(movieData.voteAverage ?? 0)"
        }
    }
    
    func setNeutralText() {
        hideLabel.textColor = UIColor.lightGray
        favouriteLabel.textColor = UIColor.lightGray
        hideLabel.text = "Hidde?"
        favouriteLabel.text = "Favourite?"
    }
    
    func addedToFav() {
        hideLabel.textColor = UIColor.lightGray
        favouriteLabel.textColor = UIColor.systemGreen
        addBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
        hideLabel.text = "!Favourite"
        favouriteLabel.text = "Favourite!"
    }
    
    func loadFavourit() {
        let path = dataFilePath(fileName: "FavouritMovies.plist")
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                viewModel.arrayOfMovies = try decoder.decode([MovieDetailsModel].self, from: data)
                
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    func loadDeletedMovies() {
        let path = dataFilePath(fileName: "Hidden.plist")
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                viewModel.deletedMovies = try decoder.decode([MovieDetailsModel].self, from: data)
                
            } catch {
                print("Error decoding item: \(error.localizedDescription)")
            }
        }
    }
    
    func saveMovie(isSaving: Bool) {
        let encoder = PropertyListEncoder()
        do {
            if isSaving{
                let data = try encoder.encode(viewModel.arrayOfMovies)
                try data.write(to: dataFilePath(fileName: "FavouritMovies.plist"),
                               options: .atomic)
            } else{
                let data = try encoder.encode(viewModel.deletedMovies)
                try data.write(to: dataFilePath(fileName: "Hidden.plist"),
                               options: .atomic)
            }
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    @IBAction func saveBtnTapp(_ sender: Any) {
        viewModel.addMovie()
        saveMovie(isSaving: true)
        loadFavourit()
        addBtn.layer.backgroundColor = UIColor.clear.cgColor
        addBtn.isUserInteractionEnabled = false
        addBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
        viewModel.isFavourit.value = true
    }
    @IBAction func hideMovieTapp(_ sender: Any) {
        if let hideMovie = viewModel.movieDetals{
            if viewModel.isFavourit.value{
                viewModel.deleteMovie()
                addBtn.setImage(UIImage(named: "checkGreen"), for: .normal)
                saveMovie(isSaving: true)
                addBtn.isUserInteractionEnabled = true
                viewModel.isFavourit.value = false
            }else{
                viewModel.deletedMovies.append(hideMovie)
                saveMovie(isSaving: false)
                self.dismiss(animated: true, completion: nil)
            }
        }
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
        self.viewModel.isFavourit.bind{ [weak self] in
            if $0{
                self?.addBtn.isUserInteractionEnabled = false
                self?.addBtn.layer.backgroundColor = UIColor.clear.cgColor
                self?.addedToFav()
            }else{
                self?.setNeutralText()
            }
        }
    }
}

public extension UIViewController {
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath(fileName: String) -> URL {
        return documentsDirectory().appendingPathComponent(fileName)
    }
}

