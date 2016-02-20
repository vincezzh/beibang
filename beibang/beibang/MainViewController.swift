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
    @IBOutlet weak var touGaoTableView: UITableView!

    var popoverVC: TouGaoPopupButtonsViewController = TouGaoPopupButtonsViewController()
    var touGaoType = ""
    var touGaos: [TouGao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDecoration()
        
        touGaoTableView.delegate = self
        touGaoTableView.dataSource = self
        
        let tg1 = TouGao()
        tg1.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tg1.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        touGaos.append(tg1)
        
        let tg2 = TouGao()
        tg2.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tg2.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        touGaos.append(tg2)
        
        let tg3 = TouGao()
        tg3.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tg3.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        touGaos.append(tg3)
        
        let tg4 = TouGao()
        tg4.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tg4.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        touGaos.append(tg4)
        
        let tg5 = TouGao()
        tg5.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tg5.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        touGaos.append(tg5)
    }
    
    func initializeDecoration() {
        touGaoTableView.layer.cornerRadius = 5
        touGaoTableView.tableFooterView = UIView(frame: CGRectZero)
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

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touGaos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }else {
            return 70
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("topCell") as! MainViewTopCell
            cell.titleTextView.text = touGaos[indexPath.row].titleText
            loadImage(touGaos[indexPath.row].titleImageUrl, imageView: cell.titleImageView)
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("followingCell") as! MainViewFollowingCell
            cell.titleTextView.text = touGaos[indexPath.row].titleText
            loadImage(touGaos[indexPath.row].titleImageUrl, imageView: cell.titleImageView)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            touGaos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    func loadImage(url: String, imageView: UIImageView) {
        let session = NSURLSession.sharedSession()
        let imgURL: NSURL = NSURL(string: url)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let imageTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                imageView.image = UIImage(data: data!)
            }
        })
        imageTask.resume()
    }
}

