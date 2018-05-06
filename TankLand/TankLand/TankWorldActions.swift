//
//  TankWorldActions.swift
//  TankLand
//
//  Created by David Gerard on 5/5/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

extension TankWorld {   //functions to run and handle actions go here
    func handleRadar(tank: Tank) {
        guard let radarAction = tank.preActions[.RunRadar] else {return}
        actionRunRadar(tank: tank, radarAction: radarAction as! RunRadarAction)
        //Why do I need to check the action type if I already know it will be a radarAction
    }
    
    func actionRunRadar(tank: Tank, radarAction: RunRadarAction) {
        let _ = RadarResult(gameGrid: grid, origin: tank.position, distance: radarAction.distance)
        //TODO: What should we do with the result??
    }
}
