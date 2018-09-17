//
//  SMemberModel.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/5.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import Foundation

class SMemberModel: NSObject {
    var id: Int
    var avatar: String
    var username: String
    var rId: Int
    var realname: String
    var rolename: String
    var remark: String
    var status: Bool
    var lastLoginIp: String
    var lastLoginTime: Date
    var loginTimes: Int
    
    init(id: Int, avatar:String, username: String, rId: Int,realname: String, rolename: String, remark:String, status: Bool, lastLoginIp: String, lastLoginTime: Date, loginTimes: Int) {
        self.id = id
        self.avatar = avatar
        self.username = username
        self.rId = rId
        self.realname = realname
        self.rolename = rolename
        self.remark = remark
        self.status = status
        self.lastLoginIp = lastLoginIp
        self.lastLoginTime = lastLoginTime
        self.loginTimes = loginTimes
    }
}
