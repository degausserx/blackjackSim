//
//  Rounded.swift
//  BlackjackSimulator
//
//  Created by etudiant on 09/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
