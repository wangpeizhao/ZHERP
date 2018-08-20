//
//  UIImage-Extensions.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/20.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 通过设置imageView圆角来实现
    // 这种方法实际上没有对原始图片进行处理。只不过在展示的时候，通过设置 UIImageView 圆角半径，从而显示成圆形图片。
    func toCircleCover() -> UIImageView{
        //获取图片
        let image = UIImage(named: "image1")
        //创建imageView
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x:40, y:40, width:100, height:100)
        imageView.contentMode = .scaleAspectFill
        //设置遮罩
        imageView.layer.masksToBounds = true
        //设置圆角半径(宽度的一半)，显示成圆形。
        imageView.layer.cornerRadius = imageView.frame.width/2
//        self.view.addSubview(imageView)
        return imageView
    }
    
    //通过图片裁剪来实现
    // 这种方式是通过遮罩剪切的方法，重新生成一张圆形的图片。
    func toCircleTailor() -> UIImage {
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
    
    //获取图片 - 使用样例
    //let image = UIImage(named: "image1")?.toCircle()
    ////创建imageView
    //let imageView = UIImageView(image: image)
    //imageView.frame = CGRect(x:40, y:40, width:100, height:100)
    //self.view.addSubview(imageView)
    
//    给UIImageView添加手势并能让手势响应。在这之前需要设置UIImageView  的一个属性，就是打开用户交互属性
//    let image:UIImage? = UIImage(named: "test.png")
//    let imageView: UIImageView = UIImageView()
//    imageView.image = image!
//    /////设置允许交互属性
//    imageView.userInteractionEnabled = true
//
//    /////添加tapGuestureRecognizer手势
//    let tapGR = UITapGestureRecognizer(target: self, action: "tapHandler:")
//    imageView.addGestureRecognizer(tapGR)
//
//    //////手势处理函数
//    func tapHandler(sender:UITapGestureRecognizer) {
//        ///////todo....
//    }
}
