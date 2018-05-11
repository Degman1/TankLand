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
            return true
        }
        return false
    }
    
    func isPositionEmpty(_ position: Position)->Bool{
        if grid.getGO(coords: position) == nil {
            return true
        }
        return false
    }
    
    func isDead(_ gameObject: GameObject)->Bool {
        if gameObject.energy <= 0 {
            return true
        }
        return false
    }
    
    func randomizeGameObjects<T: GameObject>(gameObjects: [T])->[T] {
        return gameObjects  //TODO: randomize the array
    }
    
    func findGameObjectsWithinRange(_ position: Position, range: Int) -> [Position]{
        var radar = RadarResult(gameGrid: grid, origin: position, distance: range)
        return radar.runRadar().map({$0.key})
    }
    
    func findAllGameObjects() -> [GameObject] {
        var radar = RadarResult(gameGrid: grid, origin: Position(7, 7), distance: 7)
        return radar.runRadar().map({$0.value})
    }
    
    func findAllTanks() -> [Tank] {
        var radar = RadarResult(gameGrid: grid, origin: Position(7, 7), distance: 7)
        var result = radar.runRadar().map({$0.value}).filter({$0 == .tank})
    }
    
    func findAllRovers() -> [Mine]{
        var radar = RadarResult(gameGrid: grid, origin: Position(7, 7), distance: 7)
        var result = radar.runRadar().map({$0.value}).filter({$0 == .mine})
    }
    
    func findFreeAdjacent(_ position: Position) -> Position? {
        var radar = RadarResult(gameGrid: grid, origin: position, distance: 1)
        let results = radar.runRadar()
        for (pos, go) in results {
            return pos
        }
        return nil
    }
    
    func makeOffSetPosition(position: Position, offSetRow: Int, offSetCol: Int) -> Position?{
        let newPosition = Position(position.x + offSetRow, position.origy + offSetCol)
        if isPositionEmpty(newPosition) {
            return newPosition
        }
        return nil
    }
    
    func getLegalSurroundingPositions(_ position: Position)-> [Position] {
        var array: [Position] = []
        for positions in surroundings(position) {
            if positions.x >= 0 && positions.x <= 14 && positions.y >= 0 && positions.y <= 14{
                array.append(Position)
            }
        }
        return array
    }

    func getRandomDirection()->Direction{
     //didnt you already make this   
    }
                     
    func isEnergyAvailable(_ gameObject: GameObject, amount: Int)->Bool{
     if gameObject.energy - amount > 0  {
         return true}
        return false
    }
                     
    func findWinner()->Tank{
        //use findalltanks then loop through their energies until only one is left
    }
                     
   func distance(_ p1: Position, _ p2: Position)->Int{
   return sqrt((p2.x-p1.x)*(p2.x-p1.x)+(p2.y-p1.y)*(p2.y-p1.y))
   }
}








