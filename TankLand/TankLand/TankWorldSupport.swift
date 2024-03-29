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
    
    func isPositionEmpty(_ position: Position)->Bool{
        return grid.getGO(coords: position) == nil
    }
    
    func isDead(_ gameObject: GameObject)->Bool {
        return gameObject.energy <= 0
    }
    
    func applyCost(_ go: GameObject, amount: Int) {
            let startEnergy = go.energy
            go.useEnergy(amount: amount)
            logger.addLog(gameObject: go, message: "Energy drop from \(startEnergy) to \(go.energy)")
    }
    
    func applyDamage(_ go: GameObject, amount: Int) {
        var shieldEnergy = 0
        if go.objectType == .tank {
            shieldEnergy = (go as! Tank).shields
            if amount <= shieldEnergy * Constants.shieldPowerMultiple {
                logger.addLog(gameObject: go, message: "Shields hold, no damage done")
            } else {
                let startEnergy = go.energy
                go.useEnergy(amount: amount - (shieldEnergy * Constants.shieldPowerMultiple))
                logger.addLog(gameObject: go, message: "Shields breached. Tank energy reduced from \(startEnergy) to \(go.energy)")
                logger.addLog(gameObject: go, message: "Energy drop from \(startEnergy) to \(go.energy)")
            }
        } else {
            let startEnergy = go.energy
            go.useEnergy(amount: amount)
            logger.addLog(gameObject: go, message: "Energy drop from \(startEnergy) to \(go.energy)")
        }
    }
    
    func randomizeGameObjects<T: GameObject>(gameObjects: [T]) -> [T] {
        var copyGO = gameObjects
        var randomized = Array(repeating: GameObject(row: 0, col: 0, objectType: .tank, energy: 0, id: ""), count: gameObjects.count)
        
        for i in 0..<gameObjects.count {
            let rand = getRandomInt(range: copyGO.count)
            randomized[i] = copyGO[rand]
            copyGO.remove(at: rand)
        }
        
        return randomized as! [T]
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
        return findAllGameObjects().filter({$0.objectType == .rover}) as! [Mine]
    }
    
    func makeOffSetPosition(position: Position, offSetRow: Int, offSetCol: Int) -> Position? {
        let newPosition = Position(position.x + offSetRow, position.y + offSetCol)
        return isPositionEmpty(newPosition) ? newPosition : nil
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
        if surroundings == [] {return nil}
        else {return surroundings[getRandomInt(range: surroundings.count)]}
    }
                     
    func isEnergyAvailable(_ gameObject: GameObject, amount: Int) -> Bool {
        return gameObject.energy - amount > 0
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
