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
    var chaoZhiView: ChaoZhiView?
    
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        
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
        if chaoZhiView != nil {
            chaoZhiView?.alpha = 0
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
                    self.addConstraintsForBottomScrollView(self.zuiXinView!)
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
                    self.addConstraintsForBottomScrollView(self.zhuanTiView!)
                }else {
                    self.zhuanTiView?.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    func addChaoZhiView() {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.removeAllViews()
        }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                if self.chaoZhiView == nil {
                    var touGaos: [TouGao] = []
                    let tougao = TouGao()
                    tougao.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
                    tougao.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
                    tougao.contentText = NSAttributedString(string: "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！")
                    tougao.tagLabelArray = ["一二三四", "恭喜发财"]
                    let author = User()
                    author.name = "熊爸爸"
                    author.avatarUrl = "http://www.bmw.ca/content/dam/bmw/common/all-models/3-series/sedan/2015/at-a-glance/3-series-m-sport-package-04.jpg/jcr:content/renditions/cq5dam.resized.img.485.low.time1447942782786.jpg"
                    tougao.author = author
                    tougao.likeNumber = "💜200"
                    touGaos.append(tougao)
                    
                    let tougao1 = TouGao()
                    tougao1.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
                    tougao1.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
                    tougao1.contentText = NSAttributedString(string: "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！")
                    tougao1.tagLabelArray = ["一二三四", "恭喜发财", "好运连连", "绝对划算", "上门看看"]
                    let author1 = User()
                    author1.name = "潮妈小辣椒"
                    author1.avatarUrl = "http://cdn.bmwblog.com/wp-content/uploads/BMW-10-750x500.jpg"
                    tougao1.author = author
                    tougao1.likeNumber = "💜87"
                    touGaos.append(tougao1)
                    
                    
                    
                    
                    
                    self.chaoZhiView = ChaoZhiView.instanceFromNib()
                    self.chaoZhiView?.parentViewController = self
                    self.chaoZhiView!.touGaos = touGaos
                    self.view.addSubview(self.chaoZhiView!)
                    self.addConstraintsForBottomScrollView(self.chaoZhiView!)
                }else {
                    self.chaoZhiView?.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    func addConstraintsForBottomScrollView(addedView: UIView) {
        var dView:[String: UIView] = [:]
        dView["topScrollView"] = topScrollView
        dView["addedView"] = addedView
        addedView.translatesAutoresizingMaskIntoConstraints = false
        let h_Pin = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[addedView]-(0)-|", options: [], metrics: nil, views: dView)
        self.view.addConstraints(h_Pin)
        let v_Pin = NSLayoutConstraint.constraintsWithVisualFormat("V:[topScrollView]-(0)-[addedView]-(0)-|", options: [], metrics: nil, views: dView)
        self.view.addConstraints(v_Pin)
    }

    func moveUp(doAfterMove: (()->())?) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.upperScrollViewTopConstraint.constant = -280
            self.view.layoutIfNeeded()
        }) { (finished: Bool) -> Void in
            if doAfterMove != nil {
                doAfterMove!()
            }
        }
    }
    
    func moveDown(doAfterMove: (()->())?) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.upperScrollViewTopConstraint.constant = -16
            self.view.layoutIfNeeded()
        }) { (finished: Bool) -> Void in
            if doAfterMove != nil {
                doAfterMove!()
            }
        }
    }
    
    @IBAction func clickAvatarButton(sender: AnyObject) {
        moveUp(addZuiXinView)
    }
    
    @IBAction func clickZuiXinButton(sender: AnyObject) {
        moveDown(addZuiXinView)
    }
    
    @IBAction func clickZhuanTiButton(sender: AnyObject) {
        moveUp(addZhuanTiView)
    }
    
    @IBAction func clickChaoZhiButton(sender: AnyObject) {
        moveUp(addChaoZhiView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showArticleDetailSegue" {
            let viewController = segue.destinationViewController as! ArticleDetailViewController
            let param: TouGao = sender as! TouGao
            viewController.touGao = param
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
