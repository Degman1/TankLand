//
//  FireMissileAction.swift
//  TankLand
//
//  Created by David Gerard on 4/29/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct SendMessageAction {
    var type = Actions.SendMessage
    var message: String
    var code: String
    
    init(message: String, code: String) {
        self.message = message
        self.code = code
    }
}

struct RecieveMessageAction {
    var type = Actions.ReciveMessage
    var message: String
    var code: String
    
    init(message: String, code: String) {
        self.message = message
        self.code = code
    }
}

struct RunRadarAction {
    var type = Actions.RunRadar
    var distance: Int
    
    init(distance: Int) {
        self.distance = distance
    }
}

struct SetShieldAction {
    var shieldEnergy: Int
    
    init(shieldEnergy: Int) {
        self.shieldEnergy = shieldEnergy
    }
}

struct DropMineAction {
    var energy: Int
    
    init(withEnergyOf: Int) {
        energy = withEnergyOf
    }
}

struct DropRoverAction {
    var energy: Int
    var direction: Direction?   //if nil, set direction to random
    
    init(withEnergyOf: Int, inDirection: Direction?) {
        energy = withEnergyOf
        direction = inDirection
    }
}

struct FireMissileAction {
    var type = Actions.FireMissile
    var coords: Int
    var storedEnergy: Int
    
    init(coords: Int, storedEnergy: Int) {
        self.coords = coords
        self.storedEnergy = storedEnergy
    }
}

struct MoveAction {
    var direction: Direction
    var distance: Int
    
    init(inDirection: Direction, withDistance: Int) {
        direction = inDirection
        if withDistance >= 0 && withDistance <= 3 {
            distance = withDistance
        } else {
            logger.warning("Invalid Action: Unable to move game object less than zero spaces or more than three")
            distance = 0
        }
    }
}
