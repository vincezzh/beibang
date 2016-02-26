//
//  ShareMainViewController.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-25.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ShareMainViewController: UIViewController {
    
    var zuiXinView: ZuiXinView?
    var zhuanTiView: ZhuanTiView?
    
    var fuliViewArray = [
        ["placeholder", "123位妈妈推荐"],
        ["placeholder", "76位妈妈推荐"],
        ["placeholder", "18位妈妈推荐"],
        ["placeholder", "156位妈妈推荐"],
        ["placeholder", "333位妈妈推荐"],
        ["placeholder", "16位妈妈推荐"],
        ["placeholder", "133位妈妈推荐"]
    ]
    
    @IBOutlet weak var topScrollView: UIScrollView!
    @IBOutlet weak var upperScrollViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topBackgroundImageView: UIImageView!
    @IBOutlet weak var signInSignUpButton: UIButton!
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFollowerNumberLabel: UILabel!
    @IBOutlet weak var letterButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!

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
        addZuiXinView()
    }
    
    func removeAllViews() {
        if zuiXinView != nil {
            zuiXinView?.alpha = 0
        }
        if zhuanTiView != nil {
            zhuanTiView?.alpha = 0
        }
    }
    
    func addZuiXinView() {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.removeAllViews()
        }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                if self.zuiXinView == nil {
                    self.zuiXinView = ZuiXinView.instanceFromNib()
                    self.zuiXinView!.fuliViewArray = self.fuliViewArray
                    self.view.addSubview(self.zuiXinView!)
                    
                    var dView:[String: UIView] = [:]
                    dView["topScrollView"] = self.topScrollView
                    dView["zuiXinView"] = self.zuiXinView
                    self.zuiXinView!.translatesAutoresizingMaskIntoConstraints = false
                    let h_Pin = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[zuiXinView]-(0)-|", options: [], metrics: nil, views: dView)
                    self.view.addConstraints(h_Pin)
                    let v_Pin = NSLayoutConstraint.constraintsWithVisualFormat("V:[topScrollView]-(0)-[zuiXinView]-(0)-|", options: [], metrics: nil, views: dView)
                    self.view.addConstraints(v_Pin)
                }else {
                    self.zuiXinView?.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    func addZhuanTiView() {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.removeAllViews()
        }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                if self.zhuanTiView == nil {
                    self.zhuanTiView = ZhuanTiView.instanceFromNib()
                    self.zhuanTiView!.numberOfView = 8
                    self.view.addSubview(self.zhuanTiView!)
                    
                    var dView:[String: UIView] = [:]
                    dView["topScrollView"] = self.topScrollView
                    dView["zhuanTiView"] = self.zhuanTiView
                    self.zhuanTiView!.translatesAutoresizingMaskIntoConstraints = false
                    let h_Pin = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[zhuanTiView]-(0)-|", options: [], metrics: nil, views: dView)
                    self.view.addConstraints(h_Pin)
                    let v_Pin = NSLayoutConstraint.constraintsWithVisualFormat("V:[topScrollView]-(0)-[zhuanTiView]-(0)-|", options: [], metrics: nil, views: dView)
                    self.view.addConstraints(v_Pin)
                }else {
                    self.zhuanTiView?.alpha = 1
                }
            }, completion: nil)
        }
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
        addZuiXinView()
    }
    
    @IBAction func clickZhuanTiButton(sender: AnyObject) {
        moveUp()
        addZhuanTiView()
    }
    
    @IBAction func clickAvatarButton(sender: AnyObject) {
        moveUp()
        addZuiXinView()
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
