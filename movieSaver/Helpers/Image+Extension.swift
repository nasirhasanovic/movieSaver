//
//  Image+Extension.swift
//  movieSaver
//
//  Created by NasirHasanovic on 20. 12. 2021..
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
var imageUrlString : String?

extension UIImageView{
    
    
    func loadThumbnail(url: URL) {
        
        imageUrlString = url.absoluteString
        
        let stringUrl = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: stringUrl as NSString) as? UIImage{
            self.image = imageFromCache
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                    if let imageToCache = UIImage(data: data) {
                        if imageUrlString == url.absoluteString{
                            self?.self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    }
            }
        }
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.image = UIImage(data: data)
             }
          }
       }).resume()
    }
}
