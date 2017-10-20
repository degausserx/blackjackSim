//
//  ExecutionSettingsLoopsTableViewCell.swift
//  BlackjackSimulator
//
//  Created by Admin on 07/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class ExecutionSettingsLoopsTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let loops: [Int] = VarText.Exec.loops

    override func awakeFromNib() {
        super.awakeFromNib()
        PickerLabel.delegate = self
        PickerLabel.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var OptionLabel: UILabel!
    @IBOutlet weak var ValueLabel: UILabel!
    @IBOutlet weak var PickerLabel: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(loops[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let loopNum:Int = loops[row]
        self.ValueLabel.text = String(loopNum)
        Settings.instance.execution.loops = loopNum
    }
}
