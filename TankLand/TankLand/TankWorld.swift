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
    var lastLivingTank: Tank?
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
        return ""
    }
    
    func doTurn() {
        //var allObjects = findAllGameObjects()
        //allObjects = randomizeGameObjects(gameObjects: allObjects)
        
        //code to run a single turn
        
        turn += 1
    }
    
    func runOneTurn() {
        doTurn()
        print(gridReport())
    }
    
    func driver() {
        populateTankWorld(tanks: [])
        print(gridReport())
        while !gameOver {
            if (numberLivingTanks == 1) {setWinner(lastStandingTank: <#T##Tank#>); gameOver = true}
            break   //main while loop for the game
        }
        
        print("****Winner is...\(lastLivingTank!)****")
    }
}

