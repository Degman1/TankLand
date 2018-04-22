//
//  Protocols.swift
//  TankLand
//
//  Created by David Gerard on 4/21/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

//pre-action protocols:

protocol Communicative {
    func sendMessage()
    func recieveMessage()
}

protocol RadarAble {    //able to create + run a radar -- find better name
    func runRadar()
}

protocol Protectable {      //able to create shields
    func setShields()
    func shutDownShields()
}

//action protocols:

protocol ArmedMineOrRover {
    func dropMine()
    func dropRover()
}

protocol ArmedMissile {
    func launchMissile()
}

protocol Moveable {
    func move()
}

