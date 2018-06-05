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

//var j1 = SampleTank(id: "1_SampleTank", row: 5, col: 5, energy: Constants.initialTankEnergy, instructions: "")
var j2 = GameTank(id: "1_GameTank", row: 4, col: 4, energy: Constants.initialTankEnergy, instructions: "")
var j3 = SampleTank(id: "3_SampleTank", row: 5, col: 6, energy: Constants.initialTankEnergy, instructions: "")
var tanks = [j2, j3]
tankWorld.populateTankWorld(tanks: tanks)

tankWorld.driver()

func newPosition(position: Position, direction: Direction, magnitude: Int) -> Position {
    switch (direction) {
    case Direction.N : return Position(position.x, position.y - magnitude)
    case Direction.NE : return Position(position.x + magnitude, position.y - magnitude)
    case Direction.E : return Position(position.x + magnitude, position.y)
    case Direction.SE : return Position(position.x + magnitude, position.y + magnitude)
    case Direction.S : return Position(position.x, position.y + magnitude)
    case Direction.SW : return Position(position.x - magnitude, position.y + magnitude)
    case Direction.W : return Position(position.x - magnitude, position.y)
    case Direction.NW : return Position(position.x - magnitude, position.y - magnitude)
        
        /*case Direction.N : return Position(position.y - magnitude, position.x)  //TODO: what is happening. Why is the x and y coords switched -- find out why + swap back to above
         case Direction.NE : return Position(position.y - magnitude, position.x + magnitude)
         case Direction.E : return Position(position.y, position.x + magnitude)
         case Direction.SE : return Position(position.y + magnitude, position.x + magnitude)
         case Direction.S : return Position(position.y + magnitude, position.x)
         case Direction.SW : return Position(position.y + magnitude, position.x - magnitude)
         case Direction.W : return Position(position.y, position.x - magnitude)
         case Direction.NW : return Position(position.y - magnitude, position.x - magnitude)*/
    }
}
//let pos = Position(1, 1)
//let newPos = newPosition(position: pos, direction: .NW, magnitude: 1)
//print(newPos)


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
