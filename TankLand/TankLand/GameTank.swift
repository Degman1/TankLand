//
//  GameTank.swift
//  TankLand
//
//  Created by David Gerard on 6/3/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class GameTank: Tank {    
    override init(id: String, row: Int, col: Int, energy: Int, instructions: String){
        super.init(id: id, row: row, col: col, energy: energy, instructions: instructions)
    }
    
    func chanceOf (percent: Int) -> Bool{
        let ran = getRandomInt(range: 100)
        return percent <= ran
    }
    
    func distance(_ p1: Position, _ p2: Position) -> Int {
        let diffx = p2.x - p1.x
        let diffy = p2.y - p1.y
        return Int( sqrt( Double((diffx) * (diffx) + (diffy) * (diffy))) )  //will round to be correct
    }
    
    //WORKING: shields, sendmessage, receivemessage, radar, move, dropmine
    
    override func computePreActions() {
        //radarResults = nil  //make sure to set it to this so if not yet updated, has at least been initiated
        addPreAction(preAction: RadarAction(range: 3))
        addPreAction(preAction: ShieldAction(power: 500))
        //addPreAction(preAction: SendMessageAction(key: "\(id): someRandomPassward", message: "Message Sending Works for tank \(id)!"))
        //addPreAction(preAction: ReceiveMessageAction(key: "\(id): someRandomPassward"))
        super.computePreActions()   //why calling this ???
    }
    
    override func computePostActions() {
        //TODO: don't own tanks shoot at eachother
        if let rr = radarResults {
            let surroundingTanks = rr.filter({$0.type == .tank})
            
            /*var closest: RadarResult?
            closest = nil
            for r in rr {
                if closest == nil || (r.type == .tank && distance(self.position, r.position) < distance(self.position, closest!.position)) {
                    closest = r
                }
            }*/
            if surroundingTanks.count > 0 {
                addPostAction(postAction: MissileAction(power: surroundingTanks[0].energy / 10, target: surroundingTanks[0].position))
            }
            
            //addPostAction(postAction: MoveAction(distance: 2, direction: .E))
            /*if rr.count > 3 {
                //get outta there in TODO: opposite direction
                addPostAction(postAction: MoveAction(distance: 2, direction: Position.getRandomDirection()))
            } else {
                addPostAction(postAction: MoveAction(distance: 1, direction: Position.getRandomDirection()))
            }*/
        } else {
            addPostAction(postAction: DropMineAction(power: 400, isRover: true, dropDirection: .S, moveDirection: .S))
        }

        addPostAction(postAction: MoveAction(distance: 2, direction: .W))
        //addPostAction(postAction: DropMineAction(power: 100, dropDirection: Position.getRandomDirection, isRover == true ))
        
        
        /*if counter == 0 {addPostAction(postAction: DropMineAction(power: 500, isRover: true, dropDirection: .W, moveDirection: .W))}
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
