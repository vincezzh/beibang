//
//  ViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-08.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var toolbar: UIToolbar!

    var popoverVC: TouGaoPopupButtonsViewController = TouGaoPopupButtonsViewController()
    var touGaoType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }

    @IBAction func clickTouGaoBarButton(sender: AnyObject) {
        popoverVC = storyboard?.instantiateViewControllerWithIdentifier("touGaoButtonsPopover") as! TouGaoPopupButtonsViewController
        popoverVC.modalPresentationStyle = .Popover
        popoverVC.preferredContentSize = CGSizeMake(80, 160)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = toolbar
            popoverController.sourceRect = toolbar.bounds
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.Any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        presentViewController(popoverVC, animated: true, completion: nil)
    }
    
    func setTouGaoTypeAndPerformSegue(type: String) {
        popoverVC.dismissViewControllerAnimated(true, completion: nil)
        
        touGaoType = type
        if type == "超值爆料" {
            performSegueWithIdentifier("chaoZhiBaoLiaoSegue", sender: nil)
        }else {
            performSegueWithIdentifier("touGaoSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "touGaoSegue" {
            let viewController = segue.destinationViewController as! TouGaoEditorViewController
            viewController.touGaoType = touGaoType
        }
    }

}

