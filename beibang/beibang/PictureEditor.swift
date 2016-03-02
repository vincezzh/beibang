//
//  PictureEditor.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-03-01.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class PictureEditor {
    
    var viewController: UIViewController!
    var assets: [DKAsset]?
    
    func launchMultiplePictureSelectionView() {
        let pickerController = DKImagePickerController()
        pickerController.assetType = DKImagePickerControllerAssetType.AllPhotos
        pickerController.allowsLandscape = false
        pickerController.allowMultipleTypes = true
        pickerController.sourceType = [DKImagePickerControllerSourceType.Camera, DKImagePickerControllerSourceType.Photo]
        pickerController.singleSelect = false
        pickerController.showsCancelButton = true
        //pickerController.defaultAssetGroup = PHAssetCollectionSubtype.SmartAlbumFavorites
            
        // Clear all the selected assets if you used the picker controller as a single instance.
        //pickerController.defaultSelectedAssets = nil
        pickerController.defaultSelectedAssets = self.assets
        
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            print("didSelectAssets. \(assets.count)")
            
            self.assets = assets
        }
        
        viewController.presentViewController(pickerController, animated: true) {}
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
        
        viewController.presentViewController(navigationController, animated: true, completion: nil)
        
    }
    
    func editorCompletionBlock(result: IMGLYEditorResult, image: UIImage?) {
        print("done")
    }
}