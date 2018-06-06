//
//  SampleTank.swift
//  TankLand
//
//  Created by David Gerard on 5/20/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class SampleTank: Tank {
    var counter = 0
    
    override init(id: String, row: Int, col: Int, energy: Int, instructions: String){
        super.init(id: id, row: row, col: col, energy: energy, instructions: instructions)
    }
    
    func chanceOf (percent: Int) -> Bool{
        let ran = getRandomInt(range: 100)
        return percent <= ran
    }
    
    //WORKING: shields, sendmessage, receivemessage, radar, move, dropmine
    
    override func computePreActions(){
        //addPreAction(preAction: ShieldAction(power: 300))
        //radarResults = nil  //make sure to set it to this so if not yet updated, has at least been initiated
        //addPreAction(preAction: RadarAction(range: 4))
        //addPreAction(preAction: SendMessageAction(key: "\(id): someRandomPassward", message: "Message Sending Works for tank \(id)!"))
        //addPreAction(preAction: ReceiveMessageAction(key: "\(id): someRandomPassward"))
        super.computePreActions()   //why calling this ???
    }
    
    override func computePostActions() {
        //addPostAction(postAction: MoveAction(distance: 1, direction: .S))
        //addPostAction(postAction: DropMineAction(power: 300, dropDirection: .S))
        //if let rr = radarResults { addPostAction(postAction: MissileAction(power: 8000, target: rr[0].position)) }
        
        
        /*if counter == 0 {addPostAction(postAction: DropMineAction(power: 500, isRover: true, dropDirection: .E, moveDirection: .E))}
        counter += 1
        super.computePostActions()*/
        
        
        
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
