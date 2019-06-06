//
//  TestSuiteUserDefaults.swift
//  SnapshotTests
//
//  Created by Natsios Konstantinos on 06/06/2019.
//  Copyright © 2019 Trading-Point. All rights reserved.
//

import Foundation

class TestSuiteUserDefaults: UserDefaults {
    
    private static let suiteName = "Test Suite"
    
    convenience init() {
        self.init(suiteName: TestSuiteUserDefaults.suiteName)!
    }
    
    static func reset() {
        UserDefaults().removePersistentDomain(forName: TestSuiteUserDefaults.suiteName)
    }
}
