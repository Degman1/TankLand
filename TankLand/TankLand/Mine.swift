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
    let isRover: Bool
    let moveDirection: Direction?
    
    init(id: String, row: Int, col: Int, energy: Int, isRover: Bool = false, moveDirection: Direction?) {
        self.isRover = isRover
        self.moveDirection = moveDirection
        super.init(row: row, col: col, objectType: ((isRover == false) ? .mine : .rover), energy: energy, id: id)
    }
}
