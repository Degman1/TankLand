//
//  GameTank.swift
//  TankLand
//
//  Created by David Gerard on 6/3/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class GameTank: Tank {    
    override init(id: String, row: Int, col: Int, energy: Int, instructions: String) {
        super.init(id: id, row: row, col: col, energy: energy, instructions: instructions)
    }
    
    func makeOffSetPosition(position: Position, offSetRow: Int, offSetCol: Int) -> Position? {
        let newPosition = Position(position.x + offSetRow, position.y + offSetCol)
        return isPositionEmpty(newPosition) ? newPosition : nil
    }
    
    func isPositionEmpty(_ newPos: Position) -> Bool {
        if let rr = radarResults {
            for r in rr {
                if r.position == newPos {return false}
            }
        }
        return true
    }
    
    func newPosition(position: Position, direction: Direction, magnitude: Int) -> Position {
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
    
    override func computePreActions() {
        addPreAction(preAction: RadarAction(range: 3))
        if let rr = radarResults {
            let count = rr.filter({$0.type == .tank}).count
            if count >= 2 { addPreAction(preAction: ShieldAction(power: 500)) }
            if count == 1 { addPreAction(preAction: ShieldAction(power: 250)) }
        }
        super.computePreActions()
    }
    
    override func computePostActions() {
        if let rr = radarResults {
            let surroundingTanks = rr.filter({$0.type == .tank})
            let index = Int(surroundingTanks.count / 2)
            
            if surroundingTanks.count > 0 && surroundingTanks[index].id.lowercased() != "ally" {
                addPostAction(postAction: MissileAction(power: surroundingTanks[index].energy / 10, target: surroundingTanks[index].position))
            }
            let dir = Position.getRandomDirection()
            let newPos = newPosition(position: self.position, direction: dir, magnitude: 2)
            if isPositionEmpty(newPos) { addPostAction(postAction: MoveAction(distance: 2, direction: dir)) }
        } else {
            var dir: Direction = .NW
            if position.x > 7 && position.y < 7 { dir = .SW }
            else if position.x < 7 && position.y < 7 { dir = .SE }
            else if position.x < 7 && position.y > 7 { dir = .NE }
            else if position.x > 7 && position.y > 7 { dir = .NW }
            addPostAction(postAction: DropMineAction(power: 400, isRover: true, dropDirection: dir, moveDirection: dir))
        }
    }
}
