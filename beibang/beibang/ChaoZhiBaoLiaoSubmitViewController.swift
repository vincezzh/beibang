//
//  ChaoZhiBaoLiaoSubmitViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-12.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ChaoZhiBaoLiaoSubmitViewController: UIViewController, UITextViewDelegate {
    
    var bool: Bool = true
    let placeholderName = "商品标题"
    let placeholderReason = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！除了罗列品牌和参数，如果你有什么真实体验，也请一并分享出来。另外购买时一些需要注意的小细节，比如是否用券，或者参加满减活动等等，描述出来，让大家买的更快更爽！"
    var textViewY: CGFloat = 0.0
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var currentTextView: UITextView?

    @IBOutlet weak var itemTItleTextView: UITextView!
    @IBOutlet weak var contentImagesView: UIView!
    @IBOutlet weak var contentImagesScrollView: UIScrollView!
    @IBOutlet weak var fromStorePriceLabel: UILabel!
    @IBOutlet weak var fromStoreLabel: UILabel!
    @IBOutlet weak var buyReasonTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        initializeAction()
        
        addImagesInImageView(["http://www.akhaltech.com/img/profile.png",
            "http://www.akhaltech.com/img/profile.png",
            "http://www.akhaltech.com/img/profile.png",
            "http://www.akhaltech.com/img/profile.png",
            "http://www.akhaltech.com/img/profile.png"])
    }

    func initializeDecoration() {
        submitButton.layer.cornerRadius = 5
    }
    
    func initializeAction() {
        title = "超值爆料"
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        addDoneToolBarToKeyboard(buyReasonTextView)
        
        itemTItleTextView.delegate = self
        itemTItleTextView.tag = 1
        itemTItleTextView.text = placeholderName
        itemTItleTextView.textColor = UIColor.lightGrayColor()
        itemTItleTextView.selectedTextRange = itemTItleTextView.textRangeFromPosition(itemTItleTextView.beginningOfDocument, toPosition: itemTItleTextView.beginningOfDocument)
        
        buyReasonTextView.delegate = self
        buyReasonTextView.tag = 2
        buyReasonTextView.text = placeholderReason
        buyReasonTextView.textColor = UIColor.lightGrayColor()
        buyReasonTextView.selectedTextRange = buyReasonTextView.textRangeFromPosition(buyReasonTextView.beginningOfDocument, toPosition: buyReasonTextView.beginningOfDocument)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        if bool {
            keyboardWillChangeFrameWithNotification(notification, showsKeyboard: true)
            bool = !bool
        }
    }
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        if !bool {
            keyboardWillChangeFrameWithNotification(notification, showsKeyboard: false)
            bool = !bool
        }
    }
    
    func keyboardWillChangeFrameWithNotification(notification: NSNotification, showsKeyboard: Bool) {
        let userInfo = notification.userInfo!
        let animationDuration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        // Convert the keyboard frame from screen to view coordinates.
        let keyboardScreenBeginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let keyboardViewBeginFrame = view.convertRect(keyboardScreenBeginFrame, fromView: view.window)
        let keyboardViewEndFrame = view.convertRect(keyboardScreenEndFrame, fromView: view.window)
        let originDelta = abs((keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y))
        
        UIView.animateWithDuration(animationDuration, delay: 0, options: .BeginFromCurrentState, animations: {
            if showsKeyboard {
                if self.textViewY < originDelta {
                    self.contentScrollView.contentOffset.y += originDelta
                }
            }else {
                if self.textViewY < originDelta {
                    self.contentScrollView.contentOffset.y -= originDelta
                }
            }
            }, completion: nil)
    }
    
    func addDoneToolBarToKeyboard(textView: UITextView) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        doneToolbar.items = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "doneButtonClickedDismissKeyboard")]
        doneToolbar.sizeToFit()
        textView.inputAccessoryView = doneToolbar
    }
    
    func doneButtonClickedDismissKeyboard() {
        currentTextView?.resignFirstResponder()
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        currentTextView = textView
        textViewY = screenSize.height + contentScrollView.contentOffset.y - textView.frame.origin.y - textView.frame.size.height
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        if updatedText.isEmpty {
            if textView.tag == 1 {
                textView.text = placeholderName
            }else {
                textView.text = placeholderReason
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
    
    func addImagesInImageView(images: [String]) {
        for index in 0...images.count-1 {
            let imgURL: NSURL = NSURL(string: images[index])!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(
                request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        let imageView: UIImageView = UIImageView(image: UIImage(data: data!))
                        imageView.contentMode = UIViewContentMode.ScaleAspectFit
                        imageView.frame = CGRect(x: (index * 100), y: 0, width: 100, height: 100)
                        self.contentImagesView.addSubview(imageView)
                        self.contentImagesScrollView.contentSize = CGSizeMake(CGFloat(images.count * 100), 100)
                    }
            })
        }
    }

    @IBAction func clickSubmitButton(sender: AnyObject) {
    }
}
