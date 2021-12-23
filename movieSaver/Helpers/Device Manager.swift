//
//  Device Manager.swift
//  movieSaver
//
//  Created by NasirHasanovic on 23. 12. 2021..
//

import Foundation
import UIKit

class DeviceManager {
    
    public static func isSmallScreen() -> Bool {
        if UIScreen.main.nativeBounds.height < 1335 {
            return true
        } else {
            return false
        }
    }
    public static func isMiddleSizeScreen() -> Bool {
        if (UIScreen.main.nativeBounds.height > 1335) && (UIScreen.main.nativeBounds.height < 2437) {
            return true
        } else {
            return false
        }
    }
}
