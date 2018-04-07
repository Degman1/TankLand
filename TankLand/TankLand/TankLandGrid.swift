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
        for i in 0...size {
            grid.append([])
            for _ in 0...size {
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
    
    var description: String {
        var gridDisplay = ""

        for i in 0..<size {
            for j in 0..<size {
                if i % 2 == 0 {
                    gridDisplay += "-------"
                } else {
                    gridDisplay += "|\(fit(String(describing: grid[i][j]), 6))"
                }
            }
            gridDisplay += (i % 2 == 0) ? "\n" : "|\n"
        }
        return gridDisplay
    }
}
