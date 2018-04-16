//
//  Mine.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

//can also use mines as missiles, so instead of placing them on the location of the tank that is placing it, send it directly to the target position
class Mine: GameObject {
     init(initialCoords: Position) {
        super.init(name: "\(GameObjectType.mine)", initialCoords: initialCoords)
        type = GameObjectType.mine
    }
    
    func setEnergy(_ energyAmount: Int) {
        energy = energyAmount
    }
}
