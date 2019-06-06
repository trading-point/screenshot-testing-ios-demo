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

internal func combos<A, B, C>(_ xs: [A], _ ys: [B], _ zs: [C]) -> [(A, B, C)] {
    return xs.flatMap { x in
        return ys.flatMap { y in
            return zs.map { z in
                return (x, y, z)
            }
        }
    }
}
