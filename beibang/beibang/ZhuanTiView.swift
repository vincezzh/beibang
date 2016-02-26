//
//  ZhuanTiView.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-25.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ZhuanTiView: UIView {
    
    var numberOfView: Int!

    @IBOutlet weak var contentScrollView: UIScrollView!
    
    class func instanceFromNib() -> ZhuanTiView {
        return NSBundle.mainBundle().loadNibNamed("ZhuanTiView", owner: self, options: nil).first as! ZhuanTiView
    }
    
    override func drawRect(rect: CGRect) {
        for index in 0...numberOfView-1 {
            let button = UIButton()
            button.backgroundColor = UIColor.greenColor()
            button.frame = CGRectMake(0, CGFloat(index * (180 + 8)), self.bounds.width, 180)
            contentScrollView.addSubview(button)
        }
        contentScrollView.contentSize = CGSizeMake(self.bounds.width, CGFloat(numberOfView * (180 + 8)))
    }


}
