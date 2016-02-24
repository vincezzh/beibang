//
//  WoDeGuanZhuViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeGuanZhuViewController: UIViewController {

    var users:[User] = []
    
    @IBOutlet weak var guanZhuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDecoration()
        
        let user1 = User()
        user1.avatarUrl = "http://www.akhaltech.com/img/profile.png"
        user1.name = "发现了什么好价"
        user1.followerNumber = "💜219"
        users.append(user1)
        
        let user2 = User()
        user2.avatarUrl = "http://www.akhaltech.com/img/profile.png"
        user2.name = "发现了什么好价"
        user2.followerNumber = "💜219"
        users.append(user2)
    }
    
    func initializeDecoration() {
        title = "我的关注"
        
        guanZhuTableView.delegate = self
        guanZhuTableView.dataSource = self
        guanZhuTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
}

extension WoDeGuanZhuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! WoDeGuanZhuTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.followerNumberLabel.text = user.followerNumber
        ImageUtil.loadImage(user.avatarUrl, imageView: cell.avatarImageView)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            users.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "取消关注"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("showUserDetailSegue", sender: nil)
    }

}
