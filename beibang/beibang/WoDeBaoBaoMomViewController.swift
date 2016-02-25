//
//  WoDeBaoBaoMomViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-24.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeBaoBaoMomViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oneBabyView: UIView!
    @IBOutlet weak var oneBabyAgeLabel: UILabel!
    @IBOutlet weak var oneBabyNameLabel: UILabel!
    @IBOutlet weak var twoBabiesView: UIView!
    @IBOutlet weak var twoBabiesFirstNameLabel: UILabel!
    @IBOutlet weak var twoBabiesFirstAgeLabel: UILabel!
    @IBOutlet weak var twoBabiesSecondNameLabel: UILabel!
    @IBOutlet weak var twoBabiesSecondAgeLabel: UILabel!
    
    @IBOutlet weak var setBabyMainPageInStatusViewButton: UIButton!
    @IBOutlet weak var updateStatusView: UIView!
    @IBOutlet weak var updateStatusButton: UIButton!
    @IBOutlet weak var updateFirstBabyButton: UIButton!
    @IBOutlet weak var updateFirstBabyLabel: UILabel!
    @IBOutlet weak var beingPregnentSecondButton: UIButton!
    @IBOutlet weak var beingPregnentSecondLabel: UILabel!
    @IBOutlet weak var hasBeenMomSecondButton: UIButton!
    @IBOutlet weak var hasBeenMomSecondLabel: UILabel!
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
        oneBabyView.alpha = 0
        
        setBabyMainPageInStatusViewButton.layer.cornerRadius = 5
        updateStatusButton.layer.cornerRadius = 5
        updateFirstBabyButton.layer.cornerRadius = 0.5 * updateFirstBabyButton.bounds.size.width
        updateFirstBabyButton.clipsToBounds = true
        updateFirstBabyButton.alpha = 0
        updateFirstBabyLabel.alpha = 0
        beingPregnentSecondButton.layer.cornerRadius = 0.5 * beingPregnentSecondButton.bounds.size.width
        beingPregnentSecondButton.clipsToBounds = true
        beingPregnentSecondButton.alpha = 0
        beingPregnentSecondLabel.alpha = 0
        hasBeenMomSecondButton.layer.cornerRadius = 0.5 * hasBeenMomSecondButton.bounds.size.width
        hasBeenMomSecondButton.clipsToBounds = true
        hasBeenMomSecondButton.alpha = 0
        hasBeenMomSecondLabel.alpha = 0
        
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
            self.updateFirstBabyButton.alpha = 1
            self.updateFirstBabyLabel.alpha = 1
            self.beingPregnentSecondButton.alpha = 1
            self.beingPregnentSecondLabel.alpha = 1
            self.hasBeenMomSecondButton.alpha = 1
            self.hasBeenMomSecondLabel.alpha = 1
            self.setBabyMainPageInStatusViewButton.alpha = 0
            self.updateStatusButton.alpha = 0
            }, completion: nil)
    }
    
    @IBAction func clickBeingPregnentSecondButton(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.updateStatusViewBottomConstraint.constant = -220
            self.view.layoutIfNeeded()
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.beMomDateViewBottomConstraint.constant = 31
                    self.view.layoutIfNeeded()
                    }, completion: nil)
        }
    }
    
    @IBAction func clickUpdateFirstBabyButton(sender: AnyObject) {
        displayBabyDetailWindow()
    }
    
    @IBAction func clickHasBeenMomSecondButton(sender: AnyObject) {
        displayBabyDetailWindow()
    }

    func displayBabyDetailWindow() {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.updateStatusViewBottomConstraint.constant = -220
            self.view.layoutIfNeeded()
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.hasBeenMomViewBottomConstraint.constant = 31
                    self.view.layoutIfNeeded()
                    }, completion: nil)
        }
    }

}
