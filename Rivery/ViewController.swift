//
//  ViewController.swift
//  Rivery
//
//  Created by MacBook Noob on 15/03/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let initializedRiverList: [River] = [River(name: "Sungai Sukabanjir", monitoredHeight: 0, maxHeight: 10, weather: ""),
                                         River(name: "Sungai Sukameluap", monitoredHeight: 0, maxHeight: 20, weather: ""),
                                         River(name: "Sungai Sukahujan", monitoredHeight: 0, maxHeight: 30, weather: "")]
    var riverList: [River] = [River]()
    
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
    
    let monitoringView: MonitoringView = {
        let monitoringView = MonitoringView()
        monitoringView.layer.masksToBounds = true
        monitoringView.layer.cornerRadius = 20
        return monitoringView
    }()
    
    lazy var riverListView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var riverTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "RiverCell")
        return view
    }()
    
    lazy var riverSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        riverList = initializedRiverList
        
        setupView()
        setupLayout()
//        startMonitoring()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(red: 0.89, green: 0.99, blue: 0.98, alpha: 1.00)
        self.view.addSubview(headerView)
        headerView.addSubview(headerLabel)
        
        self.view.addSubview(monitoringView)
        self.view.addSubview(riverListView)
        riverListView.addSubview(riverSearchBar)
        riverListView.addSubview(riverTableView)
        
        riverTableView.isScrollEnabled = false
    }
    
    func setupLayout() {
        headerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.topMargin.equalTo(-25)
            make.height.equalTo(140)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
        }
        
        monitoringView.snp.makeConstraints { make in
            make.leftMargin.equalTo(20)
            make.rightMargin.equalTo(-20)
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.height.equalTo(225)
        }
        
        riverListView.snp.makeConstraints { make in
            make.topMargin.equalTo(monitoringView.snp.bottom).offset(30)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview().offset(40)
        }
        
        riverSearchBar.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.leftMargin.equalToSuperview().offset(20)
            make.rightMargin.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        riverTableView.snp.makeConstraints { make in
            make.topMargin.equalTo(riverSearchBar.snp.bottom).offset(20)
            make.leftMargin.equalToSuperview().offset(0)
            make.rightMargin.equalToSuperview().inset(0)
            make.bottomMargin.equalToSuperview().inset(0)
        }
    }
    
    func startMonitoring(){
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }

    @objc func updateCounting(){
        DispatchQueue.global(qos: .userInteractive).async {
            print("This is run on the background queue")
            let n = CGFloat.random(in: 0.0...1.0)
            print("Random Number = \(n)")
            DispatchQueue.main.async {
                self.monitoringView.riverHeightBar.progress = n
                print("This is run on the main queue, after the previous code in outer block")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riverList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RiverCell", for: indexPath)
        cell.textLabel?.text = riverList[indexPath.row].name
        print("Cekusimas name = \(riverList[indexPath.row].name)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        for index in (0..<riverList.count).reversed() {
            riverList.remove(at: index)
        }
        
        riverList = initializedRiverList
        self.riverTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let rivers = initializedRiverList as NSArray
        let riverNameBeginsWithPredicate = NSPredicate(format: "name contains[c] %@", searchBar.text!)
        print("Cekusimas searchBar = \(searchBar.text!)")
        let riverNameBeginsWith = rivers.filtered(using: riverNameBeginsWithPredicate)
        if riverNameBeginsWith.count > 0 {
            for index in (0..<riverList.count).reversed() {
                riverList.remove(at: index)
            }
        }
        (riverNameBeginsWith as! [River]).forEach { river in
            riverList.append(river)
            print("Cekusimas = \(river.name)")
            
            DispatchQueue.main.async {
                print("Cekusimas riverList = \(self.riverList[0].name)")
                self.riverTableView.reloadData()
                searchBar.resignFirstResponder()
            }
        }
        
        
    }
    
    
}

