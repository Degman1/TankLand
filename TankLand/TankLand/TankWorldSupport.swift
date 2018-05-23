//
//  TankWorldSupport.swift
//  TankLand
//
//  Created by David Gerard on 5/5/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

extension TankWorld {    //extends tankland class, this is where the helper functions go
    
    func nextTurn() {
        turn += 1
        logger.turn += 1
    }
    
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
    
    func applyCost(_ tank: Tank, amount: Int) {
            let startEnergy = tank.energy
            tank.useEnergy(amount: amount - tank.shields)
            logger.addLog(gameObject: tank, message: "Energy drop from \(startEnergy) to \(tank.energy)")
    }
    
    func applyDamage(_ go: GameObject, amount: Int) {
        var shieldEnergy = 0
        if go.objectType == .tank {
            shieldEnergy = (go as! Tank).shields
            if amount <= shieldEnergy {
                logger.addLog(gameObject: go, message: "Shields hold, no damage done")
            } else {
                let startEnergy = go.energy
                go.useEnergy(amount: amount - shieldEnergy)
                logger.addLog(gameObject: go, message: "Shields breached. Tank energy reduced from \(startEnergy) to \(go.energy)")
                logger.addLog(gameObject: go, message: "Energy drop from \(startEnergy) to \(go.energy)")
            }
        } else {
            go.useEnergy(amount: amount)    //TODO: reset shields after each turn
        }
    }
    
    func randomizeGameObjects<T: GameObject>(gameObjects: [T]) -> [T] {
        return gameObjects  //TODO: randomize the array
    }
    
    func findGameObjectsWithinRange(_ position: Position, range: Int) -> [RadarResult] {
        var radar = Radar(gameGrid: grid, origin: position, distance: range)
        return radar.runRadar()
    }
    
    func findAllGameObjects() -> [GameObject] { //only for game use not tank actions -- not located in grid struct b/c radarresult needs a grid
        var radar = Radar(gameGrid: grid, origin: Position(7, 7), distance: 7)
        return radar.runRadar_game()
    }
    
    func findAllTanks() -> [Tank] { //only for game use not tank actions
        return findAllGameObjects().filter({$0.objectType == GameObjectType.tank}) as! [Tank]
    }
    
    func findAllRovers() -> [Mine] {
        return findAllGameObjects().filter({$0.objectType == GameObjectType.mine}) as! [Mine]
    }
    
    func makeOffSetPosition(position: Position, offSetRow: Int, offSetCol: Int) -> Position? {
        let newPosition = Position(position.x + offSetRow, position.y + offSetCol)
        if isPositionEmpty(newPosition) {
            return newPosition
        }
        return nil
    }
    
    func getLegalSurroundingPositions(_ position: Position) -> [Position] {
        var surroundings = [Position]()
        for row in -1...1 {
            for col in -1...1 {
                if let k = makeOffSetPosition(position: position, offSetRow: row, offSetCol: col) {
                    surroundings.append(k)
                }
            }
        }
        return surroundings
    }
    
    func findFreeAdjacent(_ position: Position) -> Position? {
        let surroundings = getLegalSurroundingPositions(position)
        return surroundings == [] ? nil : surroundings[getRandomInt(range: 8)]
    }
                     
    func isEnergyAvailable(_ gameObject: GameObject, amount: Int) -> Bool {
        if gameObject.energy - amount > 0  {
            return true
        }
        return false
    }

    func findWinner() -> Tank {
        return findAllTanks()[0]
    }
    
    func distance(_ p1: Position, _ p2: Position) -> Int {
        let diffx = p2.x - p1.x
        let diffy = p2.y - p1.y
        return Int( sqrt( Double((diffx) * (diffx) + (diffy) * (diffy))) )  //will round to be correct
    }
}
