//
//  PictureListViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-03-01.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class PictureListViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var assets: [DKAsset]?
    let pictureEditor: PictureEditor = PictureEditor()
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var imageListScrollView: UIScrollView!
    @IBOutlet weak var confirmButton: UIButton!
    
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
        
        self.presentViewController(pickerController, animated: false, completion: nil)
    }
    
    func initializeDecoration() {
        pictureEditor.viewController = self
        
        confirmButton.layer.cornerRadius = 5
        
        if assets != nil {
            for index in 0...assets!.count-1 {
                assets![index].fetchOriginalImage(true, completeBlock: { (image, info) -> Void in
                    if index == 0 {
                        self.selectedImageView.image = image
                    }
                    
                    let imageButton: UIButton = UIButton()
                    imageButton.setImage(image, forState: UIControlState.Normal)
                    imageButton.frame = CGRectMake(CGFloat(index * 60) + 4, 4, 56, 56)
                    imageButton.addTarget(self, action: "clickImageButton:", forControlEvents: UIControlEvents.TouchUpInside)
                    self.imageListScrollView.addSubview(imageButton)
                })
            }
            imageListScrollView.contentSize = CGSizeMake(CGFloat(assets!.count * 56 + 4), 56)
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
    
    func clickImageButton(sender: UIButton!) {
        selectedImageView.image = sender.imageView?.image
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.redColor().CGColor
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
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
