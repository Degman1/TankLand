//
//  FireMissileAction.swift
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

struct SendMessageAction: PreAction {
    var action: Actions
    var message: String
    var code: String
    
    init(message: String, code: String) {
        action = .SendMessage
        self.message = message
        self.code = code
    }
    
    var description: String {
        return "\(action) \(code)"
    }
}

struct RecieveMessageAction: PreAction {
    var action: Actions
    var code: String
    
    init(message: String, code: String) {
        action = .ReciveMessage
        self.code = code
    }
    
    var description: String {
        return "\(action) \(code)"
    }
}

struct RunRadarAction: PreAction {
    var action: Actions
    var distance: Int
    
    init(distance: Int) {
        action = .RunRadar
        self.distance = distance
    }
    
    var description: String {
        return "\(action) \(distance)"
    }
}

struct SetShieldAction: PreAction {
    var action: Actions
    var energy: Int
    
    init(energy: Int) {
        action = .SetShields
        self.energy = energy
    }
    
    var description: String {
        return "\(action) \(energy)"
    }
}

struct DropMineAction: PostAction {
    var action: Actions
    var energy: Int
    
    init(energy: Int) {
        action = .DropMine
        self.energy = energy
    }
    
    var description: String {
        return "\(action) \(energy)"
    }
}

struct DropRoverAction: PostAction {
    let action: Actions
    let energy: Int
    let direction: Direction?
    
    init(energy: Int, direction: Direction?) {
        action = .DropRover
        self.energy = energy
        self.direction = direction
    }
    
    var description: String {
        return "\(action) \(energy) \(String(describing: direction))"
    }
}

struct FireMissileAction: PostAction {
    let action: Actions
    let coords: Int
    let energy: Int
    
    init(coords: Int, energy: Int) {
        action = .FireMissile
        self.coords = coords
        self.energy = energy
    }
    
    var description: String {
        return "\(action) \(coords) \(energy)"
    }
}

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
