//
//  SnapshotTestsConfig.swift
//  SnapshotTests
//
//  Created by Natsios Konstantinos on 06/06/2019.
//  Copyright © 2019 Trading-Point. All rights reserved.
//

import Foundation

enum SnapshotTestsConfig {
    static let devicesForViewControllerSnapshots = [Device.phone4inch,
                                                    Device.phone4_7inch,
                                                    Device.phone5_8inch,
                                                    Device.pad]
    
    static let devicesForViewSnapshots = [Device.phone4inch,
                                          Device.pad]
}


internal func viewSnapshotConfigCombos() -> [(Device)] {
    let comboSmall = combos([Device.phone4inch])
    let combosLarge = combos([Device.pad])
    let combosForViewSnapshots = comboSmall + combosLarge
    return combosForViewSnapshots
}

internal func viewControllerSnapshotConfigCombos() -> [(Device, Theme)] {
    let comboSmall = combos([Device.phone4inch, Device.phone4_7inch])
    let combosLarge = combos([Device.phone5_8inch, Device.pad])
    let combosForViewControllerSnapshots = comboSmall + combosLarge
    return combosForViewControllerSnapshots
}
