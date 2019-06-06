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
    let viewHeight: CGFloat = 90

    override func setUp() {
        super.setUp()
//        recordMode = true
    }

    // MARK: - Markets with Single session
    
    func test1MarketSession() {
        viewSnapshotConfigCombos().forEach { (device, theme) in
            applyTheme(theme)
            
            let marketHourView = MarketHoursView()
            let marketHourSessions = MarketHoursSession(marketOpenTime: DisplayedTime(hour: 08, minute: 00), marketCloseTime: DisplayedTime(hour: 22, minute: 00))

            let marketDisplayInfo = MarketDisplayInfo(marketHoursSessions: [marketHourSessions], currentTime: DisplayedTime(hour: 14, minute: 00), isOpen: true, nextMarketStatusChangeText: "Closes in 8 hours")
            
            marketHourView.setUp(withMarketDisplayInfo: marketDisplayInfo)
            marketHourView.frame = CGRect(origin: .zero, size: CGSize(width: device.size.width, height: viewHeight))
            
            FBSnapshotVerifyView(marketHourView, identifier: "device_\(device)_theme_\(theme)")
        }
    }
    
    func testDisplayTimesWithMinuteOffsets_NearEdges() {
        viewSnapshotConfigCombos().forEach { (device, theme) in
            applyTheme(theme)
            
            let marketHourView = MarketHoursView()
            
            let marketInfo = MarketDisplayInfo(marketHoursSessions: [MarketHoursSession(marketOpenTime: (hour: 0, minute: 5), marketCloseTime: (hour: 23, minute: 50))],
                                               currentTime: (hour: 15, minute: 0),
                                               isOpen: true,
                                               nextMarketStatusChangeText: "Closes in 9 hours")
            
            marketHourView.setUp(withMarketDisplayInfo: marketInfo)
            marketHourView.frame = CGRect(origin: .zero, size: CGSize(width: device.size.width, height: viewHeight))
            
            FBSnapshotVerifyView(marketHourView, identifier: "device_\(device)_theme_\(theme)")
        }
    }
    
    // MARK: - Markets with Multiple sessions
    
    func test2MarketSessions() {
        viewSnapshotConfigCombos().forEach { (device, theme) in
            applyTheme(theme)
            
            let marketHourView = MarketHoursView()
            let marketInfo = MarketDisplayInfo(marketHoursSessions: [MarketHoursSession(marketOpenTime: (hour: 1, minute: 0), marketCloseTime: (hour: 5, minute: 0)),
                                                                     MarketHoursSession(marketOpenTime: (hour: 21, minute: 0), marketCloseTime: (hour: 24, minute: 0))],
                                               currentTime: (hour: 17, minute: 0),
                                               isOpen: false,
                                               nextMarketStatusChangeText: "Opens in 4 hours")
            
            marketHourView.setUp(withMarketDisplayInfo: marketInfo)
            marketHourView.frame = CGRect(origin: .zero, size: CGSize(width: device.size.width, height: viewHeight))
            
            FBSnapshotVerifyView(marketHourView, identifier: "device_\(device)_theme_\(theme)")
        }
    }
}
