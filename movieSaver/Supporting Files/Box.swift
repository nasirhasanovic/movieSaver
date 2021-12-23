//
//  Box.swift
//  movieSaver
//
//  Created by NasirHasanovic on 20. 12. 2021..
//

import Foundation
//MARK: - Class for data observing
class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
