//
//  GameObject.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class GameObject: CustomStringConvertible {
    var name: String     //cant make this a constant since it needs to be changed in the init override in subclasses
    var energy: Int = 0
    var type: GameObjectType      //cant make this a constant since it needs to be changed in the init override in subclasses
    var coords: Position
    var alive: Bool = true    //turn false once energy <= 0
    let id: Int
    static var idCounter = 0
    
    init(name: String, initialCoords: Position) {
        self.name = name
        self.coords = initialCoords
        type = GameObjectType.gameObject
        id = GameObject.idCounter
        GameObject.idCounter += 1
    }
    
    var description: String {
        return "\(energy) \(name) \(coords)"
    }
}
