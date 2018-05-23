//
//  SampleTank.swift
//  TankLand
//
//  Created by David Gerard on 5/20/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class SampleTank: Tank {
    override init(row: Int, col: Int, energy: Int, id: String, instructions: String){
        super.init(row: row, col: col, energy: energy, id: id, instructions: instructions)
    }
    
    func chanceOf (percent: Int)->Bool{
        let ran = getRandomInt(range: 100)
        return percent <= ran
    }
    
    override func computePreActions(){
        addPreAction(preAction: ShieldAction(power: 300))
        addPreAction(preAction: RadarAction(range: 4))
        super.computePreActions()
    }
    
    override func computePostActions(){
        if (chanceOf(percent: 50)){
            let randomDirection = Direction(rawValue: getRandomInt(range: 7))!
            addPostAction(postAction: MoveAction(distance: 2, direction: randomDirection))
        }
        super.computePostActions()
        guard let rs = radarResults, rs.count != 0 else {return}
        if energy < 5000 {return}
        if (chanceOf(percent: 50)) {return}
        let randomItem = rs[getRandomInt(range: rs.count)]
        let missileEnergy = energy > 20000 ? 1000 : (energy / 20)
        addPostAction (postAction: MissileAction(power: missileEnergy, target: randomItem.posiition))
    }
}
