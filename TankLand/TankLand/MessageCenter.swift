//
//  MessageCenter.swift
//  TankLand
//
//  Created by David Gerard on 4/16/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct MessageCenter {  //TODO: Should this really be a static based class?
    static var messages = [String: String]() //[id: message]
    
    static func sendMessage(id: String, message: String) {
        messages[id] = message
    }
    
    static func receiveMessage(id: String) -> String {
        if let message = messages[id] {
            return message
        }
        return ""   //TODO: anything else special??
    }
}
