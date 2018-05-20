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
        //what should this return
        return "\(grid)"
    }
    
    func chargeTurnEnergy(_ GOs: [GameObject]) {
        for GO in GOs {
            if GO.objectType == .tank {applyCost(GO as! Tank, amount: Constants.costLifeSupportTank)}
            if GO.objectType == .mine {GO.useEnergy(amount: Constants.costLifeSupportMine)} //log this??
            if GO.objectType == .rover {GO.useEnergy(amount: Constants.costLifeSupportRover)} //log this??
        }
    }
    
    func moveRovers(_ rovers: [Mine]) {
        //either random or in direction
    }
    
    func runPreActions(_ tank: Tank) {
        //order not matter -- QUESTION: How does a tank read anothers message is it tries to send + recieve at the same time? -- only one tank will recieve the other message and the other one won't
        for action in tank.preActions {
            switch action.key {
            case .SendMessage: handleSendMessageAction(tank, action.value as! SendMessageAction)
            case.ReceiveMessage: handleRecieveMessageAction(tank, action.value as! ReceiveMessageAction)
            case .Radar: handleRunRadarAction(tank, action.value as! RadarAction)
            case .Shields: handleSetShieldsAction(tank, action.value as! ShieldAction)
            default: print("\(action) is not a pre-action")
            }
        }
    }
    
    func runPostActions(_ tank: Tank) {
        //1. drop mine/rover    2. launch missile   3. move     TODO: is it for each tank in this order, or overall in this order??
        if let dropMineAction = tank.postActions[.DropMine] {handleDropMineAction(tank, dropMineAction as! DropMineAction)}
        if let fireMissileAction = tank.postActions[.Missile] {handleFireMissileAction(tank, fireMissileAction as! MissileAction)}
        if let moveAction = tank.postActions[.Move] { handleMoveAction(tank, moveAction as! MoveAction) }
    }
    
    func removeDeadObjects(gameObjects: [GameObject]) {
        for gameObject in gameObjects {
            if isDead(gameObject) {
                grid.removeGO(GO: gameObject)
            }
        }
    }
    
    func doTurn() {
        let allObjects = randomizeGameObjects(gameObjects: findAllGameObjects())
        let allRovers = randomizeGameObjects(gameObjects: findAllRovers())
        let allTanks = randomizeGameObjects(gameObjects: findAllTanks())
        //code to run a single turn
        
        //make sure to check after every energy expending if the GO is dead
        
        chargeTurnEnergy(allObjects)
        
        moveRovers(allRovers)
        
        for tank in allTanks {
            runPreActions(tank)
        }
        
        for tank in allTanks {
            runPostActions(tank)
        }
        
        removeDeadObjects(gameObjects: allObjects)  //TODO: Do this more often????
        
        nextTurn()
    }
    
    func runOneTurn() {
        logger.log("BEGINNING TURN #\(turn)")
        logger.log("NLT: \(numberLivingTanks)")
        doTurn()
        print(gridReport())
    }
    
    func driver() {
        populateTankWorld(tanks: livingTanks)
        logger.log(gridReport())
        
        while !gameOver {
            if (numberLivingTanks == 1) {setWinner(lastStandingTank: findWinner()); break}
            runOneTurn()
        }
        
        print("****Winner is...\(lastLivingTank!)****")
    }
}

