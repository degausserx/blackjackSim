//
//  HouseSettingsSwitchesTableViewCell.swift
//  BlackjackSimulator
//
//  Created by Admin on 08/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class HouseSettingsSwitchesTableViewCell: UITableViewCell {
    
    var cell: Int!
    
    @IBOutlet weak var TheSwitch: UISwitch!
    @IBOutlet weak var OptionLabel: UILabel!
    
    @IBAction func TheSwitchFunc(_ sender: UISwitch) {
        self.updateValue()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }

}

extension HouseSettingsSwitchesTableViewCell {
    
    func updateValue() {
        switch cell {
            case 0:
            Settings.instance.house.holecard = self.TheSwitch.isOn
            case 1:
            Settings.instance.house.draw17 = self.TheSwitch.isOn
            case 2:
            Settings.instance.house.doubleonsoft = self.TheSwitch.isOn
            case 3:
            Settings.instance.house.splitacesone = self.TheSwitch.isOn
            case 4:
            Settings.instance.house.splitacesnobjs = self.TheSwitch.isOn
            case 5:
            Settings.instance.house.resplitaces = self.TheSwitch.isOn
            case 6:
            Settings.instance.house.surrender = self.TheSwitch.isOn
            case 7:
            Settings.instance.house.surrendervsace = self.TheSwitch.isOn
            case 8:
            Settings.instance.house.surrenderearly = self.TheSwitch.isOn
            default:
            return
        }
    }
    
}
