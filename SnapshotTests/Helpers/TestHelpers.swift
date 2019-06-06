//
//  TestHelpers.swift
//  SnapshotTests
//
//  Created by Natsios Konstantinos on 06/06/2019.
//  Copyright © 2019 Trading-Point. All rights reserved.
//

import Foundation
@testable import Snapshot_Testing

internal func combos<A, B>(_ xs: [A], _ ys: [B]) -> [(A, B)] {
    return xs.flatMap { x in
        return ys.map { y in
            return (x, y)
        }
    }
}

extension ThemeManager {
    static func setUp(userDefaults: UserDefaults) {
        sharedInstance.userDefaults = userDefaults
    }
}
