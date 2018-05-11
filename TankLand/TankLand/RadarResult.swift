//
//  RadarResult.swift
//  TankLand
//
//  Created by David Gerard on 4/16/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct RadarResult {
    var gameGrid: Grid
    let origin: Position
    let distance: Int
    var radarResult: Grid
    
    init(gameGrid: Grid, origin: Position, distance: Int) {
        self.gameGrid = gameGrid
        self.origin = origin
        self.distance = distance
        radarResult = Grid(size: (distance * 2) + 1)
    }
    
    mutating func runRadar() -> RadarInfo {
        print("running radar...")
        var result: RadarInfo
        
        for row in -distance...distance {
            for col in -distance...distance {
                if (origin.x + col < gameGrid.size) && (origin.x + col >= 0) && (origin.origy + row < gameGrid.size) && (origin.origy + row >= 0) && ((row != 0) || (col != 0)), let GO = gameGrid.getGO(coords: Position(origin.x + col, origin.origy + row)) {

                    //if all the coordinates are in boundsof the game grid, then try to unwrap the GO and if it is there, add it to the radarResult grid:
                    //result[Position(origin.x + col, origin.y - row)] = GO.objectType
                    result = RadarInfo(id: GO.id, energy: GO.energy, type: GO.objectType, position: GO.position)
                }
            }
        }
        print("\nresults of radar:")
        print("\(result)")
        return result
    }
}

struct RadarInfo {
    let id: String
    let energy: Int
    let type: GameObjectType
    let position: Position
    
    init(id: String, energy: Int, type: GameObjectType, position: Position) {
        self.id = id
        self.energy = energy
        self.type = type
        self.position = position
    }
}
