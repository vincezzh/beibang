//
//  TouGaoEditorViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-14.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class TouGaoEditorViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var bool: Bool = true
    var textViewY: CGFloat = 0.0
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var currentTextView: UITextView?
    var currentItemLevel: Int = 0
    let placeholder1 = "足够有趣的标题能吸引更多的爸爸妈妈们！当然，一句充满创意的标题，必须包含详细的品牌，产品名以及型号。"
    let placeholder2 = "给宝宝买到了什么好东西？还是作为辣妈奶爸的你给自己拔了颗草？请把你的购物心情和好产品的心得体验分享到这里，通过图文并茂的方式把好产品晒出来吧！同时请对产品外观细节、做工、功能以及使用体验或是购买心得（如：转运规则、尺码信息等）给大家介绍介绍。高品质产品、高人气新品、新奇特好物不仅能得到更多额外奖励，还会让更多宝妈奶爸成为你的粉丝哦！Tips：内文请勿少于5张图片，精美的细节图能大大增加分享的可读性，也就大大增加了众测中奖的机会:)"
    let placeholder3 = "真实的购买链接能够帮助爸爸妈妈们无困难剁手，还有可能让你的分享变成精华帖置顶哦！方式1：使用浏览器可直接拷贝黏贴商品详情页地址，使用APP购买的可以在商品详情页面上点击—复制，然后回到这里粘贴即可；方式2：将订单详情页面截图（iOS：home+电源；Android：电源+音量上），点击左下方照相机图标上传；"
    var tagButtonArray = [
        ["placeholder", true, "恭喜发财"],
        ["placeholder", false, "五福临门"],
        ["placeholder", false, "苦逼大众"],
        ["placeholder", false, "美若天仙"],
        ["placeholder", false, "欠我点钱"],
        ["placeholder", false, "明天很冷"],
        ["placeholder", false, "真的是吗"],
        ["placeholder", false, "赤膊跳跳"],
        ["placeholder", false, "短裤掉了"]
    ]
    var touGaoType = ""

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleTextView: BlogEditor!
    @IBOutlet weak var contentTextView: BlogEditor!
    @IBOutlet weak var contentLinkTextView: BlogEditor!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tagScrollView: UIScrollView!
    @IBOutlet weak var itemLevelButton1: UIButton!
    @IBOutlet weak var itemLevelButton2: UIButton!
    @IBOutlet weak var itemLevelButton3: UIButton!
    @IBOutlet weak var itemLevelButton4: UIButton!
    @IBOutlet weak var itemLevelButton5: UIButton!
    @IBOutlet weak var itemLevelLabel: UILabel!
    @IBOutlet weak var floatView: UIView!
    @IBOutlet weak var floatViewTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var floatLeftButton: UIButton!
    @IBOutlet weak var floatRightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        initializeAction()
    }
    
    func initializeDecoration() {
        previewButton.layer.cornerRadius = 5
        submitButton.layer.cornerRadius = 5
        
        floatView.alpha = 0
        floatView.backgroundColor = UIColor.clearColor()
        
        floatLeftButton.layer.cornerRadius = 0.5 * floatLeftButton.bounds.size.width
        floatLeftButton.clipsToBounds = true
        
        floatRightButton.layer.cornerRadius = 0.5 * floatRightButton.bounds.size.width
        floatRightButton.clipsToBounds = true
        
        let image = UIImage(named: "placeholder")
        let tintedImage = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        itemLevelButton1.setImage(tintedImage, forState: UIControlState.Normal)
        itemLevelButton1.tintColor = UIColor.lightGrayColor()
        itemLevelButton1.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        itemLevelButton2.setImage(tintedImage, forState: UIControlState.Normal)
        itemLevelButton2.tintColor = UIColor.lightGrayColor()
        itemLevelButton2.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        itemLevelButton3.setImage(tintedImage, forState: UIControlState.Normal)
        itemLevelButton3.tintColor = UIColor.lightGrayColor()
        itemLevelButton3.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        itemLevelButton4.setImage(tintedImage, forState: UIControlState.Normal)
        itemLevelButton4.tintColor = UIColor.lightGrayColor()
        itemLevelButton4.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        itemLevelButton5.setImage(tintedImage, forState: UIControlState.Normal)
        itemLevelButton5.tintColor = UIColor.lightGrayColor()
        itemLevelButton5.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    func initializeAction() {
        title = touGaoType
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        
        containerScrollView.delegate = self
        
        titleTextView.delegate = self
        titleTextView.text = placeholder1
        titleTextView.textColor = UIColor.lightGrayColor()
        titleTextView.selectedTextRange = titleTextView.textRangeFromPosition(titleTextView.beginningOfDocument, toPosition: titleTextView.beginningOfDocument)
        titleTextView.viewController = self
        titleTextView.fullMode = false
        
        contentTextView.delegate = self
        contentTextView.text = placeholder2
        contentTextView.textColor = UIColor.lightGrayColor()
        contentTextView.selectedTextRange = contentTextView.textRangeFromPosition(contentTextView.beginningOfDocument, toPosition: contentTextView.beginningOfDocument)
        contentTextView.viewController = self
        titleTextView.fullMode = true
        
        contentLinkTextView.delegate = self
        contentLinkTextView.text = placeholder3
        contentLinkTextView.textColor = UIColor.lightGrayColor()
        contentLinkTextView.selectedTextRange = contentLinkTextView.textRangeFromPosition(contentLinkTextView.beginningOfDocument, toPosition: contentLinkTextView.beginningOfDocument)
        contentLinkTextView.viewController = self
        contentLinkTextView.fullMode = false
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapTitleImageView:"))
        tap.delegate = self
        titleImageView.userInteractionEnabled = true
        titleImageView.addGestureRecognizer(tap)
        
        setItemLevel(5)
        addTagsInTagScrollView()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func clickItemLevelButton1(sender: AnyObject) {
        setItemLevel(1)
    }
    @IBAction func clickItemLevelButton2(sender: AnyObject) {
        setItemLevel(2)
    }
    @IBAction func clickItemLevelButton3(sender: AnyObject) {
        setItemLevel(3)
    }
    @IBAction func clickItemLevelButton4(sender: AnyObject) {
        setItemLevel(4)
    }
    @IBAction func clickItemLevelButton5(sender: AnyObject) {
        setItemLevel(5)
    }
    
    func setItemLevel(level: Int) {
        let levelLabels = ["凑合", "还行~", "不错~", "很棒！", "神奇！"]
        itemLevelButton1.tintColor = UIColor.lightGrayColor()
        itemLevelButton2.tintColor = UIColor.lightGrayColor()
        itemLevelButton3.tintColor = UIColor.lightGrayColor()
        itemLevelButton4.tintColor = UIColor.lightGrayColor()
        itemLevelButton5.tintColor = UIColor.lightGrayColor()
        itemLevelLabel.text = levelLabels[level - 1]
        currentItemLevel = level
        switch level {
            case 5:
                itemLevelButton5.tintColor = UIColor.orangeColor()
                fallthrough
            case 4:
                itemLevelButton4.tintColor = UIColor.orangeColor()
                fallthrough
            case 3:
                itemLevelButton3.tintColor = UIColor.orangeColor()
                fallthrough
            case 2:
                itemLevelButton2.tintColor = UIColor.orangeColor()
                fallthrough
            case 1:
                itemLevelButton1.tintColor = UIColor.orangeColor()
            default:
                print("Wrong level")
        }
    }
    
    func addTagsInTagScrollView() {
        for index in 0...tagButtonArray.count-1 {
            let attributeArray = tagButtonArray[index]
            let image = UIImage(named: attributeArray[0] as! String)
            let tintedImage = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            let tagButton = UIButton()
            tagButton.tag = index
            tagButton.setImage(tintedImage, forState: UIControlState.Normal)
            let isActive = attributeArray[1] as! Bool
            if isActive {
                tagButton.tintColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0)
            }else {
                tagButton.tintColor = UIColor.lightGrayColor()
            }
            tagButton.frame = CGRectMake(CGFloat(index * 55), 0, 30, 50)
            tagButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            tagButton.addTarget(self, action: "clickTagButton:", forControlEvents: UIControlEvents.TouchUpInside)
            tagScrollView.addSubview(tagButton)
        }
        tagScrollView.contentSize = CGSizeMake(CGFloat(tagButtonArray.count * 55), 60)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if let tv = currentTextView {
            let textView = tv as! BlogEditor
            floatView.alpha = 0
            textView.hideKeyboard()
        }
    }
    
    func clickTagButton(sender: UIButton!) {
        let attributeArray = tagButtonArray[sender.tag]
        let isActive = attributeArray[1] as! Bool
        if isActive {
            sender.tintColor = UIColor.lightGrayColor()
        }else {
            sender.tintColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0)
        }
        tagButtonArray[sender.tag][1] = !isActive
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
                if self.textViewY < originDelta/2 {
                    self.containerScrollView.contentOffset.y += originDelta
                }else if self.textViewY < originDelta {
                    self.containerScrollView.contentOffset.y += originDelta/2
                }
                
                if self.currentTextView?.tag == 2 {
                    self.floatView.alpha = 1
                    self.floatViewTopLayoutConstraint.constant = self.screenSize.height + self.containerScrollView.contentOffset.y - originDelta - self.floatView.bounds.height - 70
                }
            }else {
                if self.textViewY < originDelta/2 {
                    self.containerScrollView.contentOffset.y -= originDelta
                }else if self.textViewY < originDelta {
                    self.containerScrollView.contentOffset.y -= originDelta/2
                }
                
                if self.currentTextView?.tag == 2 {
                    self.floatView.alpha = 0
                }
            }
            }, completion: nil)
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        currentTextView = textView
        textViewY = screenSize.height + containerScrollView.contentOffset.y + 64 - textView.frame.origin.y - textView.frame.size.height
        return true
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
    
    func tapTitleImageView(sender: UITapGestureRecognizer) {
        self.resignFirstResponder()
        let actionSheetController: UIAlertController = UIAlertController()
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction) -> Void in
            }
            actionSheetController.addAction(cancelAction)
            let choosePictureAction: UIAlertAction = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                self.clickActionSheetButtons("PhotoLibrary")
            }
            actionSheetController.addAction(choosePictureAction)
            let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                self.clickActionSheetButtons("Camara")
            }
            actionSheetController.addAction(takePictureAction)
        }else {
            let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction) -> Void in
            }
            actionSheetController.addAction(cancelAction)
            let choosePictureAction: UIAlertAction = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                self.clickActionSheetButtons("PhotoLibrary")
            }
            actionSheetController.addAction(choosePictureAction)
        }
        presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func clickActionSheetButtons(type: String) {
        var sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if(type == "PhotoLibrary") {
            sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }else {
            sourceType = UIImagePickerControllerSourceType.Camera
        }
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
//        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        self.presentViewController(imagePickerController, animated: true, completion: {
        })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        var img  = info[UIImagePickerControllerOriginalImage] as! UIImage
        img = self.scaleImage(img)
        titleImageView.image = img
        titleImageView.tag = 1
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImage(image:UIImage)->UIImage{
        UIGraphicsBeginImageContext(CGSizeMake(titleImageView.bounds.size.width, image.size.height*(titleImageView.bounds.size.width/image.size.width)))
        image.drawInRect(CGRectMake(0, 0, titleImageView.bounds.size.width, image.size.height*(titleImageView.bounds.size.width/image.size.width)))
        let scaledimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledimage
    }

    @IBAction func clickPreviewButton(sender: AnyObject) {
        var errorMessage = ""
        if titleImageView.tag == 0 {
            errorMessage = "背景图像忘记上传啦"
        }
        if titleTextView.text == placeholder1 {
            if errorMessage != "" {
                errorMessage += "\n"
            }
            errorMessage += "请输入稿件标题"
        }
        if contentTextView.text == placeholder2 {
            if errorMessage != "" {
                errorMessage += "\n"
            }
            errorMessage += "请输入稿件内容"
        }
        
        if errorMessage == "" {
            performSegueWithIdentifier("previewTouGaoSegue", sender: nil)
        }else {
            showErrorAlert("提示", message: errorMessage)
        }
    }

    @IBAction func clickSubmitButton(sender: AnyObject) {
        
    }
    
    @IBAction func clickCloseButtonInTipPopupView(sender: AnyObject) {
        hidePopupView()
    }
    
    @IBAction func clickFloatViewLeftButton(sender: AnyObject) {
        let textView = currentTextView as! BlogEditor
        textView.hideKeyboard()
        showTipView()
    }
    
    @IBAction func clickFloatViewRightButton(sender: AnyObject) {
        let textView = currentTextView as! BlogEditor
        textView.insertImage()
    }

    var popupView:PopupView?
    var popupViewDic:[String: PopupView] = [:]
    
    var constX:NSLayoutConstraint?
    var constY:NSLayoutConstraint?
    
    func showTipView() {
        
        //Load nib, and get reference to variable 'popupView'.
        popupView = NSBundle.mainBundle().loadNibNamed("PopupView", owner: self, options: nil)[0] as? PopupView
        self.view.addSubview(popupView!)
        
        //Configure popupview
        popupView?.frame.size = CGSizeMake(0, 0)
        popupView?.center = self.view.center
        popupView?.alpha = 0.5
        popupView?.clipsToBounds = false
        
        //Autolayout part
        popupViewDic["popupView"] = popupView
        
        var dView:[String: UIView] = [:]
        dView["popupView"] = popupView
        
        popupView?.translatesAutoresizingMaskIntoConstraints = false
        
        let h_Pin = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(screenSize.width/8))-[popupView]-(\(screenSize.width/8))-|", options: [], metrics: nil, views: dView)
        self.view.addConstraints(h_Pin)
        
        let v_Pin = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(\(screenSize.height/4))-[popupView]-(\(screenSize.height/4))-|", options: [], metrics: nil, views: dView)
        self.view.addConstraints(v_Pin)
        
        constY = NSLayoutConstraint(item: popupView!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.view.addConstraint(constY!)
        
        constX = NSLayoutConstraint(item: popupView!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(constX!)
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.50, options: UIViewAnimationOptions.LayoutSubviews, animations: { () -> Void in
            self.popupView?.alpha = 1
            self.popupView?.backgroundColor = UIColor.clearColor()
            self.view.layoutIfNeeded()
            }) { (value:Bool) -> Void in
                
        }
    }
    
    func hidePopupView() {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.50, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.popupView!.alpha = 0
            
            }) { (value:Bool) -> Void in
                self.popupView!.removeFromSuperview()
                
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "previewTouGaoSegue") {
            let viewController = segue.destinationViewController as! TouGaoPreviewViewController
            let touGao = TouGao()
            touGao.titleImage = titleImageView.image
            touGao.titleText = titleTextView.text
            touGao.contentText = contentTextView.attributedText
            touGao.itemLevel = currentItemLevel
            touGao.type = touGaoType
            var tagLabelArray: [String] = []
            for index in 0...tagButtonArray.count-1 {
                let attributeArray = tagButtonArray[index]
                let isActive = attributeArray[1] as! Bool
                if isActive {
                    tagLabelArray.append(attributeArray[2] as! String)
                }
            }
            touGao.tagLabelArray = tagLabelArray
            
            viewController.touGao = touGao
        }
    }
    
    func showErrorAlert(title: String, message: String) {
        let alertView = UNAlertView(title: title, message: message)
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
