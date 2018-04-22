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
    
    init() {
        print("Initializing logger")
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
