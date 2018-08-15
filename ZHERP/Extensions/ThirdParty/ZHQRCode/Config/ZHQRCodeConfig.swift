//
//  ZHQRCodeConfig.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit


// 扫描器类型
// - qr: 仅支持二维码
// - bar: 仅支持条形码
// - both: 支持二维码、条形码
enum ZHScannerType {
    case qr
    case bar
    case both
}

class ZHQRCodeConfig: NSObject {
    // 扫描器类型 默认支持二维码以及条形码
    var scannerType: ZHScannerType = .both
    
    // 棱角颜色 默认RGB色值 r:63 g:187 b:54 a:1.0
    var scannerCornerColor: UIColor = UIColor(red: 63/255.0, green: 187/255.0, blue: 54/255.0, alpha: 1.0)
    
    // 边框颜色 默认白色
    var scannerBorderColor: UIColor = .white
    
    // 指示器风格
    var indicatorViewStyle: UIActivityIndicatorViewStyle = .whiteLarge
}
