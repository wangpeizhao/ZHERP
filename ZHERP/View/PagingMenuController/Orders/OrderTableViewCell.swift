//
//  OrderTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/7.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var sukLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
