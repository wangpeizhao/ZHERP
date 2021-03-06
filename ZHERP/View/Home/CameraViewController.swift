//
//  CameraViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/14.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate,  UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    var scanRectView:UIView!
    var device:AVCaptureDevice!
    var input:AVCaptureDeviceInput!
    var output:AVCaptureMetadataOutput!
    var session:AVCaptureSession!
    var preview:AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        setNavBarTitle(view: self, title: "二维码/条码")
        setNavBarRightBtn(view: self, title: "相册", selector: #selector(getCamera))
        
        
//        https://www.jianshu.com/p/2dcb6dc75cd8
        
        fromCamera(QRCode: false)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func getCamera() {
        cameraEvent()
    }
    
    func cameraEvent(){
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
//            picker.allowsEditing = true
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController...")
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        self.imageView.image = image
        //        let imageUrl: NSURL = info[UIImagePickerControllerImageURL] as! NSURL
        //        print(imageUrl)
        
        //二维码读取
        let ciImage:CIImage=CIImage(image:image)!
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        if let features = detector?.features(in: ciImage) {
            print("扫描到二维码个数：\(features.count)")
            //遍历所有的二维码，并框出
            for feature in features as! [CIQRCodeFeature] {
                print(feature.messageString ?? "")
//                _alert(view: self, message: feature.messageString!)
                
                
                let alertController = UIAlertController(title: "二维码", message: feature.messageString!,preferredStyle: .alert)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    //继续扫描
//                    self.session.startRunning()
                })
                alertController.addAction(okAction)
                let cc = CameraViewController()
                cc.present(alertController, animated: true, completion: nil)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func fromCamera(QRCode: Bool) {
        do{
            self.device = AVCaptureDevice.default(for: AVMediaType.video)
            
            self.input = try AVCaptureDeviceInput(device: device)
            
            self.output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            self.session = AVCaptureSession()
            if UIScreen.main.bounds.size.height < 500 {
                self.session.sessionPreset = AVCaptureSession.Preset.vga640x480
            }else{
                self.session.sessionPreset = AVCaptureSession.Preset.high
            }
            
            self.session.addInput(self.input)
            self.session.addOutput(self.output)
            
//    https://stackoverflow.com/questions/46011211/barcode-on-swift-4/46027337#46027337
//            if (self.session.canAddOutput(self.output)) {
////                self.session.addOutput(self.output)
////
////                self.output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
////                self.output.metadataObjectTypes = [AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.pdf417]
//            } else {
//                let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "OK", style: .default))
//                present(ac, animated: true)
//                self.session = nil
//                return
//            }
            
            
            if (QRCode) {
                self.output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            } else {
                self.output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//                self.output.metadataObjectTypes = [.ean8, .ean13, .pdf417, .upce, .qr]
                self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes
            }
            
            //计算中间可探测区域
            let windowSize = UIScreen.main.bounds.size
            let scanSize = CGSize(width:windowSize.width*3/4, height:windowSize.width*3/4)
            var scanRect = CGRect(x:(windowSize.width-scanSize.width)/2,
                                  y:(windowSize.height-scanSize.height)/2,
                                  width:scanSize.width, height:scanSize.height)
            //计算rectOfInterest 注意x,y交换位置
            scanRect = CGRect(x:scanRect.origin.y/windowSize.height,
                              y:scanRect.origin.x/windowSize.width,
                              width:scanRect.size.height/windowSize.height,
                              height:scanRect.size.width/windowSize.width);
            //设置可探测区域
            self.output.rectOfInterest = scanRect
            
            self.preview = AVCaptureVideoPreviewLayer(session:self.session)
            self.preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.preview.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(self.preview, at:0)
            
            //添加中间的探测区域绿框
            self.scanRectView = UIView();
            self.view.addSubview(self.scanRectView)
            self.scanRectView.frame = CGRect(x:0, y:0, width:scanSize.width, height:scanSize.height);
            self.scanRectView.center = CGPoint( x:UIScreen.main.bounds.midX, y:UIScreen.main.bounds.midY)
            self.scanRectView.layer.borderColor = UIColor.green.cgColor
//            self.scanRectView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5) as! CGColor
            self.scanRectView.layer.borderWidth = 1;
            
            //开始捕获
            self.session.startRunning()
            
            // 二维码
            if (!QRCode) {
                //放大
                do {
                    try self.device!.lockForConfiguration()
                } catch _ {
                    NSLog("Error: lockForConfiguration.");
                }
                self.device!.videoZoomFactor = 1.5
                self.device!.unlockForConfiguration()
            }
        }catch _ {
            //打印错误消息
            let alertController = UIAlertController(title: "提醒", message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //摄像头捕获
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil{
                self.session.stopRunning()
            }
        }
        self.session.stopRunning()
        //输出结果
        let alertController = UIAlertController(title: "二维码", message: stringValue,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { action in
            //继续扫描
            self.session.startRunning()
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
