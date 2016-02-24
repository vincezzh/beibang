//
//  MyProfileViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-21.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    let myListOptions = [
        ["我的宝宝", "placeholder", "woDeBaoBaoSegue"],
        ["我的投稿", "placeholder", "woDeTouGaoSegue"],
        ["我的收藏", "placeholder", "woDeShouCangSegue"],
        ["我的关注", "placeholder", "woDeGuanZhuSegue"],
        ["账户安全", "placeholder", "zhangHuAnQuanSegue"],
        ["联系平台", "placeholder", "lianXiPingTaiSegue"]
    ]
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var myListTableView: UITableView!
    @IBOutlet weak var quitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
    }

    func initializeDecoration() {
        title = "我的"
        
        myListTableView.delegate = self
        myListTableView.dataSource = self
        myListTableView.tableFooterView = UIView(frame: CGRectZero)
        
        avatarImageView.layer.cornerRadius = 0.5 * avatarImageView.bounds.size.width
        avatarImageView.clipsToBounds = true
        
        quitButton.layer.cornerRadius = 5
    }
}

extension MyProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myListOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MyProfileTableViewCell
        cell.titleLabel.text = myListOptions[indexPath.row][0]
        cell.titleImageView.image = UIImage(named: myListOptions[indexPath.row][1])

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myListTableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier(myListOptions[indexPath.row][2], sender: nil)
    }
}