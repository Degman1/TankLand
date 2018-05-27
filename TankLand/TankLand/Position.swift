//
//  Position.swift
//  TankLand
//
//  Created by David Gerard on 4/11/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Position: CustomStringConvertible, Hashable {
    let x: Int  //don't change it in conversion, so don't need origx
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    //return a set of random coords
    static func getRandomCoords() -> Position {
        return Position(getRandomInt(range: Constants.gridSize), getRandomInt(range: Constants.gridSize))
    }
    
    static func getRandomDirection() -> Direction {
        return Direction(rawValue: getRandomInt(range: 7))!
    }
    
    static func newPosition(position: Position, direction: Direction, magnitude: Int) -> Position {
        switch (direction) {
        case Direction.N : return Position(position.x, position.y - magnitude)
        case Direction.NE : return Position(position.x + magnitude, position.y - magnitude)
        case Direction.E : return Position(position.x + magnitude, position.y)
        case Direction.SE : return Position(position.x + magnitude, position.y + magnitude)
        case Direction.S : return Position(position.x, position.y + magnitude)
        case Direction.SW : return Position(position.x - magnitude, position.y + magnitude)
        case Direction.W : return Position(position.x - magnitude, position.y)
        case Direction.NW : return Position(position.x - magnitude, position.y - magnitude)
        }
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
        return "(\(x), \(y))"
    }
}
