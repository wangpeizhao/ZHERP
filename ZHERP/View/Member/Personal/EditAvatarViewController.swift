//
//  EditAvatarViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/27.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class EditAvatarViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var personalValue: String? = nil
    var personalTitle: String? = nil
    var personalKey: String? = nil
    
    let imageView = UIImageView()
    let allowsEditing: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.black
        
        setNavBarTitle(view: self, title: personalTitle!, transparent: false, ofSize: 18)
//        setNavBarRightBtn(view: self, title: "···", selector: #selector(selectorAvatar))
        // 设置右侧按钮
        let rightBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(selectorAvatar))
        rightBarBtn.image = UIImage(named: "more")
        rightBarBtn.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtn]
        
        imageAdaptive(imageView: imageView, imageName: personalValue!)
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.width.height.equalTo(ScreenWidth)
            make.center.equalTo(self.view)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func selectorAvatar() {
        let alertController = UIAlertController(title: "更改头像", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "拍照", style: .destructive, handler: photoEvent)
        let archiveAction = UIAlertAction(title: "从手机相册选择", style: .default, handler: cameraEvent)
        let saveAction = UIAlertAction(title: "保存图片", style: .default, handler: saveBtn)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveBtn(alert: UIAlertAction) {
        let frame = self.view.frame
        UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height - 100))
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(signature, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        var showMessage = ""
        if error != nil{
            showMessage = "保存失败"
        }else{
            showMessage = "保存成功"
        }
        _tip(view: self, title: showMessage)
    }
    
    func cameraEvent(alert: UIAlertAction){
        print("cameraEvent")
//        let pickerCamera = UIImagePickerController()
//        pickerCamera.delegate = self
//        self.present(pickerCamera, animated: true, completion: nil)
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            picker.allowsEditing = self.allowsEditing
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    func photoEvent(alert: UIAlertAction){
        print("photoEvent")
        let pickerPhoto = UIImagePickerController()
        pickerPhoto.allowsEditing = self.allowsEditing
        pickerPhoto.sourceType = .camera
        pickerPhoto.delegate = self
        self.present(pickerPhoto, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController...")
        var image: UIImage! // = info[UIImagePickerControllerOriginalImage] as! UIImage
        if self.allowsEditing {
            //获取编辑后的图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //获取选择的原图
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        self.imageView.image = image
//        let imageUrl: NSURL = info[UIImagePickerControllerImageURL] as! NSURL
//        print(imageUrl)
        
        //二维码读取
        let ciImage:CIImage=CIImage(image:image)!
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context,
                                  options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        if let features = detector?.features(in: ciImage) {
            print("扫描到二维码个数：\(features.count)")
            //遍历所有的二维码，并框出
            for feature in features as! [CIQRCodeFeature] {
                print(feature.messageString ?? "")
            }
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel...")
        picker.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
