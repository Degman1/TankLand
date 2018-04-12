//
//  GameObject.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class GameObject: CustomStringConvertible {
    let name: String
    var energyLevel: Int = 0
    let type: GameObjectType
    var coords: Position
    
    init(name: String, type: GameObjectType, initialCoords: Position) {
        self.name = name
        self.type = type
        self.coords = initialCoords
    }
    
    var description: String {
        return "\(type)"
    }
}
