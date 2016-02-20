//
//  TouGaoPopupButtonsViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-19.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class TouGaoPopupButtonsViewController: UIViewController {

    var touGaoType = ""
    var delegate: MainViewController? = nil
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var chaoZhiBaoLiaoButton: UIButton!
    @IBOutlet weak var shaiWuFenXiangButton: UIButton!
    @IBOutlet weak var maMaPingCeButton: UIButton!
    @IBOutlet weak var shengHuoJiLuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        initializeAction()
    }
    
    func initializeDecoration() {
        buttonsView.layer.cornerRadius = 5
//        buttonsView.layer.borderWidth = 1
//        buttonsView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        chaoZhiBaoLiaoButton.clipsToBounds = true
        let chaoZhiBaoLiaoButtonBottomBorder: CALayer = CALayer()
        chaoZhiBaoLiaoButtonBottomBorder.borderColor = UIColor.lightGrayColor().CGColor
        chaoZhiBaoLiaoButtonBottomBorder.borderWidth = 1
        chaoZhiBaoLiaoButtonBottomBorder.frame = CGRectMake(-1, -1, CGRectGetWidth(chaoZhiBaoLiaoButton.frame)+2, CGRectGetHeight(chaoZhiBaoLiaoButton.frame)-2)
        chaoZhiBaoLiaoButton.layer.addSublayer(chaoZhiBaoLiaoButtonBottomBorder)
        
        shaiWuFenXiangButton.clipsToBounds = true
        let shaiWuFenXiangButtonBottomBorder: CALayer = CALayer()
        shaiWuFenXiangButtonBottomBorder.borderColor = UIColor.lightGrayColor().CGColor
        shaiWuFenXiangButtonBottomBorder.borderWidth = 1
        shaiWuFenXiangButtonBottomBorder.frame = CGRectMake(-1, -1, CGRectGetWidth(shaiWuFenXiangButton.frame)+2, CGRectGetHeight(shaiWuFenXiangButton.frame)-2)
        shaiWuFenXiangButton.layer.addSublayer(shaiWuFenXiangButtonBottomBorder)
        
        maMaPingCeButton.clipsToBounds = true
        let maMaPingCeButtonBottomBorder: CALayer = CALayer()
        maMaPingCeButtonBottomBorder.borderColor = UIColor.lightGrayColor().CGColor
        maMaPingCeButtonBottomBorder.borderWidth = 1
        maMaPingCeButtonBottomBorder.frame = CGRectMake(-1, -1, CGRectGetWidth(maMaPingCeButton.frame)+2, CGRectGetHeight(maMaPingCeButton.frame)-2)
        maMaPingCeButton.layer.addSublayer(maMaPingCeButtonBottomBorder)
    }
    
    func initializeAction() {
    }

    @IBAction func clickChaoZhiBaoLiaoButton(sender: AnyObject) {
        touGaoType = "超值爆料"
        delegate?.setTouGaoTypeAndPerformSegue(touGaoType)
    }
    
    @IBAction func clickShaiWuFenXiangButton(sender: AnyObject) {
        touGaoType = "晒物分享"
        delegate?.setTouGaoTypeAndPerformSegue(touGaoType)
    }
    
    @IBAction func clickMaMaPingCeButton(sender: AnyObject) {
        touGaoType = "妈妈评测"
        delegate?.setTouGaoTypeAndPerformSegue(touGaoType)
    }
    
    @IBAction func clickShengHuoJiLuButton(sender: AnyObject) {
        touGaoType = "生活记录"
        delegate?.setTouGaoTypeAndPerformSegue(touGaoType)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
