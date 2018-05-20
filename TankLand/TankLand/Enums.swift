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
    case mine, rover, tank
}

//relative location directions:
enum Direction: Int {
    case N, NE, E, SE, S, SW, W, NW
}

enum Actions {
    case Move, Shields, Missile, Radar, SendMessage, ReceiveMessage, DropMine
}
