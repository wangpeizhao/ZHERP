//
//  HPickingGoodTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/10/8.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class HPickingGoodTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var suk: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var priceInt: UILabel!
    @IBOutlet weak var priceDecimal: UILabel!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var selectBtn: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self._setUp()
    }
    
    fileprivate func _setUp() {
        self.priceInt?.snp.makeConstraints {(make) -> Void in
            make.bottom.equalTo((self.avatar?.snp.bottom)!)
        }

        self.quantity?.borderStyle = .line
        
        self.plus?.layer.borderWidth = 1.0
        self.plus?.layer.cornerRadius = 4.0
        
        self.minus?.layer.borderWidth = 1.0
        self.minus?.layer.cornerRadius = 4.0
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
