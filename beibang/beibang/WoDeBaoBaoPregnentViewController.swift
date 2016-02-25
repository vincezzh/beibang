//
//  WoDeBaoBaoPregnentViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-24.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeBaoBaoPregnentViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var willBeBornLabel: UILabel!
    @IBOutlet weak var willBeBornDateLabel: UILabel!
    
    @IBOutlet weak var updateStatusView: UIView!
    @IBOutlet weak var updateStatusButton: UIButton!
    @IBOutlet weak var updateStatusViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var hasBeenMomView: UIView!
    @IBOutlet weak var hasBeenMomConfirmButton: UIButton!
    @IBOutlet weak var babyNameTextField: UITextField!
    @IBOutlet weak var babyBDayTextField: UITextField!
    @IBOutlet weak var babySexSegment: UISegmentedControl!
    @IBOutlet weak var setBabyMainPageButton: UIButton!
    @IBOutlet weak var hasBeenMomViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
    }
    
    func initializeDecoration() {
        title = "我的宝宝"
        
        avatarImageView.layer.cornerRadius = 0.5 * avatarImageView.bounds.size.width
        avatarImageView.clipsToBounds = true
        
        updateStatusButton.layer.cornerRadius = 5
        
        hasBeenMomConfirmButton.layer.cornerRadius = 5
        babyNameTextField.layer.cornerRadius = 5
        babyBDayTextField.layer.cornerRadius = 5
        babySexSegment.layer.cornerRadius = 5
        setBabyMainPageButton.layer.cornerRadius = 5
    }
    
    @IBAction func clickUpdateStatusButton(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.updateStatusViewBottomConstraint.constant = -200
            self.view.layoutIfNeeded()
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.hasBeenMomViewBottomConstraint.constant = 31
                    self.view.layoutIfNeeded()
                    }, completion: nil)
        }
    }
    
    
    
    
    
    

}
