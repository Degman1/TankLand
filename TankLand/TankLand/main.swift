//
//  main.swift
//  TankLand
//
//  Created by David Gerard on 4/6/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

print("Hello World\n")


//whole game testing:

var tankWorld = TankWorld()

var j1 = Tank(id: "tank1", row: 0, col: 0, energy: Constants.initialTankEnergy, instructions: "")
var j2 = Tank(id: "tank2", row: 1, col: 2, energy: Constants.initialTankEnergy, instructions: "")
var j3 = SampleTank(id: "SampleTank", row: 5, col: 5, energy: Constants.initialTankEnergy, instructions: "")
var tanks = [j1, j2, j3]
tankWorld.populateTankWorld(tanks: tanks)

tankWorld.driver()


/*//var logger = Logger()

// RadarResult testing:
 
var GOs: [GameObject] = []

var grid = Grid()
var j1 = Tank(id: "tank 1", row: 0, col: 0, energy: Constants.initialTankEnergy, instructions: "")
GOs.append(j1)
grid.generateGO(GO: j1, coords: j1.position)

var j2 = Tank(id: "tank 2", row: 1, col: 2, energy: Constants.initialTankEnergy, instructions: "")
GOs.append(j2)
grid.generateGO(GO: j2, coords: j2.position)

var j3 = Tank(id: "tank 3", row: 0, col: 1, energy: Constants.initialTankEnergy, instructions: "")
GOs.append(j3)
grid.generateGO(GO: j3, coords: j3.position)

print("\(grid)")
var radar1 = RadarResult(gameGrid: grid, origin: j1.position, distance: 1)
let radarResult = radar1.runRadar()

//let output = logger.displayLogger()
*/


/*
// Basic Grid Operation Testing:
 
var GOs: [GameObject] = []
 
var j2 = GameObject(name: "J2", initialCoords: Position(0, 1))
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
