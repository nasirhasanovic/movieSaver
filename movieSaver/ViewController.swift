//
//  ViewController.swift
//  movieSaver
//
//  Created by NasirHasanovic on 20. 12. 2021..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }


}

