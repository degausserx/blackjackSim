//
//  ESimulationViewController.swift
//  BlackjackSimulator
//
//  Created by etudiant on 03/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var ButtonStart: UIButton!
    
    @IBOutlet weak var ButtonSave: UIButton!
    @IBOutlet weak var ButtonSaveAs: UIButton!
    @IBOutlet weak var ButtonManage: UIButton!
    
    @IBAction func FileAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.save()
        case 2:
            self.saveAs()
        default:
            return
        }
    }
    
    var simulation: Simulation?
    //var cellIndex: [ResultsTableViewCell] = []
    
    @IBAction func buttonStartFunc(_ sender: UIButton) {
        if (ButtonStart.currentTitle == "Start") {
            ButtonStart.setTitle("Stop", for: .normal)
            ButtonStart.backgroundColor = UIColor(hex: Colors.Red)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.start()
            }
            
        }
        else {
            ButtonStart.setTitle("Start", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ButtonStart.backgroundColor = UIColor(hex: Colors.Green)
        self.ButtonSave.backgroundColor = UIColor(hex: Colors.Green)
        self.ButtonSaveAs.backgroundColor = UIColor(hex: Colors.Orange)
        self.ButtonManage.backgroundColor = UIColor(hex: Colors.Blue)
        
        self.resultTable.delegate = self
        self.resultTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (Settings.instance.title != self.TitleLabel.text) {
            self.TitleLabel.text = Settings.instance.title
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VarText.Results.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimulationResultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        let key:String = VarText.Results.options[indexPath.row]
        cell.CellLabelLeft.text = "\(key):"
        if let sim = simulation {
            if sim.finished {
                cell.CellLabelValue.text = getResult(indexPath.row)
            }
            else {
                cell.CellLabelValue.text = "..."
            }
        }
        else {
            cell.CellLabelValue.text = "0"
        }
        //cellIndex.append(cell)
        return cell
    }
    
    func getResult(_ i: Int) -> String {
        switch i {
        case 0:
            return String(simulation!.games.withCommas())
        case 1:
            return String(simulation!.hands.withCommas())
        case 2:
            return String(simulation!.dealer_lose.withCommas())
        case 3:
            return String(simulation!.dealer_draw.withCommas())
        case 4:
            return String(simulation!.dealer_win.withCommas())
        case 5:
            return String((Double(simulation!.units_won) / 2.0).withCommas())
        case 6:
            return String((Double(simulation!.units_lost) / 2.0).withCommas())
        case 7:
            return "\(String(describing: String(simulation!.blackjack_percent.withCommas())))%"
        case 8:
            return "\(String(describing: String(simulation!.dealer_bust_rate.withCommas())))%"
        case 9:
            return "\(String(describing: String(simulation!.edge.withCommas())))%"
        default:
            return "0"
        }
    }
}

extension SimulationViewController {
    func saveAs() {
        let alert = UIAlertController(title: "Save as", message: "Enter the name of the settings file", preferredStyle: .alert)
        alert.addTextField { (textField) in
            if (Settings.instance.title != "Untitled") {
                textField.text = Settings.instance.title
            }
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields![0] {
                if Settings.instance.saveAs(value: textField.text!) {
                    self.TitleLabel.text = textField.text!
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func save() {
        if (self.TitleLabel.text != "Untitled") {
            if (Settings.instance.save()) {
                self.TitleLabel.text = Settings.instance.title
            }
        }
    }
}
