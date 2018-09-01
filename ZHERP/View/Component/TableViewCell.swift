//
//  TableViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class MemberBaseCell: UITableViewCell {
    static let identifier: String = "MemberBaseCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.font = Specs.font.small
        detailTextLabel?.textColor = Specs.color.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("MemberBaseCell:init(coder:) has not been implemented")
    }
}

class PersonalBaseCell: UITableViewCell {
    static let identifier: String = "PersonalBaseCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.font = Specs.font.small
        detailTextLabel?.textColor = Specs.color.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("PersonalBaseCell:init(coder:) has not been implemented")
    }
}

class SimpleBasicsCell: UITableViewCell {
    static let identifier: String = "SimpleBasicsCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.font = Specs.font.small
        detailTextLabel?.textColor = Specs.color.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("SimpleBasicsCell:init(coder:) has not been implemented")
    }
}
