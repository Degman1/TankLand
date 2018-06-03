//
//  GameObject.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class GameObject: CustomStringConvertible {
    let objectType: GameObjectType
    private (set) var energy: Int = 0
    var alive: Bool = true    //turn false once energy <= 0     TODO: need this?
    let id: String
    private (set) var position: Position
    
    init(row: Int, col: Int, objectType: GameObjectType, energy: Int, id: String) {
        self.objectType = objectType
        self.energy = energy
        self.id = id
        self.position = Position(col, row)
    }
    
    final func addEnergy(amount: Int) {
        energy += amount
    }
    
    final func useEnergy(amount: Int) {
        energy = (amount > energy) ? 0 : energy - amount
    }
    
    final func setPosition(newPosition: Position) {
        position = newPosition
    }
    
    var description: String {
        return "\(objectType) \(id) \(energy) \(position) "
    }
}
