//
//  ShareMainViewController.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-25.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ShareMainViewController: UIViewController {
    
    var fuliViewArray = [
        ["placeholder", "123位妈妈推荐"],
        ["placeholder", "76位妈妈推荐"],
        ["placeholder", "18位妈妈推荐"],
        ["placeholder", "156位妈妈推荐"],
        ["placeholder", "333位妈妈推荐"],
        ["placeholder", "16位妈妈推荐"],
        ["placeholder", "133位妈妈推荐"]
    ]
    
    @IBOutlet weak var upperScrollViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topBackgroundImageView: UIImageView!
    @IBOutlet weak var signInSignUpButton: UIButton!
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFollowerNumberLabel: UILabel!
    @IBOutlet weak var letterButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var fuLiHuiScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        initializeAction()
    }
    
    func initializeDecoration() {
        signInSignUpButton.alpha = 0
        
        avatarButton.layer.cornerRadius = 0.5 * avatarButton.bounds.size.width
        avatarButton.clipsToBounds = true
    }
    
    func initializeAction() {
        addFuLiViewsInFuLiScrollView()
    }
    
    func addFuLiViewsInFuLiScrollView() {
        for index in 0...fuliViewArray.count-1 {
            let attributeArray = fuliViewArray[index]
            let fuliView: ShareFuLiView = ShareFuLiView.instanceFromNib()
            fuliView.fuliImageButton.setImage(UIImage(named: attributeArray[0]), forState: UIControlState.Normal)
            fuliView.fuliImageButton.layer.cornerRadius = 5
            fuliView.fuliImageButton.clipsToBounds = true
            fuliView.fuliRecommondationNumberLabel.text = attributeArray[1]
            fuliView.frame = CGRectMake(CGFloat(index * 108), 0, 108, 128)
            fuLiHuiScrollView.addSubview(fuliView)
        }
        fuLiHuiScrollView.contentSize = CGSizeMake(CGFloat(fuliViewArray.count * 108 + 8), 128)
    }

    func moveUp() {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.upperScrollViewTopConstraint.constant = -264
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func moveDown() {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.upperScrollViewTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func clickZuiXinButton(sender: AnyObject) {
        moveDown()
    }
    
    @IBAction func clickZhuanTiButton(sender: AnyObject) {
        moveUp()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
