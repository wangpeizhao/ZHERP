//
//  SFeedbackViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/20.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import WebKit

class SFeedbackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "帮助与反馈")
        
        self._setUp()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func _setUp() {
        // Do any additional setup after loading the view, typically from a nib.
        var strHtml = "<html><body> Hello <span style=\"color:#0f0;font-size:30px;\">It is me.</span>"
        strHtml += "<br/> <font size=\"13\" color=\"red\">Here you are, Here we are!</font>;</body></html>";
        
        let label:UILabel = UILabel()
        label.text = strHtml
        label.numberOfLines = 0 //Line break when the current line is full display.
        label.lineBreakMode = NSLineBreakMode.byClipping;//Tips:Supported six types.

//        do{
//            let srtData = strHtml.data(using: String.Encoding.unicode, allowLossyConversion: true)!
//            let strOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]//Tips:Supported four types.
//            let attrStr = try NSAttributedString(data: srtData, options: strOptions, documentAttributes: nil)
//            label.attributedText = attrStr
//        }catch let error as NSError {
//            print(error.localizedDescription)
//        }
        let attrStr = try! NSMutableAttributedString(
            data: (strHtml.data(using: .unicode, allowLossyConversion: true)!),
            options:[.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        //行高
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 8
        attrStr.addAttributes([NSAttributedStringKey.paragraphStyle:paraph], range: NSMakeRange(0, attrStr.length))
        
        label.attributedText = attrStr

        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 300)
        self.view.addSubview(label)
        
        
        let webview = UIWebView(frame: CGRect(x: 0, y: 300, width: ScreenWidth, height: 300))
        let html = "<h1>欢迎光临：<a href='http://qq.com'>qq.com</a></h1>"
        webview.loadHTMLString(html, baseURL: nil)
        self.view.addSubview(webview)

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
