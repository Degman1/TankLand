//
//  TankWorldSupport.swift
//  TankLand
//
//  Created by David Gerard on 5/5/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

extension TankWorld {    //extends tankland class, this is where the helper functions go
    
    func newPosition (position: Position, direction: Direction, magnitude: Int) -> Position {
        switch (direction) {
        case Direction.N : return Position(position.x, position.y + magnitude)
        case Direction.NE : return Position(position.x + magnitude, position.y + magnitude)
        case Direction.E : return Position(position.x + magnitude, position.y)
        case Direction.SE : return Position(position.x + magnitude, position.y - magnitude)
        case Direction.S : return Position(position.x, position.y - magnitude)
        case Direction.SW : return Position(position.x - magnitude, position.y - magnitude)
        case Direction.W : return Position(position.x - magnitude, position.y)
        case Direction.NW : return Position(position.x - magnitude, position.y + magnitude)
        }
        
    }
    
    func isGoodIndex(row: Int, col: Int) -> Bool {
        if row <= 15 && col <= 15 {
            return true}
        return false
    }
    
    func isValidPosition(_ Position: Position)->Bool {
        if isGoodIndex(row: Position.x, col: Position.y) {
            return true}
        return false
    }
    
    func isPositionEmpty(_ Position: Position)->Bool{
        if getGO(coords: Position) == nil {
            return true}
        return false
    }
    
    func isDead(_ gameObject: GameObject)->Bool {
        if gameobject.energy <= 0 {
            return true}
        return false
    }
    
    func randomizeGameObjects<T: GameObject>(gameObjects: [T])->[T] {
        
    }
}
