//
//  House2ViewController.swift
//  BlackjackSimulator
//
//  Created by Admin on 08/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var HouseTable: UITableView!
    
    var CellExpandedDecks: Bool = false
    var CellExpandedMaxSplits: Bool = false
    
    var numberCell: String = "HouseNumberTableCell"
    var switchCell: String = "HouseSwitchTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.HouseTable.delegate = self
        self.HouseTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.HouseTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        if (Settings.instance.reloadHouse) {
            Settings.instance.reloadHouse = false
            super.didReceiveMemoryWarning()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return VarText.House.headers[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 2 : 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: numberCell, for: indexPath) as! HouseSettingsNumbersTableViewCell
            cell.cell = indexPath.row
            cell.OptionLabel.text = VarText.House.options[indexPath.row]
            let wheel:(Int, String) = getWheelSetting(indexPath.row)
            cell.ValueLabel.text = wheel.1
            cell.ValuePicker.selectRow(wheel.0, inComponent: 0, animated: false)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: switchCell, for: indexPath) as! HouseSettingsSwitchesTableViewCell
        cell.OptionLabel.text = VarText.House.options[(indexPath.row + 2)]
        cell.TheSwitch.setOn(getSwitchSetting(indexPath.row), animated: false)
        cell.cell = indexPath.row
        return cell
    }
    
}

extension HouseViewController {
    
    func getSwitchSetting(_ i: Int) -> Bool {
        switch i {
        case 0:
            return Settings.instance.house.holecard
        case 1:
            return Settings.instance.house.draw17
        case 2:
            return Settings.instance.house.doubleonsoft
        case 3:
            return Settings.instance.house.splitacesone
        case 4:
            return Settings.instance.house.splitacesnobjs
        case 5:
            return Settings.instance.house.resplitaces
        case 6:
            return Settings.instance.house.surrender
        case 7:
            return Settings.instance.house.surrendervsace
        case 8:
            return Settings.instance.house.surrenderearly
        default:
            return false
        }
    }
    
    func getWheelSetting(_ i: Int) -> (Int, String) {
        
        // decks
        if (i == 0) {
            let decks = Settings.instance.house.decks
            let rowNum: Int = (decks < 5) ? (decks - 1) : (decks == 6) ? 4 : 5
            let value: String = VarText.House.decks[rowNum]
            return (rowNum, value)
        }
        
        // maxsplits
        let maxSplits = Settings.instance.house.maxsplits
        let rowNum: Int = (maxSplits > 0) ? (maxSplits - 1) : 3
        let value: String = VarText.House.splits[rowNum]
        return (rowNum, value)
    }
}

// cell sizes
extension HouseViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                CellExpandedDecks = !CellExpandedDecks
            case 1:
                CellExpandedMaxSplits = !CellExpandedMaxSplits
            default:
                break
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                return CellExpandedDecks ? 170 : 50
            case 1:
                return CellExpandedMaxSplits ? 170 : 50
            default:
                return 50
            }
        }
        return 50
    }
    
}
