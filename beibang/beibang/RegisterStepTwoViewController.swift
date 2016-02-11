//
//  RegisterStepTwoViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-09.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class RegisterStepTwoViewController: UIViewController, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var avatarSelectButton: UIButton!
    @IBOutlet weak var willBePregnantButton: UIButton!
    @IBOutlet weak var willBePregnantLabel: UILabel!
    @IBOutlet weak var willBePregnantDoneButton: UIButton!
    @IBOutlet weak var willBePregnantView: UIView!
    @IBOutlet weak var willBeMomButton: UIButton!
    @IBOutlet weak var willBeMomLabel: UILabel!
    @IBOutlet weak var willBeMomDateTextfield: UITextField!
    @IBOutlet weak var willBeMomDoneButton: UIButton!
    @IBOutlet weak var willBeMomView: UIView!
    @IBOutlet weak var hasBeenMomButton: UIButton!
    @IBOutlet weak var hasBeenMomLabel: UILabel!
    @IBOutlet weak var hasBeenMomBabyNameTextfield: UITextField!
    @IBOutlet weak var hasBeenMomBabyBirthdayTextfield: UITextField!
    @IBOutlet weak var hasBeenMomSetMainPageButton: UIButton!
    @IBOutlet weak var hasBeenMomDoneButton: UIButton!
    @IBOutlet weak var hasBeenMomView: UIView!
    
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
        var sheet:UIActionSheet
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil,otherButtonTitles: "从相册选择", "拍照")
        }else{
            sheet = UIActionSheet(title:nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择")
        }
        sheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        var sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if(buttonIndex != 0){
            if(buttonIndex == 1) {
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
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.willBeMomButton.alpha = 0
                self.willBeMomLabel.alpha = 0
                self.hasBeenMomButton.alpha = 0
                self.hasBeenMomLabel.alpha = 0
            }) { (result: Bool) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    let screenCenterX = UIScreen.mainScreen().bounds.width / 2
                    self.willBePregnantButton.center = CGPointMake(screenCenterX, self.willBePregnantButton.center.y)
                    self.willBePregnantLabel.center = CGPointMake(screenCenterX, self.willBePregnantLabel.center.y)
                    self.willBePregnantView.center = CGPointMake(self.willBePregnantView.center.x, self.willBePregnantView.center.y - 91)
                    }, completion: nil)
        }
    }
    
    @IBAction func clickWillBeMomButton(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.willBePregnantButton.alpha = 0
            self.willBePregnantLabel.alpha = 0
            self.hasBeenMomButton.alpha = 0
            self.hasBeenMomLabel.alpha = 0
            }) { (result: Bool) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.willBeMomView.center = CGPointMake(self.willBeMomView.center.x, self.willBeMomView.center.y - 237)
                    }, completion: nil)
        }
    }
    
    @IBAction func clickHasBeenMomButton(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.willBeMomButton.alpha = 0
            self.willBeMomLabel.alpha = 0
            self.willBePregnantButton.alpha = 0
            self.willBePregnantLabel.alpha = 0
            }) { (result: Bool) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    let screenCenterX = UIScreen.mainScreen().bounds.width / 2
                    self.hasBeenMomButton.center = CGPointMake(screenCenterX, self.hasBeenMomButton.center.y)
                    self.hasBeenMomLabel.center = CGPointMake(screenCenterX, self.hasBeenMomLabel.center.y)
                    self.hasBeenMomView.center = CGPointMake(self.hasBeenMomView.center.x, self.hasBeenMomView.center.y - 307)
                    }, completion: nil)
        }
    }
    
    
    
    
    
    
}
