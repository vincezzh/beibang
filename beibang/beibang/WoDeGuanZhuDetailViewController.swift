//
//  WoDeGuanZhuDetailViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-23.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeGuanZhuDetailViewController: UIViewController {
    
    var user: User!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var touGaoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let user1 = User()
        user1.avatarUrl = "http://www.akhaltech.com/img/profile.png"
        user1.name = "Eason妈妈"
        user1.followerNumber = "💜219"
        
        let tougao = TouGao()
        tougao.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tougao.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        tougao.likeNumber = "💜200"
        user1.touGaos.append(tougao)
        
        let tougao1 = TouGao()
        tougao1.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tougao1.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        tougao1.likeNumber = "💜87"
        user1.touGaos.append(tougao1)
        
        user = user1
        
        initializeDecoration()
    }
    
    func initializeDecoration() {
        title = user.name
        nameLabel.text = user.name
        followerNumberLabel.text = user.followerNumber
        ImageUtil.loadImage(user.avatarUrl, imageView: avatarImageView)
        
        avatarImageView.layer.cornerRadius = 0.5 * avatarImageView.bounds.size.width
        avatarImageView.clipsToBounds = true
        
        touGaoTableView.delegate = self
        touGaoTableView.dataSource = self
        touGaoTableView.tableFooterView = UIView(frame: CGRectZero)
        touGaoTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

}

extension WoDeGuanZhuDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.touGaos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! WoDeShouCangTableViewCell
        let touGao = user.touGaos[indexPath.row]
        cell.titleLabel.text = touGao.titleText
        cell.authorNameLabel.text = user.name
        cell.likeNumberLabel.text = touGao.likeNumber
        ImageUtil.loadImage(touGao.titleImageUrl, imageView: cell.titleImageView)
        ImageUtil.loadImage(user.avatarUrl, imageView: cell.authorAvatarImageView)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //        performSegueWithIdentifier(myListOptions[indexPath.row][2], sender: nil)
    }
    
}
