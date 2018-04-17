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
    let GOlocation: Position
    let distance: Int
    var radarResult: Grid
    
    init(gameGrid: Grid, origin: Position, distance: Int) {
        self.gameGrid = gameGrid
        self.GOlocation = origin
        self.distance = distance
        radarResult = Grid(size: (distance * 2) + 1)
    }
    
    mutating func runRadar() -> Grid {
        print("running radar...")
        for row in -distance...distance {
            for col in -distance...distance {
                
                if (GOlocation.x + row < gameGrid.size) && (GOlocation.x + row >= 0) && (GOlocation.y + row < gameGrid.size) && (GOlocation.y + row >= 0), let GO = gameGrid.locateGO(coords: Position(GOlocation.origy + col, GOlocation.x + row)) {   //TODO: HAS PROBLEMS WHEN GOES OUTSIDE OF GAME GRID
                    //if all the coordinates are in boundsof the game grid, then try to unwrap the GO and if it is there, add it to the radarResult grid

                    radarResult.generateGO(GO: GO, coords: Position(col + distance, row + distance, gridSize: radarResult.size))    //using origy instead of y b/c Position will redo the coordinate shift and I don't want the new shifted version reverted -- also inputting size of new grid for the conversion
                }
            }
        }
        print("results of radar:")
        print(radarResult)
        return radarResult
    }
}
