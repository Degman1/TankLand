//
//  TankLandGrid.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct TankLandGrid: CustomStringConvertible {
    var grid: [[GameObject?]] = [[]]
    var size: Int = Constants.gridSize
    
    init() {
        for i in 0..<size {
            grid.append([])
            for _ in 0..<size {
                grid[i].append(nil)
            }
        }
    }
    
    //create a tank on the grid
    mutating func generateGO(GO: GameObject, coords: Position) {
        assert(coords.x >= 0 || coords.x < size, "Row index out of range for GO generation")
        assert(coords.y >= 0 || coords.y < size, "Column index out of range for GO generation")
        grid[coords.y][coords.x] = GO
        print("GO \(GO) at position \(coords) has been generated")
    }
    
    //remove a tank from the grid
    mutating func destroyGO(GO: GameObject, coords: Position) {
        assert(coords.x >= 0 || coords.x < size, "Row index out of range for GO destruction")
        assert(coords.y >= 0 || coords.y < size, "Column index out of range for GO destruction")    //assertions to make sure the GO location is in the grid
        grid[coords.y][coords.x] = nil
        print("GO \(GO) at position \(coords) has been destroyed")
    }
    
    //create a display of the grid for interface purposes
    var description: String {
        var gridDisplay = ""        //stores the display
        
        gridDisplay += String(repeating: "_________", count: size) + "_\n"  //add an initial dividor line for the top of the grid
        
        for row in 0..<size {             //loop through the # of rows
            for attribute in 0...3 {            //within each row, loop through 4 times (1 for the top dividor and the other three for the game object info)
                if attribute == 3 { gridDisplay += String(repeating: "|________", count: size) + "|\n"; continue }    //if its the last line in the sequence of each row, print the dividor line
                for column in 0..<size {     //within each row of looping through 4 times (will reach this loop 3 of the 4), loop through the # of columns access each individual element on the grid
                    if attribute == 0 {
                        gridDisplay += "|\(fit((grid[row][column] == nil ? "" : "\(grid[row][column]!.name)"), 8, right: true))"
                    } else if attribute == 1 {
                        gridDisplay += "|\(fit(grid[row][column] == nil ? "" : "\(grid[row][column]!.energyLevel)", 8, right: true))"
                    } else if attribute == 2 {
                        gridDisplay += "|\(fit((grid[row][column] == nil ? "" : "\(grid[row][column]!.type)"), 8, right: true))"
                    }
                    
                }
                gridDisplay += "|\n"    //add the last dividor to finish the row
            }
        }
        return gridDisplay
    }
}
