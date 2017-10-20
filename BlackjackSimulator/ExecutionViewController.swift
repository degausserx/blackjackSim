//
//  ExecutionViewController.swift
//  BlackjackSimulator
//
//  Created by etudiant on 03/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class ExecutionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ExecutionTable: UITableView!
    
    var cell1 = "ExecutionSettingsTableCell"
    var cell2 = "ExecutionSettingsLoopsTableCell"
    
    var CellExpandedPlayer1: Bool = false
    var CellExpandedPlayer2: Bool = false
    var CellExpandedDealer: Bool = false
    var CellExpandedLoops: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ExecutionTable.delegate = self
        self.ExecutionTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (Settings.instance.reloadExecution) {
            Settings.instance.reloadExecution = false
            self.ExecutionTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 3 : 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var selection: Int = 0
        
        if ((indexPath.section, indexPath.row) != (1,0)) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell1, for: indexPath) as! ExecutionSettingsTableViewCell
            let cards = VarText.Exec.cards
            
            switch indexPath.row {
            case 0:
                selection = Settings.instance.execution.player1 - 1
            case 1:
                selection = Settings.instance.execution.player2 - 1
            case 2:
                selection = Settings.instance.execution.dealer - 1
            default:
                break
            }
            
            cell.ValueLabel.text = cards[selection]
            cell.OptionLabel.text = VarText.Exec.items[((indexPath.section * 3) + indexPath.row)]
            cell.PickerLabel.selectRow(selection, inComponent: 0, animated: false)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell2, for: indexPath) as! ExecutionSettingsLoopsTableViewCell
            selection = VarText.Exec.loopsSelection[Settings.instance.execution.loops]!
            cell.ValueLabel.text = String(Settings.instance.execution.loops)
            cell.OptionLabel.text = VarText.Exec.items[((indexPath.section * 3) + indexPath.row)]
            cell.PickerLabel.selectRow(selection, inComponent: 0, animated: false)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return VarText.Exec.headers[section]
    }
}

// cell sizes
extension ExecutionViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            CellExpandedPlayer1 = !CellExpandedPlayer1
        case (0, 1):
            CellExpandedPlayer2 = !CellExpandedPlayer2
        case (0, 2):
            CellExpandedDealer = !CellExpandedDealer
        case (1, 0):
            CellExpandedLoops = !CellExpandedLoops
        default:
            break
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            return CellExpandedPlayer1 ? 170 : 50
        case (0,1):
            return CellExpandedPlayer2 ? 170 : 50
        case (0,2):
            return CellExpandedDealer ? 170 : 50
        case (1,0):
            return CellExpandedLoops ? 170 : 50
        default:
            return 50
        }
    }
    
}
