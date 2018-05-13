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
    var livingTanks: [Tank] = []
    var numberLivingTanks: Int = 0
    var lastLivingTank: Tank? = nil
    var gameOver: Bool = false
    
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
            if GO.objectType == .tank {GO.useEnergy(amount: Constants.costLifeSupportTank)}
            if GO.objectType == .mine {GO.useEnergy(amount: Constants.costLifeSupportMine)}
            if GO.objectType == .rover {GO.useEnergy(amount: Constants.costLifeSupportRover)}
        }
    }
    
    func moveRovers(_ rovers: [Mine]) {
        //either random or in direction
    }
    
    
    //------------------------------------------------------------------- helper functions to handle actions
    
    //pre-action handling
    
    func handleSendMessageAction(_ actionInfo: SendMessageAction) {
        
    }
    
    func handleRecieveMessageAction(_ actionInfo: RecieveMessageAction) {
        
    }
    
    func handleRunRadarAction(_ tank: Tank, _ actionInfo: RunRadarAction) {
        tank.setRadarResult(radarResults: findGameObjectsWithinRange(tank.position, range: actionInfo.distance))
        print("Tank \(tank) ran its radar")
    }
    
    func handleSetShieldsAction(_ tank: Tank, _ actionInfo: SetShieldAction) {
        tank.setShields(amount: actionInfo.energy)
        print("Tank \(tank) set its shields")
    }
    
    //post-action handling
    
    func handleDropMineAction(_ actionInfo: DropMineAction) {
        
    }
    
    func handleDropRoverAction(_ actionInfo: DropRoverAction) {
        
    }
    
    func handleFireMissileAction(_ actionInfo: FireMissileAction) {
        
    }
    
    func handleMoveAction(_ tank: Tank, _ actionInfo: MoveAction) {
        grid.moveGO(GO: tank, newCoords: newPosition(position: tank.position, direction: actionInfo.direction, magnitude: actionInfo.distance))
        print("Tank \(tank) moved its position")
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    func runPreActions(_ tank: Tank) {
        //order not matter -- QUESTION: How does a tank read anothers message is it tries to send + recieve at the same time? -- only one tank will recieve the other message and the other one won't
        for action in tank.preActions {
            switch action.key {
            case .SendMessage: handleSendMessageAction(action.value as! SendMessageAction)
            case.ReciveMessage: handleRecieveMessageAction(action.value as! RecieveMessageAction)
            case .RunRadar: handleRunRadarAction(tank, action.value as! RunRadarAction)
            case .SetShields: handleSetShieldsAction(tank, action.value as! SetShieldAction)
            default: print("\(action) is not a pre-action")
            }
        }
    }
    
    func runPostActions(_ tank: Tank) {
        //1. drop mine/rover    2. launch missile   3. move
        if tank.postActions[.DropMine] != nil { handleDropMineAction(tank.postActions[.DropMine] as! DropMineAction) }
        if tank.postActions[.DropRover] != nil { handleDropRoverAction(tank.postActions[.DropRover] as! DropRoverAction) }
        if tank.postActions[.FireMissile] != nil { handleFireMissileAction(tank.postActions[.FireMissile] as! FireMissileAction) }
        if tank.postActions[.Move] != nil { handleMoveAction(tank, tank.preActions[.Move] as! MoveAction) }
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
        
        turn += 1
    }
    
    func runOneTurn() {
        doTurn()
        print(gridReport())
    }
    
    func driver() {
        populateTankWorld(tanks: livingTanks)
        print(gridReport())
        while !gameOver {
            if (numberLivingTanks == 1) {setWinner(lastStandingTank: findWinner()); break}
            runOneTurn()
        }
        
        print("****Winner is...\(lastLivingTank!)****")
    }
}

