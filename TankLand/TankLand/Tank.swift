//
//  Tank.swift
//  TankLand
//
//  Created by David Gerard on 4/6/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class Tank:  GameObject {
    var initialInstructions: String
    
    override init(name: String, initialCoords: Position) {
        initialInstructions = ""    //this is the instructions given to each tankat the start of the match by the owner so the tank knows which strategies/methods to use
        super.init(name: name, initialCoords: initialCoords)
        type = GameObjectType.tank
        energy = Constants.initialTankEnergy
    }
}
