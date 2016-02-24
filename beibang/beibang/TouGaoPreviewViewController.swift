//
//  TouGaoPreviewViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-17.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class TouGaoPreviewViewController: UIViewController {
    
    var touGao: TouGao!

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var itemLevelButton1: UIButton!
    @IBOutlet weak var itemLevelButton2: UIButton!
    @IBOutlet weak var itemLevelButton3: UIButton!
    @IBOutlet weak var itemLevelButton4: UIButton!
    @IBOutlet weak var itemLevelButton5: UIButton!
    @IBOutlet weak var buyLinkButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var tagLabelsScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        initializeAction()
        initializeData()
    }
    
    func initializeDecoration() {
        avatarImageView.layer.cornerRadius = 0.5 * avatarImageView.bounds.size.width
        avatarImageView.clipsToBounds = true
        
        followButton.layer.cornerRadius = 5
        
        let image = UIImage(named: "star-icon")
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
        
        buyLinkButton.layer.cornerRadius = 5
        loveButton.layer.cornerRadius = 5
        loveButton.clipsToBounds = true
        bookmarkButton.layer.cornerRadius = 5
        bookmarkButton.clipsToBounds = true
        shareButton.layer.cornerRadius = 5
        shareButton.clipsToBounds = true
        goBackButton.layer.cornerRadius = 5
        submitButton.layer.cornerRadius = 5
    }
    
    func initializeAction() {
        title = "预览"
    }
    
    func initializeData() {
        titleImageView.image = touGao.titleImage
        titleTextView.text = touGao.titleText
        contentTextView.attributedText = touGao.contentText
        setItemLevel(touGao.itemLevel)
        addTagsInTagScrollView(touGao.tagLabelArray)
    }
    
    func setItemLevel(level: Int) {
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
    
    func addTagsInTagScrollView(tags: [String]) {
        for index in 0...tags.count-1 {
            let tagLabel = UILabel()
            tagLabel.text = tags[index]
            tagLabel.font = UIFont(name: tagLabel.font.fontName, size: 12)
            tagLabel.frame = CGRectMake(CGFloat(index * 55), 0, 55, tagLabelsScrollView.bounds.height)
            tagLabelsScrollView.addSubview(tagLabel)
        }
        tagLabelsScrollView.contentSize = CGSizeMake(CGFloat(tags.count * 55), tagLabelsScrollView.bounds.height)
    }
    
    @IBAction func clickGoBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    
    
    

}
