//
//  BillsDailyReportTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/6.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class BillsDailyReportTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
