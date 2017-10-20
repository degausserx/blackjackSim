//
//  PlayerCollectionViewController.swift
//  BlackjackSimulator
//
//  Created by etudiant on 04/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class PlayerCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let playStratCell = "PlayerCell"

    @IBOutlet weak var playerGrid: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerGrid.delegate = self
        self.playerGrid.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (Settings.instance.reloadPlayer) {
            Settings.instance.reloadPlayer = false
            self.playerGrid.reloadData()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 440
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playStratCell, for: indexPath) as! PlayerStratCollectionViewCell

        cell.cellLabelView.text = getCellText(indexPath.item)
        let bg:UIColor = getBackground(indexPath.item, cell.cellLabelView.text!)
        cell.cellBackgroundView.backgroundColor = bg
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let a = indexPath.item
        if validSquare(a) {
            if let cell = collectionView.cellForItem(at: indexPath) as? PlayerStratCollectionViewCell {
                openAlert(indexPath.item, cell)
            }
        }
    }
    
}

extension PlayerCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        let side = ((screen.width - 11) / 12.0)
        return CGSize(width: ((indexPath.item % 11) == 0 ? side*2 : side) , height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let _ = playerGrid {
            playerGrid.collectionViewLayout.invalidateLayout()
        }
    }
}

extension PlayerCollectionViewController {
    
    func getBackground(_ i: Int, _ action: String) -> UIColor {
        var value: String = Colors.Green
        
        if (i == 0 || i == 308 || i == 429 || i == 209) {
            value = Colors.White
        }
        else if !validSquare(i) {
            value = (i % 2 == 0) ? Colors.G5 : Colors.G4
        }
        else {
            switch (action) {
            case "X":
                value = Colors.Orange
            case "H":
                value = Colors.Purple
            case "D", "E":
                value = Colors.Green
            case "S":
                value = Colors.Aqua
            case "A", "B":
                value = Colors.Yellow
            default:
                value = Colors.White
            }
        }
        
        return UIColor(hex: value)
    }
    
    func getCellText(_ i: Int) -> String {
        if (i == 0 || i == 308 || i == 429 || i == 209) {
            return ""
        }
        else if !validSquare(i) && i % 11 != 0 {
            return (i % 11 == 10) ? "A" : "\((i % 11) + 1)"
        }
        else if (i % 11 == 0) {
            return getPlayer(i)
        }
        return Settings.instance.player.getBaseStrat(player: getPlayer(i), dealer: getDealer(i))
    }
    
    func getDealer(_ i: Int) -> Int {
        return (i % 11) + 1
    }
    
    func getPlayer(_ i: Int) -> String {
        if (i < 209) {
            return String((i / 11) + 2)
        }
        else if (i < 308) {
            return "A\(((i / 11) - 18))"
        }
        else {
            let n:Int = (i / 11)
            if (n > 29 && n < 38) {
                return "\(n - 28)\(n - 28)"
            }
            return (n == 29) ? "AA" : "TT"
        }
    }
    
    func validSquare(_ i: Int) -> Bool {
        if (i % 11 == 0) || (i < 11 || i > 429 || 309...318 ~= i || 210...219 ~= i) {
            return false
        }
        return true
    }
    
    func saveAction(player: String, dealer: Int, strat: String, index: Int, cell: PlayerStratCollectionViewCell) {
        Settings.instance.player.putBaseStrat(player: player, dealer: dealer, strat: strat)
        cell.cellLabelView.text = getCellText(index)
        let bg:UIColor = getBackground(index, cell.cellLabelView.text!)
        cell.cellBackgroundView.backgroundColor = bg
        DispatchQueue.main.async(execute: playerGrid.reloadData)
    }
    
    func openAlert(_ i: Int, _ cell: PlayerStratCollectionViewCell) {
        let dealer: Int = getDealer(i), player: String = getPlayer(i)
        let dealer_string = (dealer == 11) ? "A" : String(dealer)
        let alert = UIAlertController(title: "\(player) vs \(dealer_string)", message: "", preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Hit", style: .destructive, handler: {
            action in self.saveAction(player: player, dealer: dealer, strat: "H", index: i, cell: cell)
        }))
        alert.addAction(UIAlertAction(title: "Stand", style: .destructive, handler: {
            action in self.saveAction(player: player, dealer: dealer, strat: "X", index: i, cell: cell)
        }))
        alert.addAction(UIAlertAction(title: "Double", style: .destructive, handler: {
            action in self.saveAction(player: player, dealer: dealer, strat: "D", index: i, cell: cell)
        }))
        alert.addAction(UIAlertAction(title: "Double / Stand", style: .destructive, handler: {
            action in self.saveAction(player: player, dealer: dealer, strat: "E", index: i, cell: cell)
        }))
        if (i > 319) {
            alert.addAction(UIAlertAction(title: "Split", style: .destructive, handler: {
                action in self.saveAction(player: player, dealer: dealer, strat: "S", index: i, cell: cell)
            }))
        }
        alert.addAction(UIAlertAction(title: "Surrender", style: .destructive, handler: {
            action in self.saveAction(player: player, dealer: dealer, strat: "A", index: i, cell: cell)
        }))
        alert.addAction(UIAlertAction(title: "Surrender / Stand", style: .destructive, handler: {
            action in self.saveAction(player: player, dealer: dealer, strat: "B", index: i, cell: cell)
        }))
        alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
