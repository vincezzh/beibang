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
    @IBOutlet weak var willBeMomButton: UIButton!
    @IBOutlet weak var hasBeenMomButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
    }
    
    func initializeDecoration() {
        avatarSelectButton.layer.cornerRadius = 0.5 * avatarSelectButton.bounds.size.width
        avatarSelectButton.clipsToBounds = true
        
        willBePregnantButton.layer.cornerRadius = 0.5 * willBePregnantButton.bounds.size.width
        willBePregnantButton.clipsToBounds = true
        
        willBeMomButton.layer.cornerRadius = 0.5 * willBeMomButton.bounds.size.width
        willBeMomButton.clipsToBounds = true
        
        hasBeenMomButton.layer.cornerRadius = 0.5 * hasBeenMomButton.bounds.size.width
        hasBeenMomButton.clipsToBounds = true
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
}
