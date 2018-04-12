//
//  Position.swift
//  TankLand
//
//  Created by David Gerard on 4/11/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Position: CustomStringConvertible {
    let origx: Int
    let origy: Int
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        origx = x
        origy = y
        self.x = x
        self.y = Constants.gridSize - y - 1     //convert from game coords ((0, 0) being bottom left) to array coords for the grid ((0, 0) being bottom left)
    }
    
    static func getRelativeLocation() -> (Direction, Int) { //(direction, distance)
        return (Direction.N, 5) //random for now
    }
    
    static func getAbsoluteLocation() -> Position {
        return Position(0, 0)   //random for now
    }
    
    var description: String {
        return "(\(origx), \(origy))"
    }
}
