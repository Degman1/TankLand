//
//  Enums.swift
//  TankLand
//
//  Created by David Gerard on 4/11/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

//different types of game objects:
enum GameObjectType {
    case tank, mine, rover, missile
}

//relative location directions:
enum Direction {
    case N, NE, E, SE, S, SW, W, NW
}
