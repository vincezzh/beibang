//
//  TestViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-28.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var assets: [DKAsset]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func test(sender: AnyObject) {
        let assetType = DKImagePickerControllerAssetType.AllPhotos
        let allowMultipleType = true
        let sourceType: DKImagePickerControllerSourceType = [DKImagePickerControllerSourceType.Camera, DKImagePickerControllerSourceType.Photo]
        let allowsLandscape = false
        let singleSelect = false
        
        showImagePickerWithAssetType(
            assetType,
            allowMultipleType: allowMultipleType,
            sourceType: sourceType,
            allowsLandscape: allowsLandscape,
            singleSelect: singleSelect
        )
    }
    
    func showImagePickerWithAssetType(
        assetType: DKImagePickerControllerAssetType,
        allowMultipleType: Bool,
        sourceType: DKImagePickerControllerSourceType = [.Camera, .Photo],
        allowsLandscape: Bool,
        singleSelect: Bool) {
            
            let pickerController = DKImagePickerController()
            pickerController.assetType = assetType
            pickerController.allowsLandscape = allowsLandscape
            pickerController.allowMultipleTypes = allowMultipleType
            pickerController.sourceType = sourceType
            pickerController.singleSelect = singleSelect
            //			pickerController.showsCancelButton = true
            //			pickerController.showsEmptyAlbums = false
            //			pickerController.defaultAssetGroup = PHAssetCollectionSubtype.SmartAlbumFavorites
            
            // Clear all the selected assets if you used the picker controller as a single instance.
            //			pickerController.defaultSelectedAssets = nil
            pickerController.defaultSelectedAssets = self.assets
            
            pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                print("didSelectAssets. \(assets.count)")
                
                self.assets = assets
            }
            
            if UI_USER_INTERFACE_IDIOM() == .Pad {
                pickerController.modalPresentationStyle = .FormSheet;
            }
            
            self.presentViewController(pickerController, animated: true) {}
    }
}
