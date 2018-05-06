//
//  Logger.swift
//  TankLand
//
//  Created by David Gerard on 4/16/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Logger {     //create a simple logger
    var loggingInfo = ""
    var majorLoggers: [GameObject]
    
    init() {
        majorLoggers = []
    }
    
    mutating func addMajorLogger(gameObject: GameObject, message: String) {
        majorLoggers.append(gameObject)
        log("\(gameObject.id): \(message)")
    }
    
    func displayLogger() -> String {
        print(loggingInfo)
        return loggingInfo
    }
    
    mutating func log(_ message: String) {
        loggingInfo += "\(message)\n"
    }
    
    mutating func warning(_ message: String) {
        loggingInfo += "⚠️\(message)⚠️\n"
    }
    
    mutating func error(_ message: String) {
        loggingInfo += "💥💥\(message)💥💥\n"
    }
}
