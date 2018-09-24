//
//  GoodOperateImageViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/24.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class GoodOperateImageViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var deleteBtn: UIButton?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 间隔
        let spacing:CGFloat = 2
        // 列数
        let columnsNum = 4
        //
        let imageFrameWidth: CGFloat = 64.0
        let imageFrameHeight: CGFloat = imageFrameWidth
        //
        let ScreenWidth = UIScreen.main.bounds.size.width
        
        let itemWidth = (ScreenWidth - spacing * CGFloat(columnsNum - 1)) / CGFloat(columnsNum)
        let x = (itemWidth - imageFrameWidth) / 2
        self.imageView = UIImageView(frame:CGRect(x: x, y: 10, width: imageFrameWidth, height: imageFrameHeight))
        self.imageView?.contentMode = .scaleAspectFill
        
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 2.0
        
        self.imageView?.clipsToBounds = true
        self.addSubview(self.imageView!)
        
        // 图片右上角的删除按钮
        self.deleteBtn = UIButton()
        self.deleteBtn?.sizeToFit()
        self.deleteBtn?.isHidden = false
        self.deleteBtn?.setImage(UIImage(named: "iconfont-shanchu"), for: .normal)
        self.addSubview(self.deleteBtn!)
        let _size = self.deleteBtn!.frame.size
        self.deleteBtn?.snp.makeConstraints {(make) -> Void in
            make.top.equalTo((self.imageView?.snp.top)!).offset(-_size.height/2 + 8)
            make.right.equalTo((self.imageView?.snp.right)!).offset(_size.width/2 - 5)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        self.backgroundColor = UIColor.clear;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
