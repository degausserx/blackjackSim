//
//  House.swift
//  BlackjackSimulator
//
//  Created by Admin on 06/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

class House: NSObject, NSCoding {
    
    var draw17:Bool = false
    var holecard:Bool = false
    var doubleonsoft:Bool = true
    var splitacesone:Bool = true
    var splitacesnobjs:Bool = true
    var resplitaces:Bool = true
    var surrender:Bool = false
    var surrendervsace:Bool = false
    var surrenderearly:Bool = false
    var decks:Int = 6
    var maxsplits:Int = 0
    
    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.draw17 = aDecoder.decodeBool(forKey: "draw17")
        self.holecard = aDecoder.decodeBool(forKey: "holecard")
        self.doubleonsoft = aDecoder.decodeBool(forKey: "doubleonsoft")
        self.splitacesone = aDecoder.decodeBool(forKey: "splitacesone")
        self.splitacesnobjs = aDecoder.decodeBool(forKey: "splitacesnobjs")
        self.resplitaces = aDecoder.decodeBool(forKey: "resplitaces")
        self.surrender = aDecoder.decodeBool(forKey: "surrender")
        self.surrendervsace = aDecoder.decodeBool(forKey: "surrendervsace")
        self.surrenderearly = aDecoder.decodeBool(forKey: "surrenderearly")
        self.decks = aDecoder.decodeInteger(forKey: "decks")
        self.maxsplits = aDecoder.decodeInteger(forKey: "maxsplits")
    }
    
    func encode(with: NSCoder) {
        with.encode(self.draw17, forKey: "draw17")
        with.encode(self.holecard, forKey: "holecard")
        with.encode(self.doubleonsoft, forKey: "doubleonsoft")
        with.encode(self.splitacesone, forKey: "splitacesone")
        with.encode(self.splitacesnobjs, forKey: "splitacesnobjs")
        with.encode(self.resplitaces, forKey: "resplitaces")
        with.encode(self.surrender, forKey: "surrender")
        with.encode(self.surrendervsace, forKey: "surrendervsace")
        with.encode(self.surrenderearly, forKey: "surrenderearly")
        with.encode(self.decks, forKey: "decks")
        with.encode(self.maxsplits, forKey: "maxsplits")
    }
    
}
