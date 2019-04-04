//
//  SnapshotTests.swift
//  SnapshotTests
//
//  Created by Konstantinos Natsios on 04/04/2019.
//  Copyright © 2019 Trading-Point. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import Snapshot_Testing

class SnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
//        recordMode = true
    }

    func testExample() {
        let marketOpenTime = DisplayedTime(hour: 08, minute: 00)
        let marketCloseTime = DisplayedTime(hour: 22, minute: 00)
        let marketHourSessions = MarketHoursSession(marketOpenTime: marketOpenTime, marketCloseTime: marketCloseTime)
        let currentTime = DisplayedTime(hour: 14, minute: 00)
        let marketDisplayInfo = MarketDisplayInfo(marketHoursSessions: [marketHourSessions], currentTime: currentTime, isOpen: true, nextMarketStatusChangeText: "Closes in 8 hours")
        
        let view = MarketHoursView()
        view.setUp(withMarketDisplayInfo: marketDisplayInfo)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 420, height: 100))

        FBSnapshotVerifyView(view)
    }
}
