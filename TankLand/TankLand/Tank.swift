//
//  Tank.swift
//  TankLand
//
//  Created by David Gerard on 4/6/18.
//  Copyright © 2018 David Gerard. All rights reserved.
//

import Foundation

class Tank:  GameObject {
    private (set) var shields: Int = 0
    private var radarResults: [RadarResult]?
    private var receivedMessage: String?
    private var receivedMessage: String?
    private (set) var preActions: [Actions: PreAction]()
    private (set) var postActions: [Actions: PostAction]()
    private let initialInstructions: String
    
    init(row: Int, col: Int, name: String, energy: Int, id: String, instructions: String) {
        initialInstructions = instructions    //this is the instructions given to each tankat the start of the match by the owner so the tank knows which strategies/methods to use
        super.init(row: row, col: col, name: name, energy: energy, id: id)
    }
    
    final func clearActions() {
        preActions: [Actions: PreAction]()
        postActions: [Actions: PostAction]()
    }
    
    final func receiveMessage(message: String?) {receivedMessage = message}
    
    func computePreActions() {
        
    }
    
    func computePostActions() {
        
    }
}
