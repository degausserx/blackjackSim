//
//  Player.swift
//  BlackjackSimulator
//
//  Created by etudiant on 04/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

class Player: NSObject, NSCoding {
    
    private var basic:[String: [Int: String]] = [:]

    override init() {
        super.init()
        if basic.count == 0 {
            self.loadDefaults()
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let theMap = aDecoder.decodeObject(forKey: "stratMap") as! [String: [Int: String]]? {
            self.basic = theMap
        }
        else {
            return nil
        }
    }
    
    func encode(with: NSCoder) {
        with.encode(self.basic, forKey: "stratMap")
    }
    
    func getMap() -> [String: [Int: String]] {
        return basic
    }
    
    func putBaseStrat(player: String, dealer: Int, strat: String) {
        if let _ = basic[player] {
            basic[player]![dealer]! = strat
        }
        else {
            print("Bad putBaseStrat() values")
        }
    }
    
    func getBaseStrat(player: String, dealer: Int) -> String {
        if let player = basic[player], let strat = player[dealer] {
            return strat
        }
        else {
            print("Bad getBaseStrat() values")
            return "N"
        }
    }
    
    func loadDefaults() {
        var map_2:[Int: String] = [:]
        var map_5:[Int: String] = [:]
        var map_9:[Int: String] = [:]
        var map_10:[Int: String] = [:]
        var map_12:[Int: String] = [:]
        var map_13:[Int: String] = [:]
        var map_14:[Int: String] = [:]
        var map_15:[Int: String] = [:]
        var map_16:[Int: String] = [:]
        var map_17:[Int: String] = [:]
        var map_18:[Int: String] = [:]
        var map_A2:[Int: String] = [:]
        var map_A4:[Int: String] = [:]
        var map_A6:[Int: String] = [:]
        var map_A7:[Int: String] = [:]
        var map_22:[Int: String] = [:]
        var map_33:[Int: String] = [:]
        var map_44:[Int: String] = [:]
        var map_55:[Int: String] = [:]
        var map_66:[Int: String] = [:]
        var map_77:[Int: String] = [:]
        var map_88:[Int: String] = [:]
        var map_99:[Int: String] = [:]
        var map_TT:[Int: String] = [:]
        var map_AA:[Int: String] = [:]
        
        map_2.updateValue("H", forKey: 2)
        map_2.updateValue("H", forKey: 3)
        map_2.updateValue("H", forKey: 4)
        map_2.updateValue("H", forKey: 5)
        map_2.updateValue("H", forKey: 6)
        map_2.updateValue("H", forKey: 7)
        map_2.updateValue("H", forKey: 8)
        map_2.updateValue("H", forKey: 9)
        map_2.updateValue("H", forKey: 10)
        map_2.updateValue("H", forKey: 11)
        map_5.updateValue("H", forKey: 2)
        map_5.updateValue("H", forKey: 3)
        map_5.updateValue("H", forKey: 4)
        map_5.updateValue("H", forKey: 5)
        map_5.updateValue("H", forKey: 6)
        map_5.updateValue("H", forKey: 7)
        map_5.updateValue("H", forKey: 8)
        map_5.updateValue("H", forKey: 9)
        map_5.updateValue("H", forKey: 10)
        map_5.updateValue("A", forKey: 11)
        map_9.updateValue("H", forKey: 2)
        map_9.updateValue("D", forKey: 3)
        map_9.updateValue("D", forKey: 4)
        map_9.updateValue("D", forKey: 5)
        map_9.updateValue("D", forKey: 6)
        map_9.updateValue("H", forKey: 7)
        map_9.updateValue("H", forKey: 8)
        map_9.updateValue("H", forKey: 9)
        map_9.updateValue("H", forKey: 10)
        map_9.updateValue("H", forKey: 11)
        map_10.updateValue("D", forKey: 2)
        map_10.updateValue("D", forKey: 3)
        map_10.updateValue("D", forKey: 4)
        map_10.updateValue("D", forKey: 5)
        map_10.updateValue("D", forKey: 6)
        map_10.updateValue("D", forKey: 7)
        map_10.updateValue("D", forKey: 8)
        map_10.updateValue("D", forKey: 9)
        map_10.updateValue("H", forKey: 10)
        map_10.updateValue("H", forKey: 11)
        map_12.updateValue("H", forKey: 2)
        map_12.updateValue("H", forKey: 3)
        map_12.updateValue("X", forKey: 4)
        map_12.updateValue("X", forKey: 5)
        map_12.updateValue("X", forKey: 6)
        map_12.updateValue("H", forKey: 7)
        map_12.updateValue("H", forKey: 8)
        map_12.updateValue("H", forKey: 9)
        map_12.updateValue("H", forKey: 10)
        map_12.updateValue("A", forKey: 11)
        map_13.updateValue("H", forKey: 2)
        map_13.updateValue("X", forKey: 3)
        map_13.updateValue("X", forKey: 4)
        map_13.updateValue("X", forKey: 5)
        map_13.updateValue("X", forKey: 6)
        map_13.updateValue("H", forKey: 7)
        map_13.updateValue("H", forKey: 8)
        map_13.updateValue("H", forKey: 9)
        map_13.updateValue("H", forKey: 10)
        map_13.updateValue("A", forKey: 11)
        map_14.updateValue("X", forKey: 2)
        map_14.updateValue("X", forKey: 3)
        map_14.updateValue("X", forKey: 4)
        map_14.updateValue("X", forKey: 5)
        map_14.updateValue("X", forKey: 6)
        map_14.updateValue("H", forKey: 7)
        map_14.updateValue("H", forKey: 8)
        map_14.updateValue("H", forKey: 9)
        map_14.updateValue("A", forKey: 10)
        map_14.updateValue("A", forKey: 11)
        map_15.updateValue("X", forKey: 2)
        map_15.updateValue("X", forKey: 3)
        map_15.updateValue("X", forKey: 4)
        map_15.updateValue("X", forKey: 5)
        map_15.updateValue("X", forKey: 6)
        map_15.updateValue("H", forKey: 7)
        map_15.updateValue("H", forKey: 8)
        map_15.updateValue("H", forKey: 9)
        map_15.updateValue("A", forKey: 10)
        map_15.updateValue("A", forKey: 11)
        map_16.updateValue("X", forKey: 2)
        map_16.updateValue("X", forKey: 3)
        map_16.updateValue("X", forKey: 4)
        map_16.updateValue("X", forKey: 5)
        map_16.updateValue("X", forKey: 6)
        map_16.updateValue("H", forKey: 7)
        map_16.updateValue("H", forKey: 8)
        map_16.updateValue("A", forKey: 9)
        map_16.updateValue("A", forKey: 10)
        map_16.updateValue("A", forKey: 11)
        map_17.updateValue("X", forKey: 2)
        map_17.updateValue("X", forKey: 3)
        map_17.updateValue("X", forKey: 4)
        map_17.updateValue("X", forKey: 5)
        map_17.updateValue("X", forKey: 6)
        map_17.updateValue("X", forKey: 7)
        map_17.updateValue("X", forKey: 8)
        map_17.updateValue("X", forKey: 9)
        map_17.updateValue("X", forKey: 10)
        map_17.updateValue("A", forKey: 11)
        map_18.updateValue("X", forKey: 2)
        map_18.updateValue("X", forKey: 3)
        map_18.updateValue("X", forKey: 4)
        map_18.updateValue("X", forKey: 5)
        map_18.updateValue("X", forKey: 6)
        map_18.updateValue("X", forKey: 7)
        map_18.updateValue("X", forKey: 8)
        map_18.updateValue("X", forKey: 9)
        map_18.updateValue("X", forKey: 10)
        map_18.updateValue("X", forKey: 11)
        map_A2.updateValue("H", forKey: 2)
        map_A2.updateValue("H", forKey: 3)
        map_A2.updateValue("H", forKey: 4)
        map_A2.updateValue("D", forKey: 5)
        map_A2.updateValue("D", forKey: 6)
        map_A2.updateValue("H", forKey: 7)
        map_A2.updateValue("H", forKey: 8)
        map_A2.updateValue("H", forKey: 9)
        map_A2.updateValue("H", forKey: 10)
        map_A2.updateValue("H", forKey: 11)
        map_A4.updateValue("H", forKey: 2)
        map_A4.updateValue("H", forKey: 3)
        map_A4.updateValue("D", forKey: 4)
        map_A4.updateValue("D", forKey: 5)
        map_A4.updateValue("D", forKey: 6)
        map_A4.updateValue("H", forKey: 7)
        map_A4.updateValue("H", forKey: 8)
        map_A4.updateValue("H", forKey: 9)
        map_A4.updateValue("H", forKey: 10)
        map_A4.updateValue("H", forKey: 11)
        map_A6.updateValue("H", forKey: 2)
        map_A6.updateValue("D", forKey: 3)
        map_A6.updateValue("D", forKey: 4)
        map_A6.updateValue("D", forKey: 5)
        map_A6.updateValue("D", forKey: 6)
        map_A6.updateValue("H", forKey: 7)
        map_A6.updateValue("H", forKey: 8)
        map_A6.updateValue("H", forKey: 9)
        map_A6.updateValue("H", forKey: 10)
        map_A6.updateValue("H", forKey: 11)
        map_A7.updateValue("X", forKey: 2)
        map_A7.updateValue("E", forKey: 3)
        map_A7.updateValue("E", forKey: 4)
        map_A7.updateValue("E", forKey: 5)
        map_A7.updateValue("E", forKey: 6)
        map_A7.updateValue("X", forKey: 7)
        map_A7.updateValue("X", forKey: 8)
        map_A7.updateValue("H", forKey: 9)
        map_A7.updateValue("H", forKey: 10)
        map_A7.updateValue("H", forKey: 11)
        map_AA.updateValue("S", forKey: 2)
        map_AA.updateValue("S", forKey: 3)
        map_AA.updateValue("S", forKey: 4)
        map_AA.updateValue("S", forKey: 5)
        map_AA.updateValue("S", forKey: 6)
        map_AA.updateValue("S", forKey: 7)
        map_AA.updateValue("S", forKey: 8)
        map_AA.updateValue("S", forKey: 9)
        map_AA.updateValue("S", forKey: 10)
        map_AA.updateValue("H", forKey: 11)
        map_22.updateValue("S", forKey: 2)
        map_22.updateValue("S", forKey: 3)
        map_22.updateValue("S", forKey: 4)
        map_22.updateValue("S", forKey: 5)
        map_22.updateValue("S", forKey: 6)
        map_22.updateValue("S", forKey: 7)
        map_22.updateValue("H", forKey: 8)
        map_22.updateValue("H", forKey: 9)
        map_22.updateValue("H", forKey: 10)
        map_22.updateValue("H", forKey: 11)
        map_33.updateValue("S", forKey: 2)
        map_33.updateValue("S", forKey: 3)
        map_33.updateValue("S", forKey: 4)
        map_33.updateValue("S", forKey: 5)
        map_33.updateValue("S", forKey: 6)
        map_33.updateValue("S", forKey: 7)
        map_33.updateValue("H", forKey: 8)
        map_33.updateValue("H", forKey: 9)
        map_33.updateValue("H", forKey: 10)
        map_33.updateValue("A", forKey: 11)
        map_44.updateValue("H", forKey: 2)
        map_44.updateValue("H", forKey: 3)
        map_44.updateValue("H", forKey: 4)
        map_44.updateValue("S", forKey: 5)
        map_44.updateValue("S", forKey: 6)
        map_44.updateValue("H", forKey: 7)
        map_44.updateValue("H", forKey: 8)
        map_44.updateValue("H", forKey: 9)
        map_44.updateValue("H", forKey: 10)
        map_44.updateValue("H", forKey: 11)
        map_55.updateValue("D", forKey: 2)
        map_55.updateValue("D", forKey: 3)
        map_55.updateValue("D", forKey: 4)
        map_55.updateValue("D", forKey: 5)
        map_55.updateValue("D", forKey: 6)
        map_55.updateValue("D", forKey: 7)
        map_55.updateValue("D", forKey: 8)
        map_55.updateValue("D", forKey: 9)
        map_55.updateValue("H", forKey: 10)
        map_55.updateValue("H", forKey: 11)
        map_66.updateValue("S", forKey: 2)
        map_66.updateValue("S", forKey: 3)
        map_66.updateValue("S", forKey: 4)
        map_66.updateValue("S", forKey: 5)
        map_66.updateValue("S", forKey: 6)
        map_66.updateValue("H", forKey: 7)
        map_66.updateValue("H", forKey: 8)
        map_66.updateValue("H", forKey: 9)
        map_66.updateValue("H", forKey: 10)
        map_66.updateValue("A", forKey: 11)
        map_77.updateValue("S", forKey: 2)
        map_77.updateValue("S", forKey: 3)
        map_77.updateValue("S", forKey: 4)
        map_77.updateValue("S", forKey: 5)
        map_77.updateValue("S", forKey: 6)
        map_77.updateValue("S", forKey: 7)
        map_77.updateValue("H", forKey: 8)
        map_77.updateValue("H", forKey: 9)
        map_77.updateValue("A", forKey: 10)
        map_77.updateValue("A", forKey: 11)
        map_88.updateValue("S", forKey: 2)
        map_88.updateValue("S", forKey: 3)
        map_88.updateValue("S", forKey: 4)
        map_88.updateValue("S", forKey: 5)
        map_88.updateValue("S", forKey: 6)
        map_88.updateValue("S", forKey: 7)
        map_88.updateValue("S", forKey: 8)
        map_88.updateValue("S", forKey: 9)
        map_88.updateValue("A", forKey: 10)
        map_88.updateValue("A", forKey: 11)
        map_99.updateValue("S", forKey: 2)
        map_99.updateValue("S", forKey: 3)
        map_99.updateValue("S", forKey: 4)
        map_99.updateValue("S", forKey: 5)
        map_99.updateValue("S", forKey: 6)
        map_99.updateValue("X", forKey: 7)
        map_99.updateValue("S", forKey: 8)
        map_99.updateValue("S", forKey: 9)
        map_99.updateValue("X", forKey: 10)
        map_99.updateValue("X", forKey: 11)
        map_TT.updateValue("X", forKey: 2)
        map_TT.updateValue("X", forKey: 3)
        map_TT.updateValue("X", forKey: 4)
        map_TT.updateValue("X", forKey: 5)
        map_TT.updateValue("X", forKey: 6)
        map_TT.updateValue("X", forKey: 7)
        map_TT.updateValue("X", forKey: 8)
        map_TT.updateValue("X", forKey: 9)
        map_TT.updateValue("X", forKey: 10)
        map_TT.updateValue("X", forKey: 11)
        
        basic.updateValue(map_2, forKey: "3")
        basic.updateValue(map_2, forKey: "4")
        basic.updateValue(map_2, forKey: "8")
        basic.updateValue(map_5, forKey: "5")
        basic.updateValue(map_5, forKey: "6")
        basic.updateValue(map_5, forKey: "7")
        basic.updateValue(map_9, forKey: "9")
        basic.updateValue(map_10, forKey: "10")
        basic.updateValue(map_10, forKey: "11")
        basic.updateValue(map_12, forKey: "12")
        basic.updateValue(map_13, forKey: "13")
        basic.updateValue(map_14, forKey: "14")
        basic.updateValue(map_15, forKey: "15")
        basic.updateValue(map_16, forKey: "16")
        basic.updateValue(map_17, forKey: "17")
        basic.updateValue(map_18, forKey: "18")
        basic.updateValue(map_18, forKey: "19")
        basic.updateValue(map_18, forKey: "20")
        basic.updateValue(map_A2, forKey: "A2")
        basic.updateValue(map_A2, forKey: "A3")
        basic.updateValue(map_A4, forKey: "A4")
        basic.updateValue(map_A4, forKey: "A5")
        basic.updateValue(map_A6, forKey: "A6")
        basic.updateValue(map_A7, forKey: "A7")
        basic.updateValue(map_18, forKey: "A8")
        basic.updateValue(map_18, forKey: "A9")
        basic.updateValue(map_AA, forKey: "AA")
        basic.updateValue(map_22, forKey: "22")
        basic.updateValue(map_33, forKey: "33")
        basic.updateValue(map_44, forKey: "44")
        basic.updateValue(map_55, forKey: "55")
        basic.updateValue(map_66, forKey: "66")
        basic.updateValue(map_77, forKey: "77")
        basic.updateValue(map_88, forKey: "88")
        basic.updateValue(map_99, forKey: "99")
        basic.updateValue(map_TT, forKey: "TT")
    }
}
