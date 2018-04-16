//
//  Tank.swift
//  TankLand
//
//  Created by David Gerard on 4/6/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class Tank:  GameObject {
    
    func getRelativeLocation() -> (Direction, Int) { // returns the distance + direction of another GO
        return (Direction.N, 5) //random for now
    }
    
}
