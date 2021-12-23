//
//  NoConnectionExtension.swift
//  movieSaver
//
//  Created by NasirHasanovic on 22. 12. 2021..
//

import Foundation
import UIKit
import Network

let monitor = NWPathMonitor()
let queue = DispatchQueue(label: "Internet")
var isConnected = false

extension UIViewController {
    func checkConnection(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                isConnected = true
            } else{
                isConnected = false
                self.createNoConnectionAlert()
                print("There's no internet connection.")
            }
        }
        monitor.start(queue: queue)
    }
}

extension UIViewController{
    func createNoConnectionAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title:"Connection issue!",message: "Please check your internet connection and try again.",
                                          preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                if isConnected == false {
                    self.checkConnection()
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
