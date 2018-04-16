//
//  Position.swift
//  TankLand
//
//  Created by David Gerard on 4/11/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Position: CustomStringConvertible {
    let origy: Int
    let x: Int  //don't change it in conversion, so don't need origx
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        origy = y
        self.y = Constants.gridSize - y - 1     //convert from game coords ((0, 0) being bottom left) to array coords for the grid ((0, 0) being bottom left)
    }
    
    static func getRandomCoords() -> Position {
        return Position(Int(arc4random_uniform(UInt32(Constants.gridSize))), Int(arc4random_uniform(UInt32(Constants.gridSize))))
    }
    
    var description: String {
        return "(\(x), \(origy))"
    }
}
