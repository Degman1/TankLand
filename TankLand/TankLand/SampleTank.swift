//
//  SampleTank.swift
//  TankLand
//
//  Created by David Gerard on 5/20/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class SampleTank: Tank {
    override init(id: String, row: Int, col: Int, energy: Int, instructions: String){
        super.init(id: id, row: row, col: col, energy: energy, instructions: instructions)
    }
    
    func chanceOf (percent: Int) -> Bool{
        let ran = getRandomInt(range: 100)
        return percent <= ran
    }
    
    override func computePreActions(){
        addPreAction(preAction: ShieldAction(power: 300))
        addPreAction(preAction: RadarAction(range: 4))
        addPreAction(preAction: SendMessageAction(key: "someRandomPassward", message: "Message Sending Works!"))
        addPreAction(preAction: ReceiveMessageAction(key: "someRandomPassward"))
        super.computePreActions()
    }
    
    override func computePostActions(){
        addPostAction(postAction: MoveAction(distance: 1, direction: .NW))
        addPostAction(postAction: DropMineAction(power: 500, dropDirection: .NW))
        addPostAction(postAction: MissileAction(power: 100, target: Position(0, 0)))
        super.computePostActions()
        
        /*if (chanceOf(percent: 50)){
            let randomDirection = Direction(rawValue: getRandomInt(range: 7))!
            addPostAction(postAction: MoveAction(distance: 2, direction: randomDirection))
        }
        super.computePostActions()
        guard let rs = radarResults, rs.count != 0 else {return}
        if energy < 5000 {return}
        if (chanceOf(percent: 50)) {return}
        let randomItem = rs[getRandomInt(range: rs.count)]
        let missileEnergy = energy > 20000 ? 1000 : (energy / 20)
        addPostAction (postAction: MissileAction(power: missileEnergy, target: randomItem.position))*/
    }
}
