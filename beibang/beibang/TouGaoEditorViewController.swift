//
//  TouGaoEditorViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-14.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class TouGaoEditorViewController: UIViewController, UITextViewDelegate {
    
    let placeholder1 = "足够有趣的标题能吸引更多的爸爸妈妈们！当然，一句充满创意的标题，必须包含详细的品牌，产品名以及型号。"
    let placeholder2 = "给宝宝买到了什么好东西？还是作为辣妈奶爸的你给自己拔了颗草？请把你的购物心情和好产品的心得体验分享到这里，通过图文并茂的方式把好产品晒出来吧！同时请对产品外观细节、做工、功能以及使用体验或是购买心得（如：转运规则、尺码信息等）给大家介绍介绍。高品质产品、高人气新品、新奇特好物不仅能得到更多额外奖励，还会让更多宝妈奶爸成为你的粉丝哦！Tips：内文请勿少于5张图片，精美的细节图能大大增加分享的可读性，也就大大增加了众测中奖的机会:)"
    let placeholder3 = "真实的购买链接能够帮助爸爸妈妈们无困难剁手，还有可能让你的分享变成精华帖置顶哦！方式1：使用浏览器可直接拷贝黏贴商品详情页地址，使用APP购买的可以在商品详情页面上点击—复制，然后回到这里粘贴即可；方式2：将订单详情页面截图（iOS：home+电源；Android：电源+音量上），点击左下方照相机图标上传；"

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: BlogEditor!
    @IBOutlet weak var contentLinkTextView: UITextView!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        initializeAction()
    }
    
    func initializeDecoration() {
        previewButton.layer.cornerRadius = 5
        submitButton.layer.cornerRadius = 5
    }
    
    func initializeAction() {
        title = "投稿"
        
        titleTextView.delegate = self
        titleTextView.text = placeholder1
        titleTextView.textColor = UIColor.lightGrayColor()
        titleTextView.selectedTextRange = titleTextView.textRangeFromPosition(titleTextView.beginningOfDocument, toPosition: titleTextView.beginningOfDocument)
        
        contentTextView.delegate = self
        contentTextView.text = placeholder2
        contentTextView.textColor = UIColor.lightGrayColor()
        contentTextView.selectedTextRange = contentTextView.textRangeFromPosition(contentTextView.beginningOfDocument, toPosition: contentTextView.beginningOfDocument)
        contentTextView.viewController = self
        contentTextView.fullMode = false
        
        contentLinkTextView.delegate = self
        contentLinkTextView.text = placeholder3
        contentLinkTextView.textColor = UIColor.lightGrayColor()
        contentLinkTextView.selectedTextRange = contentLinkTextView.textRangeFromPosition(contentLinkTextView.beginningOfDocument, toPosition: contentLinkTextView.beginningOfDocument)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        if updatedText.isEmpty {
            if textView.tag == 1 {
                textView.text = placeholder1
            }else if textView.tag == 2 {
                textView.text = placeholder2
            }else {
                textView.text = placeholder3
            }
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

    @IBAction func clickPreviewButton(sender: AnyObject) {
    }

    @IBAction func clickSubmitButton(sender: AnyObject) {
    }
    
    
    
    
    
}
