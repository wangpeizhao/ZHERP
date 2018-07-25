//
//  NotifyTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/25.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class NotifyTableViewCell: UITableViewCell {

    @IBOutlet weak var NotifyView: UIView!
    @IBOutlet weak var NotifyLabel: UILabel!
    @IBOutlet weak var NotifySwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
