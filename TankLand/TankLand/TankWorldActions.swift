//
//  TankWorldActions.swift
//  TankLand
//
//  Created by David Gerard on 5/5/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

extension TankWorld {   //functions to run and handle actions go here
    //pre-action handling
    
    func handleSendMessageAction(_ tank : Tank, _ sendMessageAction: SendMessageAction) {
        if isDead(tank) {return}
        logger.addLog(gameObject: tank, message: "Sending Message \(sendMessageAction)")
        
        if !isEnergyAvailable(tank, amount: Constants.costOfSendingMessage) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to send message")
            return
        }
        
        applyCost(tank, amount: Constants.costOfSendingMessage)
        MessageCenter.sendMessage(id: sendMessageAction.key, message: sendMessageAction.message)
    }
    
    func handleRecieveMessageAction(_ tank : Tank, _ receiveMessageAction: ReceiveMessageAction) {
        if isDead(tank) {return}
        logger.addLog(gameObject: tank, message: "Recieving Message \(receiveMessageAction)")
        
        if !isEnergyAvailable(tank, amount: Constants.costOfReceivingMessage) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to receive message")
            return
        }
        
        applyCost(tank, amount: Constants.costOfSendingMessage)
        let message = MessageCenter.receiveMessage(id: receiveMessageAction.key)
        tank.setReceivedMessage(receivedMessage: message)
    }
    
    func handleRunRadarAction(_ tank: Tank, _ radarAction: RadarAction) {
        if isDead(tank) {return}
        logger.addLog(gameObject: tank, message: "Running Radar \(radarAction)")
        
        if !isEnergyAvailable(tank, amount: Constants.costOfRadarByUnitsDistance[radarAction.range]) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to run radar")
            return
        }
        
        applyCost(tank, amount: Constants.costOfRadarByUnitsDistance[radarAction.range])
        let radarResult = findGameObjectsWithinRange(tank.position, range: radarAction.range)
        if radarResult.count > 0 { tank.setRadarResult(radarResults: radarResult) }
        else { tank.setRadarResult(radarResults: nil) }
    }
    
    func handleSetShieldsAction(_ tank: Tank, _ shieldAction: ShieldAction) {
        if isDead(tank) {return}
        logger.addLog(gameObject: tank, message: "Setting shields to \(shieldAction)")
        
        if !isEnergyAvailable(tank, amount: Constants.shieldPowerMultiple * shieldAction.power) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to set shields")
            return
        }
        
        applyCost(tank, amount: Constants.shieldPowerMultiple * shieldAction.power)
        tank.setShields(amount: shieldAction.power)
    }
    
    //post-action handling
    
    func dropExplosive(tank: Tank, dropMineAction: DropMineAction) {
        let dropPos = Position.newPosition(position: tank.position, direction: (dropMineAction.dropDirection == nil) ? Position.getRandomDirection() : dropMineAction.dropDirection!, magnitude: 1)
        if !Grid.isValidPosition(dropPos) {return}
        
        if dropMineAction.isRover {
            let rover = Mine(row: dropPos.y, col: dropPos.x, energy: dropMineAction.power, isRover: true, moveDirection: dropMineAction.moveDirection)
            if let contents = grid.getGO(coords: dropPos) {
                logger.addMajorLogger(gameObject: rover, message: "Added to TankLand")
                if contents.objectType == .mine || contents.objectType == .rover {
                    logger.addLog(gameObject: contents, message: "exploded at position \(contents.position)")
                    logger.addLog(gameObject: rover, message: "exploded at position \(rover.position)")
                    applyDamage(contents, amount: contents.energy)
                    applyDamage(rover, amount: rover.energy)
                } else {
                    logger.log("\(contents) exploded at position \(contents.position)") //QQQ is rover allowed to be a major logger?
                    applyDamage(contents, amount: rover.energy)
                    applyDamage(rover, amount: rover.energy)
                }
            } else {
                addGameObject(gameObject: rover)
            }
        } else {
            let mine = Mine(row: dropPos.y, col: dropPos.x, energy: dropMineAction.power, isRover: false, moveDirection: dropMineAction.moveDirection)
            if let contents = grid.getGO(coords: dropPos) {
                logger.addMajorLogger(gameObject: mine, message: "Added to TankLand")
                if contents.objectType == .mine || contents.objectType == .rover {
                    logger.addLog(gameObject: contents, message: "exploded at position \(contents.position)")
                    logger.addLog(gameObject: mine, message: "exploded at position \(mine.position)")
                    applyDamage(contents, amount: contents.energy)
                    applyDamage(mine, amount: mine.energy)
                } else {
                    logger.addLog(gameObject: mine, message: "exploded at position \(mine.position)")
                    applyDamage(contents, amount: mine.energy)
                    applyDamage(mine, amount: mine.energy)
                }
            } else {
                addGameObject(gameObject: mine)
            }
        }
    }
    
    func handleDropMineAction(_ tank: Tank, _ dropMineAction: DropMineAction) {
        if isDead(tank) {return}
        logger.addLog(gameObject: tank, message: "Dropping mine \(dropMineAction)")
        
        if !isEnergyAvailable(tank, amount: Constants.costOfReleasingMine + dropMineAction.power) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to drop mine")
            return
        }
        
        applyCost(tank, amount: Constants.costOfReleasingMine + dropMineAction.power)
        dropExplosive(tank: tank, dropMineAction: dropMineAction)
    }
    
    func handleDropRoverAction(_ tank: Tank, _ dropRoverAction: DropMineAction) {
        if isDead(tank) {return}
        logger.addLog(gameObject: tank, message: "Dropping rover \(dropRoverAction)")
        
        if !isEnergyAvailable(tank, amount: Constants.costOfReleasingRover + dropRoverAction.power) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to drop rover")
            return
        }
        
        applyCost(tank, amount: Constants.costOfReleasingRover + dropRoverAction.power)
        dropExplosive(tank: tank, dropMineAction: dropRoverAction)
    }
    
    func fireMissile(_ tank: Tank, missileAction: MissileAction) -> Bool {  //return if direct hit or not
        //fire to direct location + include collateral damage
        let hit: Bool
        
        logger.log("\n**********MISSILE STRIKE RESULTS \(tank) hits \(missileAction.target)")
        logger.addLog(gameObject: tank, message: "\(tank) strikes location \(missileAction.target) with energy \(missileAction.power * Constants.missleStrikeMultiple)")
        
        //strike location:
        if let targetContent = grid.getGO(coords: missileAction.target) {
            applyDamage(targetContent, amount: missileAction.power * Constants.missleStrikeMultiple)     //TODO: What happends if hits something other than a tank? still damage?
            hit = true
        } else {
            logger.addLog(gameObject: tank, message: "\(missileAction.target) unoccupied, no damage done")
            hit = false
        }
        
        for row in -1...1 {
            for col in -1...1 {
                let collateralPos = Position(missileAction.target.x + col, missileAction.target.y + row)
                if !(row != 0 || col != 0) || collateralPos.x < 0 || collateralPos.y < 0 || collateralPos.x >=  Constants.gridSize || collateralPos.y >= Constants.gridSize  {continue}   //skip over target spot -- already dealt damage
                logger.addLog(gameObject: tank, message: "\(tank) strikes location \(collateralPos) with energy \(missileAction.power * Constants.missleStrikeCollateral)")
                if let targetContent = grid.getGO(coords: collateralPos) {
                    applyDamage(targetContent, amount: missileAction.power * Constants.missleStrikeCollateral)     //TODO: What happends if hits something other than a tank? still damage?
                } else {
                    logger.addLog(gameObject: tank, message: "\(missileAction.target) unoccupied, no damage done")
                }
            }
        }
        logger.log("*********END MISSILE STRIKE RESULTS\n")
        return hit
    }
    
    func handleFireMissileAction(_ tank: Tank, _ missileAction: MissileAction) {
        if isDead(tank) {return}
        logger.addLog(gameObject: tank, message: "Attempted Missile Launch from \(tank) to \(missileAction.target) with energy \(missileAction.power)")
        
        if !isEnergyAvailable(tank, amount: Constants.costOfLaunchingMissile + missileAction.power) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to fire missile")
            return
        }
        
        applyCost(tank, amount: Constants.costOfLaunchingMissile + missileAction.power)
        let hit = fireMissile(tank, missileAction: missileAction)
        if hit { tank.addEnergy(amount: missileAction.power / Constants.missleStrikeEnergyTransferFraction) }
    }
    
    func handleMoveAction(_ tank: Tank, _ moveAction: MoveAction) {
        if isDead(tank) {return}
        let newPos = Position.newPosition(position: tank.position, direction: moveAction.direction, magnitude: moveAction.distance)
        logger.addLog(gameObject: tank, message: "Moving from \(tank.position) to \(newPos)")
        
        if !isEnergyAvailable(tank, amount: Constants.costOfMovingTankPerUnitDistance[distance(tank.position, newPos)]) {
            logger.addLog(gameObject: tank, message: "Insufficient energy to move")
            return
        }
        
        if isPositionEmpty(newPos) {
            applyCost(tank, amount: Constants.costOfMovingTankPerUnitDistance[distance(tank.position, newPos)])
            grid.moveGO(GO: tank, newCoords: newPos)
        } else {
            let contents = grid.getGO(coords: newPos)!
            if contents.objectType == .mine || contents.objectType == .rover {
                logger.addLog(gameObject: contents, message: "\(contents) exploded at position \(contents.position)")
                applyDamage(tank, amount: contents.energy * Constants.mineStrikeMultiple)
                applyDamage(contents, amount: contents.energy)
                
                applyCost(tank, amount: Constants.costOfMovingTankPerUnitDistance[distance(tank.position, newPos)])
                grid.moveGO(GO: tank, newCoords: newPos)
            } else {
                logger.addLog(gameObject: tank, message: "illegal action: cannot move onto occupied space") //TODO: correct message and for mine or rover exploding above? QQQ
            }
        }
    }
    
    func handleMoveRover(_ rover: Mine) {
        //either random or in direction- QQQ- does random moving mean free adjacent, or any adjadent?
        let newPos = Position.newPosition(position: rover.position, direction: (rover.moveDirection == nil) ? Position.getRandomDirection() : rover.moveDirection!, magnitude: 1)
        //findFreeAdjacent(rover.position)
        if isPositionEmpty(newPos) {
            grid.moveGO(GO: rover, newCoords: newPos)
            logger.addLog(gameObject: rover, message: "Moved to position \(rover.position)")
        } else {
            let contents = grid.getGO(coords: newPos)!
            if contents.objectType == .mine || contents.objectType == .rover {
                logger.addLog(gameObject: contents, message: "Exploded at position \(contents.position)")
                logger.addLog(gameObject: rover, message: "Exploded at position \(rover.position)")
                applyDamage(contents, amount: contents.energy)
                applyDamage(rover, amount: rover.energy)
            } else {
                logger.addLog(gameObject: rover, message: "Exploded at position \(rover.position)")
                applyDamage(contents, amount: rover.energy)
                applyDamage(rover, amount: rover.energy)
            }
        }
    }
}
