//
//  PictureListViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-03-01.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class PictureListViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var onDataAvailable : ((images: [UIImage]) -> ())?
    var assets: [DKAsset]?
    var images: [UIImage] = []
    var imageButtons: [UIButton] = []
    var currentSelectedImageIndex = 0
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var imageListScrollView: UIScrollView!
    @IBOutlet weak var confirmButton: UIButton!
    
    func sendData(images: [UIImage]) {
        self.onDataAvailable?(images: images)
    }
    
    func dismissViewController(images: [UIImage]) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.sendData(images)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if assets == nil {
            launchMultiplePictureSelectionView()
        }
    }
    
    func launchMultiplePictureSelectionView() {
        let pickerController = DKImagePickerController()
        pickerController.assetType = DKImagePickerControllerAssetType.AllPhotos
        pickerController.allowsLandscape = false
        pickerController.allowMultipleTypes = true
        pickerController.sourceType = [DKImagePickerControllerSourceType.Camera, DKImagePickerControllerSourceType.Photo]
        pickerController.singleSelect = false
        pickerController.showsCancelButton = true
        pickerController.maxSelectableCount = 4
        //pickerController.defaultAssetGroup = PHAssetCollectionSubtype.SmartAlbumFavorites
        
        // Clear all the selected assets if you used the picker controller as a single instance.
//        pickerController.defaultSelectedAssets = nil
        pickerController.defaultSelectedAssets = self.assets
        
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            self.assets = assets
            
            self.initializeDecoration()
            self.initializeAction()
        }
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func initializeDecoration() {
        confirmButton.layer.cornerRadius = 5
        
        if assets != nil {
            self.images.removeAll()
            self.imageButtons.removeAll()
            
            let imageButtonWidth = CGFloat(56)
            let imageButtonHeight = CGFloat(56)
            let buttonsWidth = assets!.count * Int(imageButtonWidth) + (assets!.count - 1) * 4
            var startX = 0
            if Int(self.view.bounds.width) > buttonsWidth {
                startX = (Int(self.view.bounds.width) - buttonsWidth) / 2
            }
            for index in 0...assets!.count-1 {
                assets![index].fetchOriginalImage(true, completeBlock: { (image, info) -> Void in
                    self.images.append(image!)
                    
                    let imageButton: UIButton = UIButton()
                    imageButton.tag = index
                    imageButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                    imageButton.setImage(self.resizeImage(image!, scale: 0.1), forState: UIControlState.Normal)
                    imageButton.frame = CGRectMake(CGFloat(startX + index * (Int(imageButtonWidth) + 4)), 4, imageButtonWidth, imageButtonHeight)
                    imageButton.addTarget(self, action: "clickImageButton:", forControlEvents: UIControlEvents.TouchUpInside)
                    self.imageListScrollView.addSubview(imageButton)
                    self.imageButtons.append(imageButton)
                    
                    if index == 0 {
                        self.selectedImageView.image = image
                        imageButton.layer.borderWidth = 2
                        imageButton.layer.borderColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0).CGColor
                    }
                })
            }
            
            let contentSizeWidth = CGFloat(assets!.count * 56)
            if self.view.bounds.width < contentSizeWidth {
                imageListScrollView.contentSize = CGSizeMake(contentSizeWidth, imageButtonHeight)
            }else {
                imageListScrollView.contentSize = CGSizeMake(self.view.bounds.width, imageButtonHeight)
            }
        }
    }
    
    func initializeAction() {
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapSelectedImageView:"))
        tap.delegate = self
        selectedImageView.userInteractionEnabled = true
        selectedImageView.addGestureRecognizer(tap)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func resizeImage(image: UIImage, scale: CGFloat) -> UIImage {
        let newWidth = image.size.width * scale
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func clickImageButton(sender: UIButton!) {
        selectedImageView.image = images[sender.tag]
        
        if imageButtons.count > 0 {
            for index in 0...imageButtons.count-1 {
                imageButtons[index].layer.borderWidth = 0
            }
        }
        currentSelectedImageIndex = sender.tag
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0).CGColor
    }
    
    func tapSelectedImageView(sender: UITapGestureRecognizer) {
        launchIMGLYMainEditorViewController(selectedImageView.image!)
    }
    
    func launchIMGLYMainEditorViewController(image: UIImage) {
        let editorViewController = IMGLYMainEditorViewController()
        editorViewController.highResolutionImage = image
        editorViewController.initialFilterType = .None
        editorViewController.initialFilterIntensity = 0.5
        editorViewController.completionBlock = editorCompletionBlock
        
        let navigationController = IMGLYNavigationController(rootViewController: editorViewController)
        navigationController.navigationBar.barStyle = .Black
        navigationController.navigationBar.translucent = false
        navigationController.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.whiteColor() ]
        
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func editorCompletionBlock(result: IMGLYEditorResult, image: UIImage?) {
        if image != nil {
            selectedImageView.image = image
            images[currentSelectedImageIndex] = image!
            imageButtons[currentSelectedImageIndex].setImage(resizeImage(image!, scale: 0.1), forState: UIControlState.Normal)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func clickConfirmButton(sender: AnyObject) {
        dismissViewController(images)
    }
    
    
    
    
    
    
}
