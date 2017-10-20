//
//  Execution.swift
//  BlackjackSimulator
//
//  Created by Admin on 06/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

class Execution: NSObject, NSCoding {
    public var player1: Int = 1
    public var player2: Int = 1
    public var dealer: Int = 1
    public var loops: Int = 1000
    
    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.player1 = aDecoder.decodeInteger(forKey: "player1")
        self.player2 = aDecoder.decodeInteger(forKey: "player2")
        self.dealer = aDecoder.decodeInteger(forKey: "dealer")
        self.loops = aDecoder.decodeInteger(forKey: "loops")
    }
    
    func encode(with: NSCoder) {
        with.encode(self.player1, forKey: "player1")
        with.encode(self.player2, forKey: "player2")
        with.encode(self.dealer, forKey: "dealer")
        with.encode(self.loops, forKey: "loops")
    }
}
