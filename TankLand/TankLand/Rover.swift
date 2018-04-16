//
//  Rover.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class Rover: Mine {
    override init(initialCoords: Position) {
        super.init(initialCoords: initialCoords)
        type = GameObjectType.rover
        name = "\(GameObjectType.rover)"
    }
}
