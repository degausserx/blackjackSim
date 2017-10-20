//
//  VarText.swift
//  BlackjackSimulator
//
//  Created by Admin on 08/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

struct VarText {
    
    struct Exec {
        static let headers: [String] = ["Card defaults", "Processing"]
        static let items: [String] = ["Player card 1", "Player card 2", "Dealer card", "Number of hands"]
        static let cards: [String] = ["None", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Ace"]
        static let loops: [Int] = [100, 1000, 10000, 50000, 100000, 500000, 1000000, 10000000, 50000000, 100000000]
        static let loopsSelection: [Int: Int] = [100: 0, 1000: 1, 10000: 2, 50000: 3, 100000 : 4, 500000: 5, 1000000 : 6, 10000000: 7, 50000000: 8, 100000000: 9]
    }
    
    struct House {
        static let headers: [String] = ["Variable integers", "Rule switches"]
        static let options: [String] = ["Decks", "Maximum splits", "Hole card", "Dealer draws on soft 17", "Double on soft hands", "Split aces one card", "Split aces no blackjacks", "Resplit aces", "Surrender Available", "Surrender against ace", "Early surrender"]
        static let decks: [String] = ["One", "Two", "Three", "Four", "Six", "Eight"]
        static let splits: [String] = ["One", "Two", "Three", "Unlimited"]
        static let deckDataActual:[Int] = [1,2,3,4,6,8]
    }
    
    struct Results {
        static let options:[String] = ["Games played","Individual hands","Wins","Draws","Losses","Units won","Units lost","Player blackjack rate","Dealer bust rate","House edge"]
    }

}
