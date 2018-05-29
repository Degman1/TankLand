//
//  Mine.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class Mine: GameObject {
    let isRover: Bool
    let moveDirection: Direction?
    
    init(id: String, row: Int, col: Int, energy: Int, isRover: Bool = false, moveDirection: Direction? = nil) {
        self.isRover = isRover
        self.moveDirection = moveDirection
        super.init(row: row, col: col, objectType: ((isRover == false) ? .mine : .rover), energy: energy, id: id)
    }
}
