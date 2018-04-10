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
    var size: Int
    
    init(size: Int) {
        self.size = size
        for i in 0..<size {
            grid.append([])
            for _ in 0..<size {
                grid[i].append(nil)
            }
        }
    }
    
    //convert from game coords ((0, 0) being bottom left) to array coords for the grid ((0, 0) being bottom left)
    func convertIndex(coords: (Int, Int)) -> (Int, Int) {
        return (size - coords.0 - 1, size - coords.1 - 1)
    }
    
    //create a tank on the grid
    mutating func generateGO(GO: GameObject, coords: (Int, Int)) {
        assert(coords.0 >= 0 || coords.0 < size, "Row index out of range for GO generation")
        assert(coords.1 >= 0 || coords.1 < size, "Column index out of range for GO generation")
        let index = convertIndex(coords: coords)
        grid[index.0][index.1] = GO
        print("GO \(GO) at position \(index) has been generated")
    }
    
    //remove a tank from the grid
    mutating func destroyGO(GO: GameObject, coords: (Int, Int)) {
        assert(coords.0 >= 0 || coords.0 < size, "Row index out of range for GO destruction")
        assert(coords.1 >= 0 || coords.1 < size, "Column index out of range for GO destruction")
        let index = convertIndex(coords: coords)
        grid[index.0][index.1] = nil
        print("GO \(GO) at position \(index) has been destroyed")
    }
    
    //create a display of the grid for interface purposes
    var description: String {
        var gridDisplay = ""
        
        for row in 0..<size {             //loop through the # of rows
            for attribute in 0...3 {            //within each row, loop through 4 times (1 for the top dividor and the other three for the game object info)
                if attribute == 0 { gridDisplay += String(repeating: "-------", count: size) + "-\n"; continue }
                for column in 0..<size {     //within each row of looping through 4 times, loop through the # of columns access each individual element on the
                    switch (attribute) {
                    case 1: gridDisplay += "|\(fit(String(describing: grid[row][column]), 6, right: true))"
                    case 2: gridDisplay += "|\(fit(String(describing: grid[row][column]), 6, right: true))"
                    case 3: gridDisplay += "|\(fit(String(describing: grid[row][column]), 6, right: true))"
                    default: return "error error error"    //TODO: is there a way to tell the switch statement that it will always be exhaustive no matter the inclusion of a default case
                    }
                }
                gridDisplay += "|\n"
            }
        }
        gridDisplay += String(repeating: "-------", count: size) + "-"
        return gridDisplay
    }
}
