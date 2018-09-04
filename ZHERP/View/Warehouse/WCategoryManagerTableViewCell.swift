//
//  WCategoryManagerTableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/4.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class WCategoryManagerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryBtn: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.categoryLabel?.backgroundColor = UIColor.yellow
//        self.categoryLabel.frame.origin.x = CGFloat(20 * self.categoryLabel.tag)
//        print(CGFloat(20 * self.categoryLabel.tag))
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
