
//
//  MarketHoursView.swift
//  XM-SnapshotTesting
//
//  Created by Konstantinos Natsios on 02/04/2019.
//  Copyright © 2019 Nutsios. All rights reserved.
//

import UIKit
import SnapKit

class MarketHoursView: UIView {
    struct Dimensions {
        static let horizontalMargin: CGFloat = 20.0
        static let bottomMargin: CGFloat = 13.0
        static let topMargin: CGFloat = 17.0
    }
    
    var marketDisplayInfo: MarketDisplayInfo?
    
    // MARK: - LifeCycle
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        addConstraints()
        setUpViews()
        performUpdatesForNeedsRedrawing()
        NotificationCenter.default.addObserver(self, selector: #selector(performUpdatesForNeedsRedrawing), name: Notification.Name("com.xm.notification.name.UI.needsRedrawing"), object: nil)
    }
    
    func setUpViews() {
        self.marketIsLabel.text = "Market is "
        guard let marketDisplayInfo = self.marketDisplayInfo else { return }
        self.setUpForMarketStatus(isOpen: marketDisplayInfo.isOpen)
        self.nextMarketStatusChangeLabel.text = marketDisplayInfo.nextMarketStatusChangeText
        performUpdatesForNeedsRedrawing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Properties
    
    private lazy var marketIsOpenStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.addArrangedSubview(self.marketIsLabel)
        stackView.addArrangedSubview(self.openClosedLabel)
        
        return stackView
    }()
    
    private lazy var marketIsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    private lazy var nextMarketStatusChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    private lazy var marketHoursStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        for i in [Int](0...12) {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "\(i * 2)"
            label.textColor = UIColor.gray
            stackView.addArrangedSubview(label)
        }
        return stackView
    }()
    
    private lazy var marketHoursRangeView: MarketHoursRangeView = {
        let marketHoursRangeView = MarketHoursRangeView()
        return marketHoursRangeView
    }()
    
    private lazy var openClosedLabel: PaddingLabel = {
        let paddingLabel = PaddingLabel(padding: UIEdgeInsets(top: 2.0, left: 5, bottom: 1.0, right: 5))
        paddingLabel.textColor = .white
        return paddingLabel
    }()
    
    
    // MARK: Public Methods
    
    func setUp(withMarketDisplayInfo marketDisplayInfo: MarketDisplayInfo) {
        self.marketDisplayInfo = marketDisplayInfo
        self.layoutIfNeeded()
        setUpRangeViews(forMarketHoursSessions: marketDisplayInfo.marketHoursSessions)
        setUpCurrentTimeViewCenterConstraint(forTime: marketDisplayInfo.currentTime)
        setUpForMarketStatus(isOpen: marketDisplayInfo.isOpen)
        self.nextMarketStatusChangeLabel.text = marketDisplayInfo.nextMarketStatusChangeText
    }
    
    
    @objc func performUpdatesForNeedsRedrawing() {
        backgroundColor = ThemeManager.sharedInstance.currentTheme.white
    }
    // MARK: - Private Methods
    
    private func setUpRangeViews(forMarketHoursSessions marketHoursSessions: [MarketHoursSession]) {
        for marketHoursSession in marketHoursSessions {
            let rangeView = self.marketHoursRangeView.createRangeView()
            setUpOpenHoursRangeLeftConstraint(forTime: marketHoursSession.marketOpenTime, rangeView: rangeView)
            setUpOpenHoursRangeRightConstraint(forTime: marketHoursSession.marketCloseTime, rangeView: rangeView)
        }
    }
    
    private func setUpCurrentTimeViewCenterConstraint(forTime time: DisplayedTime) {
        let indexOfHourLabel = time.hour / 2
        let hourLabel = marketHoursStackView.arrangedSubviews[indexOfHourLabel]
        let (offsetFromHourLabel, hourLabelConstraint) = calculateOffset(fromHourLabel: hourLabel, forDisplayedTime: time)
        
        marketHoursRangeView.currentTimeView.snp.makeConstraints { make in
            make.centerX.equalTo(hourLabelConstraint).offset(offsetFromHourLabel)
        }
        marketHoursRangeView.bringSubviewToFront(marketHoursRangeView.currentTimeView)
    }
    
    private func setUpOpenHoursRangeLeftConstraint(forTime time: DisplayedTime, rangeView: UIView) {
        let indexOfHourLabel = time.hour / 2
        let hourLabel = marketHoursStackView.arrangedSubviews[indexOfHourLabel]
        let (offsetFromHourLabel, hourLabelConstraint) = calculateOffset(fromHourLabel: hourLabel, forDisplayedTime: time)
        
        rangeView.snp.makeConstraints { make in
            make.left.equalTo(hourLabelConstraint).offset(offsetFromHourLabel)
        }
    }
    
    private func setUpOpenHoursRangeRightConstraint(forTime time: DisplayedTime, rangeView: UIView) {
        let indexOfHourLabel = time.hour / 2
        let hourLabel = marketHoursStackView.arrangedSubviews[indexOfHourLabel]
        let (offsetFromHourLabel, hourLabelConstraint) = calculateOffset(fromHourLabel: hourLabel, forDisplayedTime: time)
        
        rangeView.snp.makeConstraints { make in
            make.right.equalTo(hourLabelConstraint).offset(offsetFromHourLabel)
        }
    }
    
    private func setUpForMarketStatus(isOpen: Bool) {
        if isOpen {
            self.openClosedLabel.backgroundColor = .green
            self.openClosedLabel.text = "Open"
        } else {
            self.openClosedLabel.backgroundColor = .gray
            self.openClosedLabel.text = "Closed"
        }
    }
    
    private func calculateOffset(fromHourLabel hourLabel: UIView, forDisplayedTime displayedTime: DisplayedTime) -> (CGFloat, ConstraintItem) {
        guard displayedTime.hour != 24 else { return  (0, hourLabel.snp.right) }
        
        let indexOfHourLabel = displayedTime.hour / 2
        let fullDistanceToNextLabel = distanceUntilNextLabel(forLabelAtIndex: indexOfHourLabel)
        let percentageFilled = CGFloat(percentageOfDistanceFilled(forTime: displayedTime))
        let distanceFilled = fullDistanceToNextLabel * percentageFilled
        switch displayedTime {
        case let (hour, _) where hour <= 1:
            return (distanceFilled, hourLabel.snp.left)
        default:
            return (distanceFilled, hourLabel.snp.centerX)
        }
    }
    
    private func distanceUntilNextLabel(forLabelAtIndex index: Int) -> CGFloat {
        let label =  self.marketHoursStackView.arrangedSubviews[index]
        let nextLabel = self.marketHoursStackView.arrangedSubviews[index + 1]
        
        if index == 0 {
            return self.distanceBetween(startOfLabel: label, toCenterOfLabel: nextLabel)
        } else if index == (24/2) - 1 {
            return self.distanceBetween(centerOfLabel: label, toEndOfLabel: nextLabel)
        } else {
            return self.distanceBetween(centerOfLabel: label, toCenterOfLabel: nextLabel)
        }
    }
    
    private func distanceBetween(startOfLabel firstLabel: UIView, toCenterOfLabel secondLabel: UIView) -> CGFloat {
        return secondLabel.center.x - firstLabel.frame.origin.x
    }
    
    private func distanceBetween(centerOfLabel firstLabel: UIView, toCenterOfLabel secondLabel: UIView) -> CGFloat {
        return secondLabel.center.x - firstLabel.center.x
    }
    
    private func distanceBetween(centerOfLabel firstLabel: UIView, toEndOfLabel secondLabel: UIView) -> CGFloat {
        return secondLabel.frame.width + secondLabel.frame.origin.x - firstLabel.center.x
    }
    
    private func percentageOfDistanceFilled(forTime time: DisplayedTime) -> Float {
        let percentageHourfilled: Float = time.hour % 2 != 0 ? 0.50 : 0
        let percentageMinutesfilled = (Float(time.minute) / 60) * 0.5
        return percentageMinutesfilled + percentageHourfilled
    }
    
    private func addSubviews() {
        addSubview(self.marketIsOpenStackView)
        addSubview(self.nextMarketStatusChangeLabel)
        addSubview(self.marketHoursStackView)
        addSubview(self.marketHoursRangeView)
    }
    
    private func addConstraints() {
        self.marketIsOpenStackView.snp.makeConstraints { make in
            make.left.equalTo(self.marketHoursStackView)
            make.top.equalToSuperview().inset(Dimensions.topMargin)
            make.right.lessThanOrEqualTo(self.nextMarketStatusChangeLabel.snp.left).offset(-5.0)
        }
        
        self.nextMarketStatusChangeLabel.snp.makeConstraints { make in
            make.right.equalTo(self.marketHoursStackView)
            make.centerY.equalTo(self.marketIsOpenStackView)
        }
        
        self.marketHoursStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Dimensions.horizontalMargin)
            make.bottom.equalToSuperview().inset(Dimensions.bottomMargin)
        }
        
        self.marketHoursRangeView.snp.makeConstraints { make in
            make.width.centerX.equalTo(self.marketHoursStackView)
            make.bottom.equalTo(self.marketHoursStackView.snp.top).inset(2.0)
        }
    }
}
