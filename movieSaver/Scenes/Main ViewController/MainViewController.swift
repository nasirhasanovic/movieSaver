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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(navigateToSearch))
        searchView.addGestureRecognizer(tap)
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
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = moviesCollection.dequeueReusableCell(withReuseIdentifier: String(describing: MyMovieCell.self), for: indexPath) as! MyMovieCell
        
        return myCell
    }
    
    
}

extension MainViewController: UICollectionViewDelegate{
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: moviesCollection.frame.width - 40, height: moviesCollection.frame.height - 10)
    }
}
