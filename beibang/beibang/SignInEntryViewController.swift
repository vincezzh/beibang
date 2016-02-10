//
//  SignInViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-08.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class SignInEntryViewController: UIViewController {

    @IBOutlet weak var block1View: UIView!
    @IBOutlet weak var block2View: UIView!
    @IBOutlet weak var block3View: UIView!
    @IBOutlet weak var avatarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDecoration()
    }
    
    func initializeDecoration() {
        title = "账户"
        
        let blockBorderColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0).CGColor
        block1View.layer.borderWidth = 1
        block1View.layer.borderColor = blockBorderColor
        block2View.layer.borderWidth = 1
        block2View.layer.borderColor = blockBorderColor
        block3View.layer.borderWidth = 1
        block3View.layer.borderColor = blockBorderColor
        
        avatarButton.layer.cornerRadius = 0.5 * avatarButton.bounds.size.width
        avatarButton.clipsToBounds = true
    }
    
    @IBAction func goToSignInPage(sender: AnyObject) {
    }

}
