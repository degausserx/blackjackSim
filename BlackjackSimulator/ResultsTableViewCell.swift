//
//  ResultsTableViewCell.swift
//  BlackjackSimulator
//
//  Created by etudiant on 03/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var CellLabelLeft: UILabel!
    @IBOutlet weak var CellLabelValue: UILabel!
    
}
