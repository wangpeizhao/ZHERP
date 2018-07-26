//
//  MemberMenus.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation

public struct MemberMenus {
    static let Section = "section"
    static let Rows = "rows"
    static let ImageName = "imageName"
    static let Title = "title"
    static let SubTitle = "subTitle"
    static let seeMore = "See More..."
    static let addFavorites = "Add Favorites..."
    static let key = "keyCode"
    static let logout = "退出当前登录"
    static let back = "返回"
    
    static let Value = "value"
    
    static func populate(withUser user: Member) -> [[String: Any]] {
        return [
            [
                self.Rows: [
                    [self.ImageName: user.avatarName, self.Title: user.name, self.SubTitle: "View your profile", self.key: "Personal"]
                ]
            ],
            [
                self.Rows: [
                    [self.ImageName: Specs.imageName.friends, self.Title: "Friends"],
                    [self.ImageName: Specs.imageName.events, self.Title: "Events"],
                    [self.ImageName: Specs.imageName.groups, self.Title: "Groups"],
                    [self.ImageName: Specs.imageName.education, self.Title: user.education],
                    [self.ImageName: Specs.imageName.townHall, self.Title: "Town Hall"],
                    [self.ImageName: Specs.imageName.instantGames, self.Title: "Instant Games"],
                    [self.Title: self.seeMore]
                ]
            ],
            [
                self.Section: "FAVORITES",
                self.Rows: [
                    [self.Title: self.addFavorites]
                ]
            ],
            [
                self.Rows: [
                    [self.ImageName: Specs.imageName.settings, self.Title: "Settings", self.key: "Setting"],
                    [self.ImageName: Specs.imageName.privacyShortcuts, self.Title: "Privacy Shortcuts"],
                    [self.ImageName: Specs.imageName.helpSupport, self.Title: "Help and Support", self.key: "System"]
                ]
            ],
//            [
//                self.Rows: [
//                    [self.Title: self.back, self.key: "Back"]
//                ]
//            ],
//            [
//                self.Rows: [
//                    [self.Title: self.logout, self.key: "Logout"]
//                ]
//            ]
        ]
    }
    
    static func personalInfo(withUser user: Personal) -> [[String: Any]] {
        return [
            [
                self.Rows: [
                    [self.Title: "头像", self.Value: user.avatar, self.key: "avatar"]
                ]
            ],
            [
                self.Rows: [
                    [self.Title: "名字", self.Value: user.username, self.key: "username"],
                    [self.Title: "微信号", self.Value: user.wechatID, self.key: "wechatID"],
                    [self.Title: "我的二维码", self.Value: user.myQR, self.key: "myQR"],
                    [self.Title: "我的地址", self.Value: user.address, self.key: "address"],
                ]
            ],
            [
                self.Rows: [
                    [self.Title: "性别", self.Value: user.sex, self.key: "sex"],
                    [self.Title: "地区", self.Value: user.region, self.key: "region"],
                    [self.Title: "个性签名", self.Value: user.signature, self.key: "signature"],
                ]
            ],
            [
                self.Rows: [
                    [self.Title: "其它", self.Value: user.other, self.key: "other"]
                ]
            ]
        ]
    }
}

