//
//  TankWorld.swift
//  TankLand
//
//  Created by David Gerard on 4/16/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

//This class is the basis for the game mechanics - maintains the grid, runs turns, determines winner, + handles the game actions (+ for some reason it says holds the support code?)
//use extentions to break this large class into smaller more managable pieces
class TankWorld {
    
}

extension TankWorld {    //extends tankland class, this is where the helper functions go
    
    func newPosition (position: Position, direction: Direction, magnitude: Int) -> Position {
        switch (direction) {
            case Direction.North : return Position(positon.x, position.y + magnitude)
            case Direction.NorthEast : return Position(positon.x + magnitude, position.y + magnitude)
            case Direction.East : return Position(positon.x + magnitude, position.y)
            case Direction.SouthEast : return Position(positon.x + magnitude, position.y - magnitude)
            case Direction.South : return Position(positon.x, position.y - magnitude)
            case Direction.SouthWest : return Position(positon.x - magnitude, position.y - magnitude)
            case Direction.West : return Position(positon.x - magnitude, position.y)
            case Direction.NorthWest : return Position(positon.x - magnitude, position.y + magnitude)
            default : return position 
        }
            
    }
    
    func isGoodIndex(row: Int, col: Int) -> Bool {
        if row <= 15 && col <= 15 {
            return true} else {
            return false}
    }

}
