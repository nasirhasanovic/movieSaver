//
//  MainViewController.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!{
        didSet{
            searchView.layer.cornerRadius = 8
            searchView.layer.borderColor = UIColor.systemGray3.cgColor
            searchView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var moviesCollection: UICollectionView!{
        didSet{
            setTable()
        }
    }
    @IBOutlet weak var hiddenMoviesView: UIView!{
        didSet{
            hiddenMoviesView.layer.cornerRadius = 8
            hiddenMoviesView.layer.borderColor = UIColor.lightGray.cgColor
            hiddenMoviesView.layer.borderWidth = 1
        }
    }
    
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        setUI()
        loadFavMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadFavMovies()
    }
    
    func setUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(navigateToSearch))
        searchView.addGestureRecognizer(tap)
        
        let tap2 =  UITapGestureRecognizer(target: self, action: #selector(navigateToHidden))
        hiddenMoviesView.addGestureRecognizer(tap2)
    }
    
    func setTable(){
        moviesCollection.dataSource = self
        moviesCollection.delegate = self
        let cell = UINib(nibName: String(describing: MyMovieCell.self), bundle: nil)
        moviesCollection.register(cell, forCellWithReuseIdentifier: String(describing: MyMovieCell.self))
    }
    
    @objc func navigateToSearch(){
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func navigateToHidden(){
        let vc = HiddenMoviesViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
    }
}
//MARK: - Data Source
extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favouriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = moviesCollection.dequeueReusableCell(withReuseIdentifier: String(describing: MyMovieCell.self), for: indexPath) as! MyMovieCell
        myCell.setup(movie: viewModel.favouriteMovies[indexPath.row])
        return myCell
    }
    
    func loadFavMovies() {
        let path = dataFilePath(fileName: "FavouritMovies.plist")
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                viewModel.favouriteMovies = try decoder.decode([MovieDetailsModel].self, from: data)
                moviesCollection.reloadData()
                
            } catch {
                print("Error decoding items: \(error.localizedDescription)")
            }
        }
    }
}

//MARK: - Collection Delegate
extension MainViewController: UICollectionViewDelegate{
    
}

//MARK: - Flow Delegate
extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.favouriteMovies.count == 1 {
            return CGSize(width: moviesCollection.frame.width, height: moviesCollection.frame.height)
        }else {
            return CGSize(width: moviesCollection.frame.width - 40, height: moviesCollection.frame.height - 10)
        }
    }
}
