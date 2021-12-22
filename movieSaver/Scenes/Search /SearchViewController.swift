//
//  SearchViewController.swift
//  movieSaver
//
//  Created by NasirHasanovic on 21. 12. 2021..
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var moviesTable: UITableView!{
        didSet{
            setTableView()
        }
    }
    
    private var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setUI()
    }
    
    func setTableView(){
        self.moviesTable.delegate = self
        self.moviesTable.dataSource = self
        self.moviesTable.rowHeight = 60
        let cell = UINib(nibName: String(describing: SearchMovieCell.self), bundle: nil)
        moviesTable.register(cell, forCellReuseIdentifier: String(describing: SearchMovieCell.self))
    }
    
    func setUI() {
        searchField.becomeFirstResponder()
        
        let contentView: UIView = UIView(frame: CGRect(x: 0, y: 0, width:40, height: searchField.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: "searchIcon")
        imageView.center = contentView.center
        contentView.addSubview(imageView)
        
        searchField.rightView = contentView
        searchField.rightViewMode = .always
    }
    
    @IBAction func xBtnTapp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        if let name = searchField.text, name.count > 1{
            viewModel.updateMovieName(movie: name)
        }
    }
}

//MARK: -Data Source
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = moviesTable.dequeueReusableCell(withIdentifier: String(describing: SearchMovieCell.self), for: indexPath) as! SearchMovieCell
        
        myCell.setup(results: viewModel.results[indexPath.row])
        return myCell
    }
}

//MARK: -Table Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController()
        if let movieId = viewModel.results[indexPath.row].id {
            vc.setUpId(id: movieId)
        }
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
    }
}

private extension SearchViewController {
    func setupBindings(){
        //Start observing on viewModel variables
        self.viewModel.reloader.bind{ [weak self] in
            if $0{
                self?.moviesTable.reloadData()
            }
        }
    }
}
