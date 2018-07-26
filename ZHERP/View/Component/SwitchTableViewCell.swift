//
//  SwitchTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/26.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var SwitchView: UIView!
    @IBOutlet weak var SwitchLabel: UILabel!
    @IBOutlet weak var SwitchWidget: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
