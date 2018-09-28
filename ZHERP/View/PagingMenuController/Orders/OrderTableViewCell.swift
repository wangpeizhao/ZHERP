//
//  OrderTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/7.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var orderView: UIView!
    
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var orderDiscounts: UILabel!
    @IBOutlet weak var orderAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
