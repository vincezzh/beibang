//
//  ArticleDetailViewController.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-26.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
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
    @IBOutlet weak var tagLabelsScrollView: UIScrollView!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var followerScrollView: UIScrollView!
    @IBOutlet weak var commentNumberLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var writeCommentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDecoration()
        initializeData()
        initializeAction()
    }
    
    func initializeDecoration() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let button = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
        self.navigationItem.leftBarButtonItem = button
        
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
        writeCommentTextField.layer.cornerRadius = 5
        sendButton.layer.cornerRadius = 5
    }
    
    func initializeData() {
        title = touGao.titleText
        ImageUtil.loadImage(touGao.titleImageUrl, imageView: titleImageView)
        titleTextView.text = touGao.titleText
        contentTextView.attributedText = touGao.contentText
        setItemLevel(touGao.itemLevel)
        addTagsInTagScrollView(touGao.tagLabelArray)
        addLikeUsersScrollView(touGao.likeUsers)
    }
    
    func initializeAction() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
    
    func goBack() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.popViewControllerAnimated(true)
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
    
    func addLikeUsersScrollView(users: [User]) {
        for index in 0...users.count-1 {
            let button = UIButton()
            ImageUtil.loadImage(users[index].avatarUrl, button: button)
            button.frame = CGRectMake(CGFloat(index * (35 + 8)), 2, 35, 35)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.clipsToBounds = true
            followerScrollView.addSubview(button)
        }
        followerScrollView.contentSize = CGSizeMake(CGFloat(users.count * (35 + 8)), 44)
    }
    
    

}

extension ArticleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touGao.comments.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell") as! CommentCell
        cell.initializeData(touGao.comments[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        parentViewController.performSegueWithIdentifier("showArticleDetailSegue", sender: touGaos[indexPath.row])
    }
}
