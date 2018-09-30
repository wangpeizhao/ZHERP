//
//  Specs.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

public struct Specs {
    public struct Color {
        public let tint = UIColor(hex: 0x3b5998)
        public let red = UIColor.red
        public let white = UIColor.white
        public let black = UIColor.black
        public let gray = UIColor.lightGray
        public let blue = UIColor.blue
        public let main = UIColor(hex: 0x1368e5) //normalRGBA(r: 32, g: 148, b: 226, a: 1)
        public let circle = UIColor(hex: 0x1368e5)
        public let green = UIColor(hex: 0x42b83d)
        public let grayBg = UIColor(hex: 0xefeef4)
        public let graySBg = UIColor(hex: 0xf4f4f4)
        public let btnBg = UIColor(hex: 0x2869ed)
        public let GlobalTextColor = normalRGBA(r: 51, g: 51, b: 51, a: 1)
        public let ViewBackgroundColor = normalRGBA(r: 247, g: 247, b: 247, a: 1)
    }
    
    public struct FontSize {
        public let tiny: CGFloat = 10
        public let small: CGFloat = 12
        public let regular: CGFloat = 14
        public let large: CGFloat = 16
    }
    
    public struct Font {
        private static let regularName = "Helvetica Neue"
        private static let boldName = "Helvetica Neue Bold"
        public let tiny = UIFont(name: regularName, size: Specs.fontSize.tiny)
        public let small = UIFont(name: regularName, size: Specs.fontSize.small)
        public let regular = UIFont(name: regularName, size: Specs.fontSize.regular)
        public let large = UIFont(name: regularName, size: Specs.fontSize.large)
        public let smallBold = UIFont(name: boldName, size: Specs.fontSize.small)
        public let regularBold = UIFont(name: boldName, size: Specs.fontSize.regular)
        public let largeBold = UIFont(name: boldName, size: Specs.fontSize.large)
    }
    
    public struct ImageName {
        public let friends = "fb_friends"
        public let events = "fb_events"
        public let groups = "fb_groups"
        public let education = "fb_education"
        public let townHall = "fb_town_hall"
        public let instantGames = "fb_games"
        public let settings = "fb_settings"
        public let privacyShortcuts = "fb_privacy_shortcuts"
        public let helpSupport = "fb_help_and_support"
        public let placeholder = "fb_placeholder"
    }
    
    public struct Border {
        public let radius: CGFloat = 5
        public let width: CGFloat = 1
    }
    
    public static var color: Color {
        return Color()
    }
    
    public static var fontSize: FontSize {
        return FontSize()
    }
    
    public static var font: Font {
        return Font()
    }
    
    public static var imageName: ImageName {
        return ImageName()
    }
    
    public static var border: Border {
        return Border()
    }
}

