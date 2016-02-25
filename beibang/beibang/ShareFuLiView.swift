//
//  ShareFuLiView.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-25.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ShareFuLiView: UIView {
    
    @IBOutlet weak var fuliImageButton: UIButton!
    @IBOutlet weak var fuliRecommondationNumberLabel: UILabel!
    
    class func instanceFromNib() -> ShareFuLiView {
        return NSBundle.mainBundle().loadNibNamed("ShareFuLiView", owner: self, options: nil).first as! ShareFuLiView
    }

    override func drawRect(rect: CGRect) {
        
    }

}
