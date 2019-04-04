//
//  MarketHoursRangeView.swift
//  XM-SnapshotTesting
//
//  Created by Konstantinos Natsios on 02/04/2019.
//  Copyright © 2019 Nutsios. All rights reserved.
//

import UIKit

class MarketHoursRangeView: UIView {
    struct Dimensions {
        static let currentTimeHeight: CGFloat = 18.0
        static let progressBarHeight: CGFloat = 6.0
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var currentTimeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    // MARK: - Overridden Properties
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: Dimensions.currentTimeHeight)
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    // MARK: - Public Methods
    
    func createRangeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .green
        self.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.height.equalTo(self.backgroundView)
            make.centerY.equalTo(self.backgroundView)
        }
        
        return view
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(self.backgroundView)
        addSubview(self.currentTimeView)
    }
    
    private func addConstraints() {
        self.backgroundView.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(Dimensions.progressBarHeight)
        }
        
        self.currentTimeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(Dimensions.currentTimeHeight)
            make.width.equalTo(2.0)
        }
    }
}
