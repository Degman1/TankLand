//
//  main.swift
//  TankLand
//
//  Created by David Gerard on 4/6/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

print("Hello World")

var GO: [GameObject] = []

var grid = TankLandGrid()
var j1 = GameObject(name: "J1", type: GameObjectType.tank, initialCoords: Position(0, 0))
GO.append(j1)
var j2 = GameObject(name: "J2", type: GameObjectType.missile, initialCoords: Position(0, 1))
GO.append(j2)
var j3 = GameObject(name: "J3", type: GameObjectType.rover, initialCoords: Position(1, 0))
GO.append(j3)
var j4 = GameObject(name: "J4", type: GameObjectType.mine, initialCoords: Position(14, 14))
GO.append(j4)
grid.generateGO(GO: j1, coords: j1.coords)
grid.generateGO(GO: j2, coords: j2.coords)
grid.generateGO(GO: j3, coords: j3.coords)
grid.generateGO(GO: j4, coords: j4.coords)
print(grid)
print()
grid.destroyGO(GO: j2, coords: j2.coords)
print(grid)
