//
//  ExecutionSettingsTableViewCell.swift
//  BlackjackSimulator
//
//  Created by Admin on 07/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class ExecutionSettingsTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var OptionLabel: UILabel!
    @IBOutlet weak var ValueLabel: UILabel!
    @IBOutlet weak var PickerLabel: UIPickerView!
    
    private let cards: [String] = VarText.Exec.cards

    override func awakeFromNib() {
        super.awakeFromNib()
        PickerLabel.delegate = self
        PickerLabel.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cards[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cardNum:String = cards[row]
        self.ValueLabel.text = cardNum
        
        switch self.OptionLabel.text! {
        case "Dealer card":
            Settings.instance.execution.dealer = (row + 1)
        case "Player card 1":
            Settings.instance.execution.player1 = (row + 1)
        case "Player card 2":
            Settings.instance.execution.player2 = (row + 1)
        default:
            return
        }
    }

}
