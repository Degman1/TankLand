//
//  Tank.swift
//  TankLand
//
//  Created by David Gerard on 4/6/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class Tank:  GameObject {
    override init(name: String, initialCoords: Position) {
        var shields = false
        super.init(name: name, initialCoords: initialCoords)
        type = GameObjectType.tank
        energy = Constants.initialTankEnergy
    }
}
