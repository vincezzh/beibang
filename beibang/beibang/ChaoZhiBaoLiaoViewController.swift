//
//  ChaoZhiBaoLiaoViewController.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-12.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ChaoZhiBaoLiaoViewController: UIViewController, UITextViewDelegate {

    let placeholder = "请通过购物App中使用系统分享或浏览器打开商品页面获取商品链接"
    
    @IBOutlet weak var urlLinkTextView: UITextView!
    @IBOutlet weak var checkItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        initializeAction()
    }
    
    func initializeDecoration() {
        title = "超值爆料"
        
        checkItemButton.layer.cornerRadius = 5
    }
    
    func initializeAction() {
        urlLinkTextView.delegate = self
        urlLinkTextView.text = placeholder
        urlLinkTextView.textColor = UIColor.lightGrayColor()
        urlLinkTextView.selectedTextRange = urlLinkTextView.textRangeFromPosition(urlLinkTextView.beginningOfDocument, toPosition: urlLinkTextView.beginningOfDocument)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        if updatedText.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGrayColor()
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            return false
        }else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }
    }
    
    @IBAction func clickCheckItemButton(sender: AnyObject) {
        if urlLinkTextView.text.hasPrefix("http://") || urlLinkTextView.text.hasPrefix("https://") {
            performSegueWithIdentifier("chaoZhiBaoLiaoPreviewSegue", sender: nil)
        }else {
            let alertView = UNAlertView(title: "提示", message: "输入的商品链接貌似不太对")
            alertView.messageAlignment = NSTextAlignment.Center
            alertView.buttonAlignment  = UNButtonAlignment.Horizontal
            alertView.addButton("关闭",
                backgroundColor: UIColor(red: 219 / 255.0, green: 82 / 255.0, blue: 75 / 255.0, alpha: 1.0),
                fontColor: UIColor.whiteColor(),
                action: {}
            )
            alertView.show()
        }
    }

}
