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
    let name: String
    private (set) var energy: Int = 0
    var coords: Position
    var alive: Bool = true    //turn false once energy <= 0
    let id: Int
    private (set) var position: Position
    
    init(row: Int, col: Int, objectType: GameObjectType, name: String, energy: Int, id: String) {
        self.objectType = objectType
        self.name = name
        self.energy = energy
        self.id = id
        self.position = Position(row, col)
    }
    
    final func addEnergy(amount: Int) {
        energy += amount
    }
    
    final func useEnergy(amount: Int) {
        energy ? (amount > energy) ? 0: energy -= amount
    }
    
    final func setPosition(newPosition: Position) {
        position = newPosition
    }
    
    var description: String {
        return "\(objectType) \(name) \(energy) \(id) \(position) "
    }
}
