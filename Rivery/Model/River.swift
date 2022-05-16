//
//  River.swift
//  Rivery
//
//  Created by MacBook Noob on 15/05/22.
//

import Foundation
import UIKit

@objcMembers class River: NSObject {
    let name: String
    let monitoredHeight: Int
    let maxHeight: Int
    let weather: String
    
    init(name: String, monitoredHeight: Int, maxHeight: Int, weather: String) {
        self.name = name
        self.monitoredHeight = monitoredHeight
        self.maxHeight = maxHeight
        self.weather = weather
    }
}
