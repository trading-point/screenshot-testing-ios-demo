//
//  Helper.swift
//  XM-SnapshotTesting
//
//  Created by Konstantinos Natsios on 02/04/2019.
//  Copyright © 2019 Nutsios. All rights reserved.
//

import Foundation

typealias DisplayedTime = (hour: Int, minute: Int)

struct MarketHoursSession {
    let marketOpenTime: DisplayedTime
    let marketCloseTime: DisplayedTime
}

struct MarketDisplayInfo {
    let marketHoursSessions: [MarketHoursSession]
    let currentTime: DisplayedTime
    let isOpen: Bool
    let nextMarketStatusChangeText: String
}
