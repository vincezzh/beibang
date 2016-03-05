//
//  TestViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-03-02.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var allImages: [UIImage] = []
    @IBOutlet weak var previewCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        previewCollectionView.dataSource = self
        previewCollectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func test(sender: AnyObject) {
        performSegueWithIdentifier("displayPictureEditorSegue", sender: nil)
    }
    
    func doPicturesWithData(images: [UIImage]) {
        allImages = images
        previewCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "displayPictureEditorSegue" {
            if let viewController = segue.destinationViewController as? PictureListViewController {
                viewController.onDataAvailable = {[weak self]
                    (data) in
                    if let weakSelf = self {
                        weakSelf.doPicturesWithData(data)
                    }
                }
            }
        }
    }

}

extension TestViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = previewCollectionView.bounds.size.width / 2
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: NSInteger) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: NSInteger) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: NSInteger) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PreviewCell
        let imageView = cell.previewImageView
        imageView.image = allImages[indexPath.row]
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}