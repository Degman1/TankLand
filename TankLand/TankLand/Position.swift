//
//  Position.swift
//  TankLand
//
//  Created by David Gerard on 4/11/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Position: CustomStringConvertible, Hashable {
    let origy: Int
    let x: Int  //don't change it in conversion, so don't need origx
    let y: Int
    
    init(_ x: Int, _ y: Int, gridSize: Int = Constants.gridSize) {
        self.x = x
        origy = y
        self.y = gridSize - y - 1     //convert from game coords ((0, 0) being bottom left) to array coords for the grid ((0, 0) being bottom left)
    }
    
    //return a set of random coords
    static func getRandomCoords() -> Position {
        return Position(Int(arc4random_uniform(UInt32(Constants.gridSize))), Int(arc4random_uniform(UInt32(Constants.gridSize))))
    }
    
    func pair(_ a: Int, _ b: Int) -> Int {
        return ((a + b) * (a + b + 1) / 2) + b
    }
    
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
    
    var hashValue: Int {
        return(pair(x, y))
    }
    
    var description: String {
        return "(\(x), \(y) (\(origy)))"
    }
}
