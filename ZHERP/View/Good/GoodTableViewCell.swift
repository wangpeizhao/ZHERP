//
//  GoodTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/22.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class GoodTableViewCell: UITableViewCell {
    
    var gId: Int!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var suk: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBAction func moreBtnClicked(_ sender: Any) {
//        print(self.gId)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
