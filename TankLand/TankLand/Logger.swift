//
//  Logger.swift
//  TankLand
//
//  Created by David Gerard on 4/16/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Logger {     //create a simple logger
    var majorLoggers: [GameObject]
    var turn: Int
    
    init() {
        majorLoggers = []
        turn = 0
    }
    
    mutating func log(_ message: String) {
        print(message)
    }
    
    mutating func addMajorLogger(gameObject: GameObject, message: String) {
        majorLoggers.append(gameObject)
        addLog(gameObject: gameObject, message: "\(gameObject.id): \(message)")
    }
    
    mutating func addLog(gameObject: GameObject, message: String) {
        if majorLoggers.contains(where: {$0 === gameObject}) {
            log("\(turn) \(NSDate()) \(gameObject.id) \(gameObject.position) \(message)")
        } //use === to compare refernce types
        else { log("\(turn) \(NSDate()) \(gameObject.id) does not have permission to log") }
    }
}
