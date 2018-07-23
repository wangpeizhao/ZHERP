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
    
    static func populate(withUser user: Member) -> [[String: Any]] {
        return [
            [
                self.Rows: [
                    [self.ImageName: user.avatarName, self.Title: user.name, self.SubTitle: "View your profile"]
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
                    [self.ImageName: Specs.imageName.helpSupport, self.Title: "Help and Support"]
                ]
            ],
//            [
//                self.Rows: [
//                    [self.Title: self.back, self.key: "Back"]
//                ]
//            ],
            [
                self.Rows: [
                    [self.Title: self.logout, self.key: "Logout"]
                ]
            ]
        ]
    }
}

