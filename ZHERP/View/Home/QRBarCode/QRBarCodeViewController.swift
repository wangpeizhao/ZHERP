//
//  QRBarCodeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/29.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class QRBarCodeViewController: UIViewController {
    
    var colltionView : UICollectionView?
    var dataArr: [UIImage] = []
    
    //存条形码名字数组
    var barCodeNameArray = [String]()
    //条形码大小
    let barCodeSize:CGSize = CGSize(width: 300, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setNavBarTitle(view: self, title: "打印条码")
        
//        let imgView = UIImageView(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
//        self.view.addSubview(imgView)
        
        self.barCodeNameArray = ["SN00000000001","SN00000000002","SN00000000003","SN00000000005","SN00000000006","SN00000000007","SN00000000008","SN00000000009","SN000000000010","SN00000000011","SN00000000012","SN00000000013","SN00000000014","SN00000000015","SN00000000015","SN00000000016","SN00000000017","SN00000000018","SN00000000019","SN00000000020"]
        for codeName in barCodeNameArray {
            //异步生成条形码，并保存到本地
            DispatchQueue.global(qos: .default).async {
                //生成条形码
                let image = self.generateBarCode128(barCodeStr: codeName as NSString,barCodeSize: self.barCodeSize)
                if image != nil {
//                    self.writeToLocal(image: image!,imgName: codeName)
                    self.dataArr.append(image!)
                }
                //处理耗时操作的代码块...
//                print("do work")

                //操作完成，调用主线程来刷新界面
                DispatchQueue.main.async {
//                    print("main refresh")
                    self.colltionView?.reloadData()
                }
            }
        }
//        imgView.image = self.generateBarCode(messgae: "123SN00000000002", width: 300, height: 100)
        self._setUp()
    }
    
    fileprivate func _setUp() {
        let layout = UICollectionViewFlowLayout()
        colltionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        //注册一个cell
        colltionView!.register(QRBarCodeCollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        colltionView?.backgroundColor = UIColor.white
        //设置每一个cell的宽高
        layout.itemSize = CGSize(width: (ScreenWidth-20)/2, height: 100)
        self.view.addSubview(colltionView!)
    }
    
    func generateBarCode(messgae: NSString, width: CGFloat, height: CGFloat) -> UIImage {
        var returnImage:UIImage?
        if (messgae.length > 0 && width > 0 && height > 0){
            let inputData:NSData? = messgae.data(using: String.Encoding.utf8.rawValue)! as NSData
            // CICode128BarcodeGenerator
            let filter = CIFilter.init(name: "CICode128BarcodeGenerator")!
            filter.setValue(inputData, forKey: "inputMessage")
            var ciImage = filter.outputImage!
            let scaleX = width/ciImage.extent.size.width
            let scaleY = height/ciImage.extent.size.height
            ciImage = ciImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
            returnImage = UIImage.init(ciImage: ciImage)
        }else {
            returnImage = nil;
        }
        return returnImage!
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //写入本地
    func writeToLocal(image:UIImage,imgName:String) {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray).object(at: 0)
        let filePath = URL(fileURLWithPath: "\(path)/\(imgName).jpeg")
        let imgData = UIImageJPEGRepresentation(image, 0)
        if imgData != nil {
            do {
                try imgData?.write(to: filePath as URL)
            } catch {
                print(error)
            }
            print("写入成功！！")
            print("filePath=\(filePath)")
        }
    }
    
    func generateBarCode128(barCodeStr: NSString, barCodeSize: CGSize) ->UIImage? {
        
        let stringData:NSData? = barCodeStr.data(using: String.Encoding.utf8.rawValue)! as NSData
        
        //系统自带能生成的码
        // CIAztecCodeGenerator 二维码
        // CICode128BarcodeGenerator 条形码
        // CIPDF417BarcodeGenerator
        // CIQRCodeGenerator     二维码
        let qrFilter = CIFilter.init(name: "CICode128BarcodeGenerator")
        qrFilter?.setDefaults()
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        let outputImage:CIImage? = qrFilter?.outputImage
        
        // 生成的条形码需要对其进行消除模糊处理，本文提供两种方法消除模糊，其原理都是放大条码，但项目中需要在条码底部加上条码内容文字，使用其方法一会模糊并变小文字，所以使用方法二，需要各位去研究下原因哈。。。
        
        
        // 消除模糊方法一
//        let context = CIContext()
//        let cgImage = context.createCGImage(outputImage!, fromRect: outputImage!.extent)

//        let image = UIImage(CGImage: cgImage, scale: 1.0, orientation: UIImageOrientation.Up)
//
//        // Resize without interpolating
//        let scaleRate:CGFloat = 20.0
//        let resized = resizeImage(addText(image), quality: CGInterpolationQuality.None, rate: scaleRate)
        
        // 消除模糊方法二
        
        let scaleX:CGFloat = barCodeSize.width/outputImage!.extent.size.width; // extent 返回图片的frame
        let scaleY:CGFloat = barCodeSize.height/outputImage!.extent.size.height;
        let resultImage = outputImage?.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
        let image = UIImage.init(ciImage: resultImage!) //UIImage.init(cgImage: resultImage as! CGImage)
        
        return addText(image: image,textName: barCodeStr as String);
    }
    
    //添加条形码下方文字
    func addText(image: UIImage, textName: String) ->UIImage{
        
        let size = CGSize(width: image.size.width, height: image.size.height + 30)
        UIGraphicsBeginImageContext(size)

        image.draw(in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))

        //绘制文字
        let barText:NSString = textName as NSString
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineBreakMode = .byWordWrapping
        textStyle.alignment = .center
        
        barText.draw(
            in: CGRect(x: 0, y: image.size.height-4, width: size.width, height: 30),
            withAttributes: [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0),
                NSAttributedStringKey.foregroundColor: UIColor.black,
                NSAttributedStringKey.paragraphStyle: textStyle
            ]
            // https://blog.csdn.net/qq_14920635/article/details/76318309
            // https://blog.csdn.net/hello_hwc/article/details/46731991
        )
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //    //图像缩放
    //    func resizeImage(image:UIImage,quality:CGInterpolationQuality,rate:CGFloat)->UIImage?
    //    {
    //        var resized:UIImage?;
    //        let width    = image.size.width * rate;
    //        let height   = image.size.height * rate;
    //
    //
    //
    //        UIGraphicsBeginImageContext(CGSizeMake(width, height));
    //        let context = UIGraphicsGetCurrentContext();
    //
    //        CGContextSetInterpolationQuality(context, quality);
    //        image.drawInRect(CGRectMake(0, 0, width, height))
    //
    //
    //        resized = UIGraphicsGetImageFromCurrentImageContext();
    //        UIGraphicsEndImageContext();
    //
    //        return resized;
    //    }
    
}

extension QRBarCodeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QRBarCodeCollectionViewCell

        cell.imgView?.image = self.dataArr[indexPath.row]
        return cell
    }
    
}
