//
//  BlogEditor.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-15.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class BlogEditor: UITextView, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, UITextViewDelegate {
    
    let defaultFontSize: CGFloat = 18.0
    var fontSize: CGFloat = 18.0
    var isFontColor: Bool = true
    var popoverVC: ColorPickerViewController = ColorPickerViewController()
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 550, 50))
    var viewController: UIViewController!
    var fullMode = true

    override func drawRect(rect: CGRect) {
        self.delegate = self
        self.dataDetectorTypes = UIDataDetectorTypes.All
        
        
        initializeToolbar()
    }
    
    func initializeToolbar() {
        doneToolbar.barStyle = UIBarStyle.Default
        if fullMode {
            doneToolbar.items = [
                UIBarButtonItem(image: UIImage(named: "hideKeyboard"), landscapeImagePhone: UIImage(named: "hideKeyboard"), style: UIBarButtonItemStyle.Done, target: self, action: "hideKeyboard"),
                UIBarButtonItem(image: UIImage(named: "reset"), landscapeImagePhone: UIImage(named: "reset"), style: UIBarButtonItemStyle.Done, target: self, action: "reset"),
                UIBarButtonItem(image: UIImage(named: "bold"), landscapeImagePhone: UIImage(named: "bold"), style: UIBarButtonItemStyle.Done, target: self, action: "goBold"),
                UIBarButtonItem(image: UIImage(named: "italic"), landscapeImagePhone: UIImage(named: "italic"), style: UIBarButtonItemStyle.Done, target: self, action: "goItalic"),
                UIBarButtonItem(image: UIImage(named: "underline"), landscapeImagePhone: UIImage(named: "underline"), style: UIBarButtonItemStyle.Done, target: self, action: "goUnderline"),
                UIBarButtonItem(image: UIImage(named: "increaseFont"), landscapeImagePhone: UIImage(named: "increaseFont"), style: UIBarButtonItemStyle.Done, target: self, action: "increaseFontSize"),
                UIBarButtonItem(image: UIImage(named: "decreaseFont"), landscapeImagePhone: UIImage(named: "decreaseFont"), style: UIBarButtonItemStyle.Done, target: self, action: "decreaseFontSize"),
                UIBarButtonItem(image: UIImage(named: "textColor"), landscapeImagePhone: UIImage(named: "textColor"), style: UIBarButtonItemStyle.Done, target: self, action: "changeColor"),
                UIBarButtonItem(image: UIImage(named: "backgroundColor"), landscapeImagePhone: UIImage(named: "backgroundColor"), style: UIBarButtonItemStyle.Done, target: self, action: "changeBackgroundColor"),
                UIBarButtonItem(image: UIImage(named: "insertImage"), landscapeImagePhone: UIImage(named: "insertImage"), style: UIBarButtonItemStyle.Done, target: self, action: "insertImage"),
                UIBarButtonItem(image: UIImage(named: "alignLeft"), landscapeImagePhone: UIImage(named: "alignLeft"), style: UIBarButtonItemStyle.Done, target: self, action: "alignLeft"),
                UIBarButtonItem(image: UIImage(named: "alignCenter"), landscapeImagePhone: UIImage(named: "alignCenter"), style: UIBarButtonItemStyle.Done, target: self, action: "alignCenter"),
                UIBarButtonItem(image: UIImage(named: "alignRight"), landscapeImagePhone: UIImage(named: "alignRight"), style: UIBarButtonItemStyle.Done, target: self, action: "alignRight")
            ]
        }else {
            doneToolbar.items = [
                UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
                UIBarButtonItem(image: UIImage(named: "hideKeyboard"), landscapeImagePhone: UIImage(named: "hideKeyboard"), style: UIBarButtonItemStyle.Done, target: self, action: "hideKeyboard")
            ]
            doneToolbar.sizeToFit()
        }
        
        let menuScrollView = UIScrollView()
        menuScrollView.frame = doneToolbar.frame
        menuScrollView.bounds = doneToolbar.bounds
        menuScrollView.autoresizingMask = doneToolbar.autoresizingMask
        menuScrollView.showsHorizontalScrollIndicator = false
        menuScrollView.showsVerticalScrollIndicator = false
        menuScrollView.bounces = false
        menuScrollView.contentSize = CGSizeMake(550, doneToolbar.bounds.height)
        menuScrollView.scrollEnabled = true
        menuScrollView.addSubview(doneToolbar)
        
        self.inputAccessoryView = menuScrollView
    }
    
    func textViewDidChange(textView: UITextView) {
        self.scrollRangeToVisible(self.selectedRange)
    }
    
    func hideKeyboard() {
        self.resignFirstResponder()
    }
    
    func reset() {
        self.fontSize = self.defaultFontSize
        self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize(defaultFontSize)
        self.typingAttributes[NSObliquenessAttributeName] = 0
        self.typingAttributes[NSUnderlineStyleAttributeName] = 0
        self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize(defaultFontSize)
        self.typingAttributes[NSForegroundColorAttributeName] = UIColor.blackColor()
        self.typingAttributes[NSBackgroundColorAttributeName] = UIColor.clearColor()
        Notice.showText("重置样式", fontsize: defaultFontSize, obliqueness: 0)
    }
    
    func goBold() {
        let range = self.selectedRange
        if range.length > 0 {
            let changedFontDescriptor = UIFont.systemFontOfSize((self.font?.pointSize)!)
            let typ = self.font
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            if typ == changedFontDescriptor {
                let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize((self.font?.pointSize)!)]
                string.addAttributes(attributes, range: self.selectedRange)
            }else {
                let attributes = [NSFontAttributeName: UIFont.systemFontOfSize((self.font?.pointSize)!)]
                string.addAttributes(attributes, range: self.selectedRange)
            }
            self.attributedText = string
            self.selectedRange = range
        }else {
            let changedFontDescriptor = UIFont.systemFontOfSize((CGFloat)(self.fontSize))
            let typ = self.typingAttributes[NSFontAttributeName] as? UIFont
            if ( typ == changedFontDescriptor) {
                self.typingAttributes[NSFontAttributeName] = UIFont.boldSystemFontOfSize((CGFloat)(self.fontSize))
                Notice.showText("粗体", fontsize: fontSize, obliqueness: 2)
            }else {
                self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize((CGFloat)(self.fontSize))
                Notice.showText("取消粗体", fontsize: fontSize, obliqueness: 2)
            }
        }
    }
    
    func goItalic() {
        let range = self.selectedRange
        if range.length > 0 {
            let typ = self.typingAttributes[NSObliquenessAttributeName] as? NSNumber
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            if typ == 0.5 {
                let attributes = [NSObliquenessAttributeName: 0.0]
                string.addAttributes(attributes, range: self.selectedRange)
            }else {
                let attributes = [NSObliquenessAttributeName: 0.5]
                string.addAttributes(attributes, range: self.selectedRange)
            }
            self.attributedText = string
            self.selectedRange = range
        }else {
            let typ = self.typingAttributes[NSObliquenessAttributeName] as? NSNumber
            if typ == 0.5 {
                self.typingAttributes[NSObliquenessAttributeName] = 0
                Notice.showText("取消斜体", fontsize: fontSize, obliqueness: 1)
            }else {
                self.typingAttributes[NSObliquenessAttributeName] = 0.5
                Notice.showText("斜体", fontsize: fontSize, obliqueness: 0)
            }
        }
    }
    
    func goUnderline() {
        let range = self.selectedRange
        if range.length > 0 {
            let typ = self.typingAttributes[NSUnderlineStyleAttributeName] as? NSNumber
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            if typ == 1 {
                let attributes = [NSUnderlineStyleAttributeName: 0]
                string.addAttributes(attributes, range: self.selectedRange)
            }else {
                let attributes = [NSUnderlineStyleAttributeName: 1]
                string.addAttributes(attributes, range: self.selectedRange)
            }
            self.attributedText = string
            self.selectedRange = range
        }else {
            let typ = self.typingAttributes[NSUnderlineStyleAttributeName] as? NSNumber
            if (typ == 1) {
                self.typingAttributes[NSUnderlineStyleAttributeName] = 0
                Notice.showText("取消下划线", fontsize: fontSize, obliqueness: 0)//弹出提示
            }else {
                self.typingAttributes[NSUnderlineStyleAttributeName] = 1
                Notice.showText("下划线", fontsize: fontSize, obliqueness: 0)//弹出提示
            }
        }
    }
    
    func increaseFontSize() {
        let range = self.selectedRange
        if range.length > 0 {
            if self.font?.pointSize < 36 {
                let string = NSMutableAttributedString(attributedString: self.attributedText)
                var selectedFontSize = self.font!.pointSize
                selectedFontSize += 2
                let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(selectedFontSize)]
                string.addAttributes(attributes, range: self.selectedRange)
                self.attributedText = string
                self.selectedRange = range
            }
        }else {
            if fontSize < 36 {
                self.fontSize = self.font!.pointSize
                fontSize += 2
                self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize((CGFloat)(self.fontSize))
            }
            Notice.showText("增大字体", fontsize: fontSize,obliqueness: 0)//弹出提示
        }
    }
    
    func decreaseFontSize() {
        let range = self.selectedRange
        if range.length > 0 {
            if self.font?.pointSize > 8 {
                let string = NSMutableAttributedString(attributedString: self.attributedText)
                var selectedFontSize = self.font!.pointSize
                selectedFontSize -= 2
                let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(selectedFontSize)]
                string.addAttributes(attributes, range: self.selectedRange)
                self.attributedText = string
                self.selectedRange = range
            }
        }else {
            if fontSize > 8 {
                self.fontSize = self.font!.pointSize
                self.fontSize -= 2
                self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize((CGFloat)(self.fontSize))
            }
            Notice.showText("减小字体", fontsize: fontSize,obliqueness: 0) //弹出提示
        }
    }
    
    func changeColor() {
        isFontColor = true
        self.popupColorView()
    }
    
    func changeBackgroundColor() {
        isFontColor = false
        self.popupColorView()
    }
    
    func popupColorView() {
        popoverVC = viewController.storyboard?.instantiateViewControllerWithIdentifier("colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .Popover
        popoverVC.preferredContentSize = CGSizeMake(284, 446)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = doneToolbar
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.Any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        viewController.presentViewController(popoverVC, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
    
    func setButtonColor (color: UIColor) {
        self.popoverVC.dismissViewControllerAnimated(true, completion: nil)
        
        if isFontColor {
            let range = self.selectedRange
            if range.length > 0 {
                let string = NSMutableAttributedString(attributedString: self.attributedText)
                let attributes = [NSForegroundColorAttributeName: color]
                string.addAttributes(attributes, range: self.selectedRange)
                self.attributedText = string
                self.selectedRange = range
            }else {
                self.typingAttributes[NSForegroundColorAttributeName] = color
            }
        }else {
            let range = self.selectedRange
            if range.length > 0 {
                let string = NSMutableAttributedString(attributedString: self.attributedText)
                let attributes = [NSBackgroundColorAttributeName: color]
                string.addAttributes(attributes, range: self.selectedRange)
                self.attributedText = string
                self.selectedRange = range
            }else {
                self.typingAttributes[NSBackgroundColorAttributeName] = color
            }
        }
    }
    
    func insertImage() {
        self.resignFirstResponder()
        var sheet:UIActionSheet
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil,otherButtonTitles: "从相册选择", "拍照")
        }else{
            sheet = UIActionSheet(title:nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择")
        }
        sheet.showInView(viewController.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        var sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if(buttonIndex != 0){
            if(buttonIndex==1){                                     //相册
                sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.resignFirstResponder()
            }else{
                sourceType = UIImagePickerControllerSourceType.Camera
            }
            let imagePickerController:UIImagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true              //true为拍照、选择完进入图片编辑模式
            imagePickerController.sourceType = sourceType
            viewController.presentViewController(imagePickerController, animated: true, completion: {
            })
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        let string:NSMutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText)
        var img  = info[UIImagePickerControllerEditedImage] as! UIImage
        img = self.scaleImage(img)
        let textAttachment = NSTextAttachment()
        textAttachment.image = img
        let textAttachmentString = NSAttributedString(attachment: textAttachment)
        
        let countString:Int = self.selectedRange.location
        string.insertAttributedString(textAttachmentString, atIndex: countString) //可以用这个函数实现 插入到光标所在点 ps:如果你实现了希望能共享
        self.attributedText = string
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImage(image:UIImage)->UIImage{
        UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, image.size.height*(self.bounds.size.width/image.size.width)))
        image.drawInRect(CGRectMake(0, 0, self.bounds.size.width, image.size.height*(self.bounds.size.width/image.size.width)))
        let scaledimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledimage
    }
    
    func alignLeft() {
        self.textAlignment = NSTextAlignment.Left
    }
    
    func alignCenter() {
        self.textAlignment = NSTextAlignment.Center
    }
    
    func alignRight() {
        self.textAlignment = NSTextAlignment.Right
    }

}
