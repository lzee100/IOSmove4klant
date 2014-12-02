//
//  ScanForBeaconsCell.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 02-12-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class ScanForBeaconsCell: UITableViewCell {
    @IBOutlet var label_Major: UILabel!
    @IBOutlet var label_Minor: UILabel!
    @IBOutlet var label_Proximity: UILabel!
    @IBOutlet var label_RSSI: UILabel!
    @IBOutlet var label_OutPut_Major: UILabel!
    @IBOutlet var label_OutPut_Minor: UILabel!
    @IBOutlet var label_OutPut_Proximity: UILabel!
    @IBOutlet var label_OutPut_RSSI: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
