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
     init(id: String, row: Int, col: Int, energy: Int, instructions: String) {
        super.init(row: row, col: col, objectType: .mine, energy: energy, id: id)
    }
}
