//
//  FBSnapshotTestCase+Extras.swift
//  SnapshotTests
//
//  Created by Natsios Konstantinos on 06/06/2019.
//  Copyright © 2019 Trading-Point. All rights reserved.
//

import Foundation
import FBSnapshotTestCase

@testable import Snapshot_Testing

extension FBSnapshotTestCase {
    
    func applyTheme(_ theme: Theme) {
        let userDefaults = TestSuiteUserDefaults()
        userDefaults.set(theme.rawValue, forKey: "selectedTheme")
        ThemeManager.setUp(userDefaults: userDefaults)
    }
}
