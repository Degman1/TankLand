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
    
    mutating func runRadar() -> [Position: GameObjectType] {
        print("running radar...")
        var result: [Position: GameObjectType] = [:]
        
        for row in -distance...distance {
            for col in -distance...distance {
                if (origin.x + col < gameGrid.size) && (origin.x + col >= 0) && (origin.origy + row < gameGrid.size) && (origin.origy + row >= 0) && ((row != 0) || (col != 0)), let GO = gameGrid.getGO(coords: Position(origin.x + col, origin.origy + row)) {

                    //if all the coordinates are in boundsof the game grid, then try to unwrap the GO and if it is there, add it to the radarResult grid:
                    result[Position(origin.x + col, origin.y - row)] = GO.objectType      //using origy instead of y b/c Position will redo the coordinate shift and I don't want the new shifted version reverted
                    //only works when you subtract the row. I think this is b/c it loops from the bottom left to top right, and the coordinates go in the other direction, so flipping the row reverses origin looping point
                    
                    //radarResult.generateGO(GO: GO, coords: Position(col + distance, row + distance, gridSize: radarResult.size)) --- use this if want to create new grid based off radar results -- remember to input new grid size
                    
                }
            }
        }
        print("\nresults of radar:")
        print("\(result)")
        return result
    }
}
