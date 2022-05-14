//
//  MonitoringView.swift
//  Rivery
//
//  Created by MacBook Noob on 06/05/22.
//

import UIKit
import Foundation
import SnapKit

class MonitoringView: UIView {
    lazy var riverNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sungai Sukabanjir"
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
    }
    
    //custom views should override this to return true if
    //they cannot layout correctly using autoresizing.
    //from apple docs https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
