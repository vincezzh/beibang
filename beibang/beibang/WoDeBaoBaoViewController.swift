//
//  WoDeBaoBaoViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeBaoBaoViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentStatusLabel: UILabel!
    
    @IBOutlet weak var updateStatusView: UIView!
    @IBOutlet weak var updateStatusButton: UIButton!
    @IBOutlet weak var beingPregnentButton: UIButton!
    @IBOutlet weak var beingPregnentLabel: UILabel!
    @IBOutlet weak var hasBeenMomButton: UIButton!
    @IBOutlet weak var hasBeenMomLabel: UILabel!
    @IBOutlet weak var updateStatusViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var beMomDateView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var beMomDateTextField: UITextField!
    @IBOutlet weak var beMomDateViewBottomConstraint: NSLayoutConstraint!
    
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
        beingPregnentButton.layer.cornerRadius = 0.5 * beingPregnentButton.bounds.size.width
        beingPregnentButton.clipsToBounds = true
        beingPregnentButton.alpha = 0
        beingPregnentLabel.alpha = 0
        hasBeenMomButton.layer.cornerRadius = 0.5 * hasBeenMomButton.bounds.size.width
        hasBeenMomButton.clipsToBounds = true
        hasBeenMomButton.alpha = 0
        hasBeenMomLabel.alpha = 0
        
        confirmButton.layer.cornerRadius = 5
        beMomDateTextField.layer.cornerRadius = 5
        
        hasBeenMomConfirmButton.layer.cornerRadius = 5
        babyNameTextField.layer.cornerRadius = 5
        babyBDayTextField.layer.cornerRadius = 5
        babySexSegment.layer.cornerRadius = 5
        setBabyMainPageButton.layer.cornerRadius = 5
    }
    
    @IBAction func clickUpdateStatusButton(sender: AnyObject) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.beingPregnentButton.alpha = 1
            self.beingPregnentLabel.alpha = 1
            self.hasBeenMomButton.alpha = 1
            self.hasBeenMomLabel.alpha = 1
            self.updateStatusButton.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func clickBeingPregnentButton(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.updateStatusViewBottomConstraint.constant = -200
                self.view.layoutIfNeeded()
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.beMomDateViewBottomConstraint.constant = 31
                    self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    @IBAction func clickHasBeenMomButton(sender: AnyObject) {
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
