//
//  Personal.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/24.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class Personal {
    var username: String
    var avatar: String
    var wechatID: String
    var myQR: String
    var address: String
    var sex: String
    var region: String
    var signature: String
    var other: String
    
    init(personal: Dictionary<String, String>) {
        self.username = personal["username"]!
        self.avatar = personal["avatar"]!
        self.wechatID = personal["wechatID"]!
        self.myQR = personal["myQR"]!
        self.address = personal["address"]!
        self.sex = personal["sex"]!
        self.region = personal["region"]!
        self.signature = personal["signature"]!
        self.other = personal["other"]!
    }
}
