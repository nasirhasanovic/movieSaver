//
//  HiddenMoviesViewController.swift
//  movieSaver
//
//  Created by NasirHasanovic on 22. 12. 2021..
//

import UIKit

class HiddenMoviesViewController: UIViewController {
    @IBOutlet weak var hiddenMoviesTable: UITableView!{
        didSet{
            setTableView()
        }
    }
    private var viewModel = HiddenMovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDeletedMovies()
    }
    
    func setTableView() {
        self.hiddenMoviesTable.delegate = self
        self.hiddenMoviesTable.dataSource = self
        self.hiddenMoviesTable.rowHeight = 60
        let cell = UINib(nibName: String(describing: SearchMovieCell.self), bundle: nil)
        hiddenMoviesTable.register(cell, forCellReuseIdentifier: String(describing: SearchMovieCell.self))
    }
    
    func loadDeletedMovies() {
        let path = dataFilePath(fileName: "Hidden.plist")
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                viewModel.arrayOfDelleted = try decoder.decode([MovieDetailsModel].self, from: data)
                hiddenMoviesTable.reloadData()
                
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    func saveDeletedMovie() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(viewModel.arrayOfDelleted)
            try data.write(to: dataFilePath(fileName: "Hidden.plist"),
                           options: .atomic)
        } catch{
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
}
//MARK: - Data Source
extension HiddenMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arrayOfDelleted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = hiddenMoviesTable.dequeueReusableCell(withIdentifier: String(describing: SearchMovieCell.self), for: indexPath) as! SearchMovieCell
        
        myCell.setupDeleted(movies: viewModel.arrayOfDelleted[indexPath.row])
        return myCell
    }
}

//MARK: - Table Delegate
extension HiddenMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.arrayOfDelleted.remove(at: indexPath.row)
        saveDeletedMovie()
        hiddenMoviesTable.reloadData()
    }
}
