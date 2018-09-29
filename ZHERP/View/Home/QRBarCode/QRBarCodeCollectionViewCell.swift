//
//  QRBarCodeCollectionViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/29.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class QRBarCodeCollectionViewCell: UICollectionViewCell {

    var imgView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        self.imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: (ScreenWidth - 20)/2, height: 100))
        self.addSubview(self.imgView!)
    }
}
