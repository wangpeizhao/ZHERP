//
//  UIImage-Extensions.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/20.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

extension UIImage {
    
    //将图片缩放成指定尺寸（多余部分自动删除）
    func scaled(to newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
//    使用样例
    //原始图片
//    let image = UIImage(named: "image.jpg")!
//    //将图片转成 400 * 300 尺寸
//    let image2 = image.scaled(to: CGSize(width: 400, height: 300))
    
    //将图片裁剪成指定比例（多余部分自动删除）
    func crop(ratio: CGFloat) -> UIImage {
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
        
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height
        rect.origin.x    = (newSize.width - size.width ) / 2.0
        rect.origin.y    = (newSize.height - size.height ) / 2.0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
//    使用样例
//    //原始图片
//    let image = UIImage(named: "image.jpg")!
//    
//    //将图片转成 4:3 比例
//    let image2 = image.crop(ratio: 4/3)
//    
//    //将图片转成 1:1 比例（正方形）
//    let image3 = image.crop(ratio: 1)
    
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    /**
     *  等比率缩放
     */
//    func scaleImage(scaleSize:CGFloat)->UIImage {
//        let reSize = CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize)
//        return reSizeImage(reSize)
//    }
    
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
