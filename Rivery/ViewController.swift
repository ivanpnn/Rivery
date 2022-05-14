//
//  ViewController.swift
//  Rivery
//
//  Created by MacBook Noob on 15/03/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.259, green: 0.761, blue: 1, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Rivery"
        label.font = UIFont(name: "Georgia-BoldItalic", size: 30)
        return label
    }()
    
    let monitoringView = MonitoringView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.topMargin.equalTo(-25)
            make.height.equalTo(175)
        }
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
        }
        
        self.view.addSubview(monitoringView)
        monitoringView.layer.masksToBounds = true
        monitoringView.layer.cornerRadius = 20
        monitoringView.snp.makeConstraints { make in
            make.leftMargin.equalTo(20)
            make.rightMargin.equalTo(-20)
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.height.equalTo(225)
        }
        
//        let customView = MonitoringView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 300))
//        self.view.addSubview(customView)
        // Do any additional setup after loading the view.
    }


}

