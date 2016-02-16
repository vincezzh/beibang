//
//  RegisterStepTwoViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-09.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class RegisterStepTwoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var avatarSelectButton: UIButton!
    @IBOutlet weak var willBePregnantButton: UIButton!
    @IBOutlet weak var willBePregnantLabel: UILabel!
    @IBOutlet weak var willBePregnantDoneButton: UIButton!
    @IBOutlet weak var willBePregnantBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var willBePregnantButtonLeadingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var willBePregnantLabelLeadingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var willBeMomButton: UIButton!
    @IBOutlet weak var willBeMomLabel: UILabel!
    @IBOutlet weak var willBeMomDateTextfield: UITextField!
    @IBOutlet weak var willBeMomDoneButton: UIButton!
    @IBOutlet weak var willBeMomBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var hasBeenMomButton: UIButton!
    @IBOutlet weak var hasBeenMomLabel: UILabel!
    @IBOutlet weak var hasBeenMomBabyNameTextfield: UITextField!
    @IBOutlet weak var hasBeenMomBabyBirthdayTextfield: UITextField!
    @IBOutlet weak var hasBeenMomSetMainPageButton: UIButton!
    @IBOutlet weak var hasBeenMomDoneButton: UIButton!
    @IBOutlet weak var hasBeenMomBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var hasBeenMomButtonTrailingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var hasBeenMomLabelTrailingLayoutConstraint: NSLayoutConstraint!
    
    var willBePregnantViewIsShown = false
    var willBeMomViewIsShown = false
    var hasBeenMomViewShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
    }
    
    func initializeDecoration() {
        avatarSelectButton.layer.cornerRadius = 0.5 * avatarSelectButton.bounds.size.width
        avatarSelectButton.clipsToBounds = true
        
        willBePregnantButton.layer.cornerRadius = 0.5 * willBePregnantButton.bounds.size.width
        willBePregnantButton.clipsToBounds = true
        willBePregnantDoneButton.layer.cornerRadius = 5
        
        willBeMomButton.layer.cornerRadius = 0.5 * willBeMomButton.bounds.size.width
        willBeMomButton.clipsToBounds = true
        willBeMomDateTextfield.borderStyle = UITextBorderStyle.RoundedRect
        willBeMomDoneButton.layer.cornerRadius = 5
        
        hasBeenMomButton.layer.cornerRadius = 0.5 * hasBeenMomButton.bounds.size.width
        hasBeenMomButton.clipsToBounds = true
        hasBeenMomBabyNameTextfield.borderStyle = UITextBorderStyle.RoundedRect
        hasBeenMomBabyBirthdayTextfield.borderStyle = UITextBorderStyle.RoundedRect
        hasBeenMomSetMainPageButton.layer.cornerRadius = 5
        hasBeenMomDoneButton.layer.cornerRadius = 5
    }

    @IBAction func selectAvatar(sender: AnyObject) {
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
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        self.presentViewController(imagePickerController, animated: true, completion: {
        })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var img  = info[UIImagePickerControllerEditedImage] as! UIImage
        img = scaleImage(img)
        avatarSelectButton.setImage(img, forState: .Normal)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImage(image:UIImage) -> UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(self.view.bounds.size.width, image.size.height*(self.view.bounds.size.width/image.size.width)))
        image.drawInRect(CGRectMake(0, 0, self.view.bounds.size.width, image.size.height*(self.view.bounds.size.width/image.size.width)))
        let scaledimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledimage
    }
    
    @IBAction func clickWillBePregnantButton(sender: AnyObject) {
        if !willBePregnantViewIsShown {
            willBePregnantViewIsShown = true
            
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.willBeMomButton.alpha = 0
                    self.willBeMomLabel.alpha = 0
                    self.hasBeenMomButton.alpha = 0
                    self.hasBeenMomLabel.alpha = 0
                }) { (finished: Bool) -> Void in
                    UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                        let screenCenterX = UIScreen.mainScreen().bounds.width / 2
                        self.willBePregnantButtonLeadingLayoutConstraint.constant += (screenCenterX - 20 - 20 - self.willBePregnantButton.bounds.size.width/2)
                        self.willBePregnantLabelLeadingLayoutConstraint.constant += (screenCenterX - 36 - 20 - self.willBePregnantLabel.bounds.size.width/2)
                        self.willBePregnantBottomLayoutConstraint.constant += 91
                        self.view.layoutIfNeeded()
                    }, completion: nil)
            }
        }
    }
    
    @IBAction func clickWillBeMomButton(sender: AnyObject) {
        if !willBeMomViewIsShown {
            willBeMomViewIsShown = true
            
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.willBePregnantButton.alpha = 0
                self.willBePregnantLabel.alpha = 0
                self.hasBeenMomButton.alpha = 0
                self.hasBeenMomLabel.alpha = 0
                }) { (finished: Bool) -> Void in
                    UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                        self.willBeMomBottomLayoutConstraint.constant += 237
                        self.view.layoutIfNeeded()
                        }, completion: nil)
            }
        }
    }
    
    @IBAction func clickHasBeenMomButton(sender: AnyObject) {
        if !hasBeenMomViewShown {
            hasBeenMomViewShown = true
            
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.willBeMomButton.alpha = 0
                self.willBeMomLabel.alpha = 0
                self.willBePregnantButton.alpha = 0
                self.willBePregnantLabel.alpha = 0
                }) { (finished: Bool) -> Void in
                    UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                        let screenCenterX = UIScreen.mainScreen().bounds.width / 2
                        self.hasBeenMomButtonTrailingLayoutConstraint.constant += (screenCenterX - 20 - 20 - self.hasBeenMomButton.bounds.size.width/2)
                        self.hasBeenMomLabelTrailingLayoutConstraint.constant += (screenCenterX - 21 - 20 - self.hasBeenMomLabel.bounds.size.width/2)
                        self.hasBeenMomBottomLayoutConstraint.constant += 307
                        self.view.layoutIfNeeded()
                        }, completion: nil)
            }
        }
    }
    
    
    
    
    
    
}
