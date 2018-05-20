//
//  Action.swift
//  TankLand
//
//  Created by David Gerard on 4/29/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

//actions protocols:

protocol Action: CustomStringConvertible {
    var action: Actions {get}
    var description: String {get}
}

protocol PreAction: Action {
    
}

protocol PostAction: Action {
    
}

//action structs:

struct MoveAction: PostAction {
    let action: Actions
    let distance: Int
    let direction: Direction
    
    init(distance: Int, direction: Direction) {
        action = .Move
        self.distance = distance
        self.direction = direction
    }
    var description: String {
        return "\(action) \(distance) \(direction)"
    }
}

struct ShieldAction: PreAction {
    let action: Actions
    let power: Int
    
    init(power: Int) {
        action = .Shields
        self.power = power
    }
    
    var description: String {
        return "\(action) \(power)"
    }
}

struct MissileAction: PostAction {
    let action: Actions
    let power: Int
    let target: Position
    
    init(power: Int, target: Position) {
        action = .Missile
        self.power = power
        self.target = target
    }
    
    var description: String {
        return "\(action) \(power) \(target)"
    }
}

struct RadarAction: PreAction {
    let action: Actions
    let range: Int
    
    init(range: Int) {
        action = .Radar
        self.range = range
    }
    
    var description: String {
        return "\(action) \(range)"
    }
}

struct SendMessageAction: PreAction {
    let action: Actions
    let key: String
    let message: String
    
    init(key: String, message: String) {
        action = .SendMessage
        self.key = key
        self.message = message
    }
    
    var description: String {
        return "\(action) \(key) \(message)"
    }
}

struct ReceiveMessageAction: PreAction {
    let action: Actions
    let key: String
    
    init(key: String) {
        action = .ReceiveMessage
        self.key = key
    }
    
    var description: String {
        return "\(action) \(key)"
    }
}

struct DropMineAction: PostAction {
    let action: Actions
    let isRover: Bool
    let power: Int
    let dropDirection: Direction?
    let moveDirection: Direction?
    
    init(power: Int, isRover: Bool = false, dropDirection: Direction? = nil, moveDirection: Direction? = nil) {
        action = .DropMine
        self.isRover = isRover
        self.dropDirection = dropDirection
        self.moveDirection = moveDirection
        self.power = power
    }
    
    var description: String {
        let dropDirectionMessage = (dropDirection == nil) ? "drop direction is random" : "\(dropDirection!)"
        let moveDirectionMessage = (moveDirection == nil) ? "move direction is random" : "\(moveDirection!)"
        return "\(action) \(power) \(dropDirectionMessage) \(isRover) \(moveDirectionMessage)"
    }
}
