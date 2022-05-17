//
//  MonitoringView.swift
//  Rivery
//
//  Created by MacBook Noob on 06/05/22.
//

import UIKit
import Foundation
import SnapKit
import GTProgressBar

class MonitoringView: UIView {
    lazy var riverNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "cloudy-day-3")
        return imageView
    }()
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Cloudy Day"
        label.textColor = .black
        label.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "30°C"
        label.textColor = .black
        label.font = UIFont(name: "ArialRoundedMTBold", size: 35)
        return label
    }()
    
    lazy var riverHeightBar: GTProgressBar = {
        let bar = GTProgressBar()
        bar.progress = 0.5
        bar.orientation = .vertical
        bar.barBorderColor = .black
        bar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        bar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        bar.barBorderWidth = 1
        bar.barFillInset = 2
        bar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        bar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        bar.font = UIFont.boldSystemFont(ofSize: 18)
        bar.labelPosition = GTProgressBarLabelPosition.bottom
        bar.direction = GTProgressBarDirection.clockwise
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor(red: 0.65, green: 0.91, blue: 0.98, alpha: 1.00)
        
        addSubview(riverNameLabel)
        addSubview(weatherImageView)
        addSubview(weatherLabel)
        addSubview(temperatureLabel)
        addSubview(riverHeightBar)
        
        riverHeightBar.displayLabel = false
        
        setupLayout()
    }
    
    private func setupLayout() {
        riverNameLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(5)
            make.leftMargin.equalTo(5)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(riverNameLabel.snp.bottom).offset(5)
            make.leftMargin.equalTo(5)
            make.width.equalTo(140)
            make.height.equalTo(120)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).inset(20)
            make.leftMargin.equalTo(5)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(riverNameLabel.snp.bottom).offset(5)
            make.leftMargin.equalTo(weatherImageView.snp.right).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(120)
        }
        
        riverHeightBar.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(10)
            make.bottomMargin.equalTo(weatherLabel.snp.bottom)
            make.rightMargin.equalToSuperview().inset(30)
            make.width.equalTo(50)
        }
    }
    
    //custom views should override this to return true if
    //they cannot layout correctly using autoresizing.
    //from apple docs https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
