//
//  ZuiXinView.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-25.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ZuiXinView: UIView {
    
    var fuliViewArray: [[String]]!
    
    @IBOutlet weak var fuLiHuiScrollView: UIScrollView!
    
    class func instanceFromNib() -> ZuiXinView {
        return NSBundle.mainBundle().loadNibNamed("ZuiXinView", owner: self, options: nil).first as! ZuiXinView
    }

    override func drawRect(rect: CGRect) {
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


}
