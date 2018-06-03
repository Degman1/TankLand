//
//  Mine.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class Mine: GameObject {
    static var idCounter = 0
    let isRover: Bool
    let moveDirection: Direction?
    
    init(row: Int, col: Int, energy: Int, isRover: Bool = false, moveDirection: Direction? = nil) {
        self.isRover = isRover
        self.moveDirection = moveDirection
        
        super.init(row: row, col: col, objectType: (isRover == false) ? .mine : .rover, energy: energy, id: (isRover == false) ? "mne\(Mine.idCounter)" : "rvr\(Mine.idCounter)")
        Mine.idCounter += 1 //QQQ is mine and rover share same id + counter?
    }
}
