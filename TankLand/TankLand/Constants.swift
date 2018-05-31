//
//  Constants.swift
//  TankLand
//
//  Created by David Gerard on 4/11/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Constants {
    static var gridSize = 15
    
    static var initialTankEnergy = 100000
    static var costOfRadarByUnitsDistance = [0, 100, 200, 400, 800, 1600, 3200, 6400, 12400]    //does units distance start at zero units, or 1 unit ???
    static var costOfSendingMessage = 100
    static var costOfReceivingMessage = 100
    static var costOfReleasingMine = 250
    static var costOfReleasingRover = 500
    static var costOfLaunchingMissile = 1000
    static var costOfFlyingMissilePerUnitDistance = 200
    static var costOfMovingTankPerUnitDistance = [100, 300, 600]
    static var costOfMovingRover = 50
    static var costLifeSupportTank = 100
    static var costLifeSupportRover = 40
    static var costLifeSupportMine = 20
    static var missleStrikeMultiple = 10
    static var missleStrikeCollateral = 3
    static var mineStrikeMultiple = 5    //TODO: Input this into the mine
    static var shieldPowerMultiple = 8
    static var missleStrikeEnergyTransferFraction = 4
}
