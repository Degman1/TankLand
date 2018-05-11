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
    
    func isPositionEmpty(_ position: Position)->Bool{
        if getGO(coords: position) == nil {
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
    
    func findGameObjectsWithinRange(_ position: Position, range: Int)->[Position]{
        var radar = RadarResult(origin: position, distance: range)
        for (x,y) in radar.runRadar() {
            return x
        }
    }
    
    func findAllGameObjects()->[GameObjects]{
        var radar = RadarResult(distance: 14)
        for (x,y) in radar.runRadar() {
            return y
        }
    }
    
    func findAllTanks()->[Tank]{
        //.filter findAllGameObjects for tanks
    }
    
    func findAllRovers()->[Mine]{
         //.filter findAllGameObjects for rovers
    }
    
    func surroundings(_ position: Position)->[Position]{
        var array: [Position] = []
        array.append(Position(position.x, position.y+1)
        array.append(Position(position.x+1, position.y+1)
        array.append(Position(position.x+1, position.y)
        array.append(Position(position.x+1, position.y-1)
        array.append(Position(position.x, position.y-1)
        array.append(Position(position.x-1, position.y-1)
        array.append(Position(position.x-1, position.y)
        array.append(Position(position.x-1, position.y+1)
    }
    
    func findFreeAdjacent(_ position: Position)->Position?{
      for x in surroundings(position) {
          if getGO(coords: x) == nil{
              return x!}
      }
    }
    
    func makeOffSetPosition(position: Position, offSetRow: Int, offSetCol: Int)->Position?{
      let newPosition = Position(position.x+offSetRow, position.y+offSetCol)
      if isPositionEmpty(newPosition){
      return newPosition
    }
      return nil
    }
    
    func getLegalSurroundingPositions(_ position: Position)->[Position]{
        var array: [Position] = []
        for positions in surroundings(position) {
         if positions.x >=0 && positions.x <=14 && positions.y >=0 && positions.y <=14{
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








