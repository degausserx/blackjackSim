//
//  Simulation.swift
//  BlackjackSimulator
//
//  Created by Admin on 06/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

class Simulation {
    
    private var deck:[Int] = Array()
    private var deckSource:[Int] = Array()
    var finished: Bool = false
    
    let strat:[String: [Int: String]]
    
    let draw17:Bool
    let holecard:Bool
    let doubleonsoft:Bool
    let splitacesone:Bool
    let splitacesnobjs:Bool
    let resplitaces:Bool
    let surrender:Bool
    let surrendervsace:Bool
    let surrenderearly:Bool
    let decks:Int
    let maxsplits:Int
    
    let player1: Int
    let player2: Int
    let dealer: Int
    let loops: Int
    
    var games:Int = 0;
    var hands:Int = 0;
    var dealer_bust:Int = 0;
    var dealer_lose:Int = 0;
    var dealer_win:Int = 0;
    var units_won:Int = 0;
    var units_lost:Int = 0;
    var blackjacks:Int = 0;
    var dealer_draw:Int = 0;
    var splits:Int = 0;
    
    var total_units: Double {
        return (Double(self.units_lost) + Double(self.units_won))
    }
    
    var edge: Double {
        return (((Double(self.units_lost) / self.total_units) - (Double(self.units_won) / self.total_units)) * 100).rounded(4)
    }
    
    var blackjack_percent: Double {
        return (((splitacesnobjs) ? (Double(self.blackjacks) / Double(self.games)) : (Double(self.blackjacks) / Double(self.hands))) * 100.0).rounded(4)
    }
    
    var dealer_bust_rate: Double {
        return ((Double(self.dealer_bust) / Double(self.games)) * 100.0).rounded(4)
    }
    
    init() {
        strat = Settings.instance.player.getMap()
        draw17 = Settings.instance.house.draw17
        holecard = Settings.instance.house.holecard
        doubleonsoft = Settings.instance.house.doubleonsoft
        splitacesone = Settings.instance.house.splitacesone
        splitacesnobjs = Settings.instance.house.splitacesnobjs
        resplitaces = Settings.instance.house.resplitaces
        surrender = Settings.instance.house.surrender
        surrendervsace = Settings.instance.house.surrendervsace
        surrenderearly = Settings.instance.house.surrenderearly
        decks = Settings.instance.house.decks
        maxsplits = Settings.instance.house.maxsplits
        player1 = Settings.instance.execution.player1
        player2 = Settings.instance.execution.player2
        dealer = Settings.instance.execution.dealer
        loops = Settings.instance.execution.loops
        
        let cards: Int = self.decks * 52
        var i:Int = 0, n:Int = 0
        while (i < cards) {
            n = (i % 13) + 2
            if (n > 11) { n = 10 }
            self.deckSource += [n]
            i += 1
        }
        
        if (player1 != 1) {
            self.deckSource.remove(at: self.deckSource.index(of: player1)!)
        }
        if (player2 != 1) {
            self.deckSource.remove(at: self.deckSource.index(of: player2)!)
        }
        if (dealer != 1) {
            self.deckSource.remove(at: self.deckSource.index(of: dealer)!)
        }
        
    }
    
    func deal() {
        if (deck.count < 25) {
            shuffle()
        }
        
        let dealerHand: Int = (dealer != 1) ? dealer : self.drawCard()
        let dealerFinish: Int = getDealerHand(dealerHand)
        self.splits += self.playerSimulate(player: 0, dealer: dealerHand, dealerFinish: dealerFinish, split: 0, entry: true)
    }
    
    private func shuffle() {
        deck = deckSource
    }
    
    func drawCard() -> Int {
        if (deck.count < 1) {
            shuffle()
        }
        let randomNum: Int = Int(arc4random_uniform(UInt32(deck.count)))
        let returnInt: Int = deck[randomNum]
        deck.remove(at: randomNum)
        return returnInt
    }
    
}


extension Simulation {
    
    func playerSimulate(player: Int, dealer: Int, dealerFinish: Int, split: Int, entry: Bool) -> Int {
        var newCard: Int = 0, hit: Int = 0, cards: Int = (entry) ? 0 : 1, playerHand: Int = player, dealerHand = dealerFinish, splitHand: Int = split
        var blackjack: Bool = false, doubleBet: Bool = false, pair: Bool = false, soft: Bool = false
        var allowSplit: Bool = true, looping = true, noCards = false
        var playerString: String, strat: String = "", tempNum: Int = 0
        
        // simulation loop
        while (looping) {
            looping = false
            
            if (cards < 2) {
                newCard = (splitHand < 1 && self.player1 != 1) ? self.player1 : drawCard()
                cards += 1
                if (cards == 1) {
                    playerHand = (splitHand < 1 && self.player2 != 1) ? self.player2 : drawCard()
                    cards += 1
                }
                if (playerHand == 11 || newCard == 11) {
                    soft = true
                }
                if (playerHand == newCard) {
                    pair = true
                    if (playerHand == 11 && splitHand > 0 && !self.resplitaces) || (splitHand >= self.maxsplits && self.maxsplits != 0) {
                        allowSplit = false
                    }
                }
                newCard += playerHand;
                if (newCard == 21) {
                    if (splitHand == 0 || !self.splitacesnobjs) {
                        blackjack = true
                    }
                    break
                }
                if (player == 11 && splitHand > 0 && self.splitacesone) {
                    noCards = true
                    if (newCard != 22) {
                        break
                    }
                }
                if (newCard == 22) {
                    newCard -= 10
                }
                playerHand = newCard
            }
            
            if (!blackjack) {
                if (self.holecard && dealerFinish == 35 && !self.surrender) {
                    break
                }
                while (playerHand < 21) {
                    playerString = ""
                    if (cards > 2) {
                        pair = false
                    }
                    if (pair && allowSplit) {
                        if (soft) {
                            playerString = "AA"
                        }
                        else if (playerHand == 20) {
                            playerString = "TT"
                        }
                        else {
                            tempNum = playerHand / 2
                            playerString = "\(tempNum)\(tempNum)"
                        }
                    }
                    else if (soft) {
                        playerString = (playerHand == 12) ? "12" : "A\(playerHand - 11)"
                    }
                    else {
                        playerString = String(playerHand)
                    }
                    
                    // make a call for the strategy. 'dealer' is an int
                    strat = self.strat[playerString]![dealer]!
                    
                    // didn't surrender, can't draw cards...
                    if (noCards && strat != "S") {
                        break
                    }
                    
                    // if the move is "surrender" or "surrender, otherwise stand"
                    if (strat == "A" || strat == "B") {
                        if ((cards > 2 || !self.surrender || splitHand > 0 || (!self.surrendervsace && dealer == 11)
                                || (!self.surrenderearly && self.holecard && dealerHand == 35))) {
                            if (strat == "B") {
                                break
                            }
                            hit = 1
                        }
                        else {
                            playerHand = -5
                            break
                        }
                    }
                        
                    // if the dealer has blackjack, after the chance to surrender, auto lose
                    if (cards == 2 && dealerFinish == 35 && self.holecard) {
                        break
                    }
                        
                    // if the move is "no card"
                    if (strat == "X") {
                        break
                    }
                        
                    // splitting 2 cards recursively
                    if (strat == "S") {
                        playerHand = (soft) ? 11 : (playerHand / 2)
                        tempNum = splitHand + 1
                        splitHand = playerSimulate(player: playerHand, dealer: dealer, dealerFinish: dealerHand, split: tempNum, entry: false)
                        cards -= 1
                        looping = true
                        break
                    }
                        
                    // double the bet
                    if (strat == "D" || strat == "E") {
                        if (soft && !self.doubleonsoft && strat == "E") {
                            break
                        }
                        hit = 2
                    }
                        
                    // if the move is taking a card
                    if (strat == "H" || hit > 0) {
                        newCard = drawCard()
                        if (newCard == 11) {
                            if (playerHand > 10) {
                                newCard = 1
                            }
                            else {
                                soft = true
                            }
                        }
                        playerHand += newCard
                        
                        if (playerHand > 21 && soft) {
                            soft = false
                            playerHand -= 10
                        }
                        if (cards == 2 && hit == 2 && (!soft || (soft && self.doubleonsoft))) {
                            doubleBet = true
                        }
                        
                        // reset 'hit', increase cards
                        cards += 1
                        hit = 0
                    }
                        
                }
                    
            }
        
            pair = false
        }
        
        // bust corrections
        if (blackjack) {
            playerHand = 35
            self.blackjacks += 1
        }
        if (dealerHand > 21 && dealerHand != 35) {
            dealerHand = 22
            if (entry) {
                self.dealer_bust += 1
            }
        }
        if (playerHand > 21 && playerHand != 35) {
            playerHand = 22
        }
        
        // games / hands
        if (entry) {
            self.games += 1
        }
        self.hands += 1
        
        // player lose
        if (playerHand == 22 || playerHand == -5 || (playerHand < dealerHand && dealerHand != 22)) {
            self.dealer_win += 1
            if (doubleBet) {
                self.units_lost += 4
            }
            else if (playerHand == -5) {
                self.units_lost += 1
            }
            else {
                self.units_lost += 2
            }
        }
        
        // player draw
        else if (playerHand == dealerHand) {
            self.dealer_draw += 1
        }
        
        // player win
        else {
            self.dealer_lose += 1
            if (playerHand == 35) {
                units_won += 3
            }
            else if (doubleBet) {
                units_won += 4
            }
            else {
                units_won += 2;
            }
        }
        
        return splitHand
    }
    
    func getDealerHand(_ total: Int) -> Int {
        var start: Bool = true, soft: Bool = (total == 11) ? true : false, dealer: Int = total, newCard: Int
        
        repeat {
            
            newCard = drawCard()
            
            if (newCard == 11) {
                if (dealer < 11) {
                    dealer += 11
                    soft = true
                }
                else {
                    dealer += 1
                }
            }
            else {
                dealer += newCard
                if (soft && dealer > 21) {
                    dealer -= 10
                    soft = false
                }
            }
            if (start && dealer == 21) {
                return 35
            }
            
            start = false
            
        } while (dealer < 17 || (draw17 && dealer == 17 && soft))
        
        return dealer
    }
    
}
