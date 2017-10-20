//
//  HouseSettingsNumbersTableViewCell.swift
//  BlackjackSimulator
//
//  Created by Admin on 08/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class HouseSettingsNumbersTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cell: Int!
    let deckNum: [String] = VarText.House.decks
    let splitNum: [String] = VarText.House.splits
    
    @IBOutlet weak var OptionLabel: UILabel!
    @IBOutlet weak var ValueLabel: UILabel!
    @IBOutlet weak var ValuePicker: UIPickerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        ValuePicker.delegate = self
        ValuePicker.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (cell == 0) ? 6 : 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (cell == 0) ? VarText.House.decks[row] : VarText.House.splits[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (cell == 0) {
            let decks:String = deckNum[row]
            self.ValueLabel.text = decks
            Settings.instance.house.decks = VarText.House.deckDataActual[row]
        }
        else {
            let splits:String = splitNum[row]
            self.ValueLabel.text = splits
            Settings.instance.house.decks = (row < 3) ? row + 1 : 0
        }
    }

}
