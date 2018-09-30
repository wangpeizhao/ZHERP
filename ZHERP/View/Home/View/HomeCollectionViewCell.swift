//
//  HomeCollectionViewCell.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/20.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    var imageName: String? = nil
    var imageTitle: String? = nil
    var imageLabel: UILabel?
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        // 间隔
        let spacing:CGFloat = 2
        // 列数
        let columnsNum = 3
        //
        let imageFrameWidth: CGFloat = 70.0
        let imageFrameHeight: CGFloat = imageFrameWidth
        
        let itemWidth = (ScreenWidth - spacing * CGFloat(columnsNum - 1)) / CGFloat(columnsNum)
        let x = (itemWidth - imageFrameWidth) / 2
        imageView = UIImageView(frame:CGRect(x: x, y: 40, width: imageFrameWidth, height: imageFrameHeight))
        imageView?.contentMode = .scaleAspectFill
        
        imageView?.layer.masksToBounds = true
        imageView?.layer.cornerRadius = (imageView?.frame.width)!/2
        
        imageView?.clipsToBounds = true
        self.addSubview(imageView!)
        
        // 图片上面显示课程名称，居中显示
        imageLabel = UILabel(frame:CGRect(x: 0, y: 120, width: itemWidth, height: 20))
        imageLabel!.textColor = UIColor.black
        imageLabel!.font = UIFont.systemFont(ofSize: 14)
        imageLabel!.textAlignment = .center
        imageLabel!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.addSubview(imageLabel!)
        self.backgroundColor = UIColor.clear;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
