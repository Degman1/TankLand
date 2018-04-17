//
//  main.swift
//  TankLand
//
//  Created by David Gerard on 4/6/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

print("Hello World")

var GOs: [GameObject] = []

var grid = Grid()
var j1 = GameObject(name: "J1", initialCoords: Position(1, 1))
GOs.append(j1)
grid.generateGO(GO: j1, coords: j1.coords)

var j2 = GameObject(name: "J2", initialCoords: Position(1, 2))
GOs.append(j2)
grid.generateGO(GO: j2, coords: j2.coords)
print(grid)
var radar1 = RadarResult(gameGrid: grid, origin: j1.coords, distance: 2)
radar1.runRadar()

/*var j2 = GameObject(name: "J2", initialCoords: Position(0, 1))
GOs.append(j2)
var j3 = GameObject(name: "J3", initialCoords: Position(1, 0))
GOs.append(j3)
var j4 = GameObject(name: "J4", initialCoords: Position(14, 14))
GOs.append(j4)
grid.generateGO(GO: j1, coords: j1.coords)
grid.generateGO(GO: j2, coords: j2.coords)
grid.generateGO(GO: j3, coords: j3.coords)
grid.generateGO(GO: j4, coords: j4.coords)
print(grid)
print()
grid.destroyGO(GO: j2, coords: j2.coords)
grid.generateGO_rand(GO: j1)
print(grid)*/
