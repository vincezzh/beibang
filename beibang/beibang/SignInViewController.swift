//
//  SignInViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-08.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var block1View: UIView!
    @IBOutlet weak var block2View: UIView!
    @IBOutlet weak var block3View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blockBorderColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0).CGColor
        block1View.layer.borderWidth = 1
        block1View.layer.borderColor = blockBorderColor
        block2View.layer.borderWidth = 1
        block2View.layer.borderColor = blockBorderColor
        block3View.layer.borderWidth = 1
        block3View.layer.borderColor = blockBorderColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
