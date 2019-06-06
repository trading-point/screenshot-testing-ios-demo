//
//  ThemeManager.swift
//  Snapshot Testing
//
//  Created by Natsios Konstantinos on 06/06/2019.
//  Copyright © 2019 Trading-Point. All rights reserved.
//

import Foundation
import UIKit

enum Theme: Int {
    case light  // the first one is the default
    case dark

    var white: UIColor {
        switch self {
        case .dark:
            return UIColor(white: 34.0 / 255.0, alpha: 1.0)
        case .light:
            return UIColor(white: 1.0, alpha: 1.0)
        }
    }
}

class ThemeManager {
    static let sharedInstance: ThemeManager = ThemeManager() // declare it as var so that tests can reset it with different userdefaults
    var userDefaults: UserDefaults
    
    var currentTheme: Theme {
        let storedTheme = userDefaults.integer(forKey: "selectedTheme")
        return Theme(rawValue: storedTheme) ?? Theme.light
    }
    
    private init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func set(theme: Theme) {
        userDefaults.set(theme.rawValue, forKey: "selectedTheme")
        userDefaults.synchronize()
    }
}
