//
//  TankWorld.swift
//  TankLand
//
//  Created by David Gerard on 4/16/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

//This class is the basis for the game mechanics - maintains the grid, runs turns, determines winner, + handles the game actions (+ for some reason it says holds the support code?)
//use extentions to break this large class into smaller more managable pieces
class TankWorld {
    var grid: Grid = Grid()
    var logger = Logger()
    var turn: Int = 0
    private var livingTanks: [Tank] = []
    private var numberLivingTanks: Int = 0
    private var lastLivingTank: Tank? = nil
    private var gameOver: Bool = false
    
    init() {}
    
    func populateTankWorld(tanks: [Tank]) {
        for tank in tanks {
            addGameObject(gameObject: tank)
        }
    }
    
    func addGameObject(gameObject: GameObject) {
        logger.addMajorLogger(gameObject: gameObject, message: "Added to TankLand")
        grid.generateGO(GO: gameObject, coords: gameObject.position)
        if gameObject.objectType == .tank {numberLivingTanks += 1}
    }
    
    func setWinner(lastStandingTank: Tank) {
        gameOver = true
        lastLivingTank = lastStandingTank
    }
    
    func gridReport() -> String {
        return "\(grid)"
    }
    
    func chargeTurnEnergy(_ GOs: [GameObject]) {
        for GO in GOs {
            if GO.objectType == .tank {applyCost(GO, amount: Constants.costLifeSupportTank)}
            if GO.objectType == .mine {applyCost(GO, amount: Constants.costLifeSupportMine)}
            if GO.objectType == .rover {applyCost(GO, amount: Constants.costLifeSupportRover)} //log this??
        }
    }
    
    func runPreActions(_ tanks: [Tank]) {
        //only need to send messages first so every message shows up when receiving. order of the rest does not matter
        for tank in tanks {
            tank.computePreActions()
            if let sendMessageAction = tank.preActions[.SendMessage] { handleSendMessageAction(tank, sendMessageAction as! SendMessageAction) }
        }
        for tank in tanks {
            if let receiveMessageAction = tank.preActions[.ReceiveMessage] { handleRecieveMessageAction(tank, receiveMessageAction as! ReceiveMessageAction) }
            if let radarAction = tank.preActions[.Radar] { handleRunRadarAction(tank, radarAction as! RadarAction) }
            if let shieldAction = tank.preActions[.Shields] { handleSetShieldsAction(tank, shieldAction as! ShieldAction)}
        }
        for tank in tanks {
            tank.preActions = [:]
        }
    }
    
    func runPostActions(_ tanks: [Tank]) {
        for tank in tanks {
            //1. drop mine/rover    2. launch missile   3. move
            tank.computePostActions()
            if let dropMineAction = tank.postActions[.DropMine] {
                if (dropMineAction as! DropMineAction).isRover { handleDropRoverAction(tank, dropMineAction as! DropMineAction) }
                else { handleDropMineAction(tank, dropMineAction as! DropMineAction) }
            }
            removeDeadObjects()
            if let fireMissileAction = tank.postActions[.Missile] {handleFireMissileAction(tank, fireMissileAction as! MissileAction)}
            removeDeadObjects()
            if let moveAction = tank.postActions[.Move] { handleMoveAction(tank, moveAction as! MoveAction) }
            removeDeadObjects()
        }
        for tank in tanks {
            tank.postActions = [:]
        }
    }
    
    func moveRovers(rovers: [Mine]) {
        for rover in rovers {
            if isDead(rover) {continue}
            handleMoveRover(rover)  //TODO: reduce energy for each moving?, or is that accounted for in turn life
        }
    }
    
    func removeDeadObjects() {
        if findAllTanks().count == 1 {
            //TODO: stop the turn and get out of the loop QQQ
        }
        for gameObject in findAllGameObjects() {
            if isDead(gameObject) {
                grid.removeGO(GO: gameObject)
            }
        }
    }
    
    func doTurn() {
        let allObjects = randomizeGameObjects(gameObjects: findAllGameObjects())    //TODO: randomize them
        let allRovers = randomizeGameObjects(gameObjects: findAllRovers())
        let allTanks = randomizeGameObjects(gameObjects: findAllTanks())
        //code to run a single turn
        
        chargeTurnEnergy(allObjects)
        removeDeadObjects()
        
        moveRovers(rovers: allRovers)
        
        runPreActions(allTanks)
        runPostActions(allTanks)
        
        removeDeadObjects()
        
        nextTurn()
    }
    
    func runOneTurn() {
        logger.log("BEGINNING TURN #\(turn)")
        logger.log("NLT: \(numberLivingTanks)")
        doTurn()
        logger.log(gridReport())
    }
    
    func driver() {
        populateTankWorld(tanks: livingTanks)
        logger.log(gridReport())
        var count = 0
        
        while !gameOver {
            numberLivingTanks = findAllTanks().count
            if (numberLivingTanks <= 0) {setWinner(lastStandingTank: findWinner()); break}
            runOneTurn() //TODO: must stop in middle of turn!!
            //if let winner = runOneTurn() {setWinner(lastStandingTank: findWinner()); break}
            if count == 1 {break}
            count += 1
        }
        //print("****Winner is...\(lastLivingTank!)****")
    }
}

