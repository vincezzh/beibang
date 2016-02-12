//
//  ChaoZhiBaoLiaoViewController.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-12.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ChaoZhiBaoLiaoViewController: UIViewController {

    @IBOutlet weak var urlLinkTextView: UITextView!
    @IBOutlet weak var checkItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
    }
    
    func initializeDecoration() {
        checkItemButton.layer.cornerRadius = 5
    }
    
    @IBAction func clickCheckItemButton(sender: AnyObject) {
        if !urlLinkTextView.text.hasPrefix("http://") || !urlLinkTextView.text.hasPrefix("https://") {
            let alertView = UNAlertView(title: "提示", message: "输入的商品链接貌似不太对")
            alertView.messageAlignment = NSTextAlignment.Center
            alertView.buttonAlignment  = UNButtonAlignment.Horizontal
            alertView.addButton("关闭",
                backgroundColor: UIColor(red: 219 / 255.0, green: 82 / 255.0, blue: 75 / 255.0, alpha: 1.0),
                fontColor: UIColor.whiteColor(),
                action: {}
            )
            alertView.show()
        }
    }

}
