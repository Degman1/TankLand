//
//  TankLandGrid.swift
//  TankLand
//
//  Created by David Gerard on 4/7/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

struct Grid: CustomStringConvertible {
    var grid: [[GameObject?]]
    var size: Int
    
    init(size: Int = Constants.gridSize) {
        self.size = size
        grid = Array(repeating: Array(repeating: nil, count: size), count: size)
    }
    
    static func isValidPosition(_ p: Position) -> Bool {
        if p.x <= 14 && p.x >= 0 && p.y >= 0 && p.y <= 14 {
            return true
        }
        return false
    }
    
    //create a tank on the grid
    mutating func generateGO(GO: GameObject, coords: Position) {
        if Grid.isValidPosition(coords) {
            grid[coords.y][coords.x] = GO
            GO.setPosition(newPosition: coords)
            //print("Game Object '\(GO.id)' at position \(coords) has been generated")
        }
    }
    
    //create a tank on the grid
    mutating func generateGO_rand(GO: GameObject) {
        let coords = Position.getRandomCoords()
        grid[coords.y][coords.x] = GO
        GO.setPosition(newPosition: coords)
        //print("Game Object '\(GO.id)' at position \(coords) has been generated")
    }
    
    //remove a tank from the grid
    mutating func removeGO(GO: GameObject) {
        if Grid.isValidPosition(GO.position) {
            grid[GO.position.y][GO.position.x] = nil
            //print("Game Object '\(GO.id)' at position \(coords) has been destroyed")
        }
    }
    
    mutating func moveGO(GO: GameObject, newCoords: Position) {
        if Grid.isValidPosition(newCoords) {
            removeGO(GO: GO)
            generateGO(GO: GO, coords: newCoords)
            GO.setPosition(newPosition: newCoords)
        } else {
            //print("invalid coordinates for moving GO")
        }
    }
    
    //find the contents of a given location
    func getGO(coords: Position) -> GameObject? {
        if Grid.isValidPosition(coords) {
            return grid[coords.y][coords.x]
        }
        return nil
    }
    
    func isPositionEmpty(_ position: Position) -> Bool {
        if getGO(coords: position) == nil {
            return true
        }
        return false
    }
    
    //create a display of the grid for interface purposes
    var description: String {
        var gridDisplay = String(repeating: "_________", count: size) + "_\n"  //add an initial dividor line for the top of the grid
        for row in 0..<size {             //loop through the # of rows
            for attribute in 0...3 {            //within each row, loop through 4 times (1 for the top dividor and the other three for the game object info)
                if attribute == 3 { gridDisplay += String(repeating: "|________", count: size) + "|\n"; continue }    //if its the last line in the sequence of each row, print the dividor line
                for column in 0..<size {     //within each row of looping through 4 times (will reach this loop 3 of the 4), loop through the # of columns access each individual element on the grid
                    if attribute == 0 {
                        gridDisplay += "|\(fit((grid[row][column] == nil ? "" : "\(grid[row][column]!.energy)"), 8, right: true))"
                    } else if attribute == 1 {
                        gridDisplay += "|\(fit(grid[row][column] == nil ? "" : "\(grid[row][column]!.id)", 8, right: true))"
                    } else if attribute == 2 {
                        gridDisplay += "|\(fit((grid[row][column] == nil ? "" : "\(grid[row][column]!.position)"), 8, right: true))"
                    }
                    
                }
                gridDisplay += "|\n"    //add the last dividor to finish the row
            }
        }
        return gridDisplay
    }
}
