//
//  Logger.swift
//  TankLand
//
//  Created by David Gerard on 4/16/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Logger {     //create a simple logger
    var loggingInfo: String
    var majorLoggers: [GameObject]
    
    init() {
        loggingInfo = ""
        majorLoggers = []
    }
    
    mutating func addMajorLogger(gameObject: GameObject, message: String) {
        majorLoggers.append(gameObject)
        log(message: "\(gameObject.id): \(message)")
    }
    
    mutating func log(message: String) {
        loggingInfo += "\(message)\n"
    }
}
