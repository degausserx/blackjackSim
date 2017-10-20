//
//  SimulateLoop.swift
//  BlackjackSimulator
//
//  Created by Admin on 08/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

extension SimulationViewController {

    func start() {
        simulation = Simulation()
        let loops: Int = Settings.instance.execution.loops
        let loopsDouble: Double = Double(loops)
        let loopsN = loops / 100
        DispatchQueue.main.async {
            self.ProgressBar.setProgress(0.0, animated: false)
        }

        var i: Int = 1
        while (i <= loops && ButtonStart.currentTitle != "Start") {
            simulation!.deal()
            if (i % loopsN == 0) {
                DispatchQueue.main.async {
                    self.updateProgressBar(Float(Double(i) / loopsDouble))
                }
            }
            i += 1
        }
        DispatchQueue.main.async {
            self.simulation!.finished = true
            self.stop()
        }
    }
    
    func stop() {
        self.resultTable.reloadData()
        
        ButtonStart.setTitle("Start", for: .normal)
        ButtonStart.backgroundColor = UIColor(hex: Colors.Green)
        ProgressBar.setProgress(1.0, animated: false)
    }
    
    func updateProgressBar(_ value: Float) {
        ProgressBar.setProgress(value, animated: false)
    }
    
}
