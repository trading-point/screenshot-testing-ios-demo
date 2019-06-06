//
//  SnapshotTestsConfig.swift
//  SnapshotTests
//
//  Created by Natsios Konstantinos on 06/06/2019.
//  Copyright © 2019 Trading-Point. All rights reserved.
//

import Foundation
@testable import Snapshot_Testing

enum SnapshotTestsConfig {
    static let devicesForViewControllerSnapshots = [Device.phone4inch,
                                                    Device.phone4_7inch,
                                                    Device.phone5_8inch,
                                                    Device.pad]
    
    static let devicesForViewSnapshots = [Device.phone4inch,
                                          Device.pad]
}

internal func themeSnapshotConfigCombos() -> [Theme] {
    return [Theme.light, Theme.dark]
}

internal func viewSnapshotConfigCombos() -> [(Device, Theme)] {
    let combosLightTheme = combos([Device.phone4inch], [Theme.light])
    let combosDarkTheme = combos([Device.pad], [Theme.dark])
    let combosForViewSnapshots = combosDarkTheme + combosLightTheme
    return combosForViewSnapshots
}
