//
//  WoDeShouCangViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeShouCangViewController: UIViewController {

    var touGaos:[TouGao] = []
    
    @IBOutlet weak var shouCangTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDecoration()
        
        let tougao = TouGao()
        tougao.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tougao.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        let author = User()
        author.name = "熊爸爸"
        author.avatarUrl = "http://www.bmw.ca/content/dam/bmw/common/all-models/3-series/sedan/2015/at-a-glance/3-series-m-sport-package-04.jpg/jcr:content/renditions/cq5dam.resized.img.485.low.time1447942782786.jpg"
        tougao.author = author
        tougao.likeNumber = "💜200"
        touGaos.append(tougao)
        
        let tougao1 = TouGao()
        tougao1.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tougao1.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        let author1 = User()
        author1.name = "潮妈小辣椒"
        author1.avatarUrl = "http://cdn.bmwblog.com/wp-content/uploads/BMW-10-750x500.jpg"
        tougao1.author = author
        tougao1.likeNumber = "💜87"
        touGaos.append(tougao1)
    }
    
    func initializeDecoration() {
        title = "我的收藏"
        
        shouCangTableView.delegate = self
        shouCangTableView.dataSource = self
        shouCangTableView.tableFooterView = UIView(frame: CGRectZero)
        shouCangTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
}

extension WoDeShouCangViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touGaos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! WoDeShouCangTableViewCell
        let touGao = touGaos[indexPath.row]
        cell.titleLabel.text = touGao.titleText
        cell.authorNameLabel.text = touGao.author.name
        cell.likeNumberLabel.text = touGao.likeNumber
        ImageUtil.loadImage(touGao.titleImageUrl, imageView: cell.titleImageView)
        ImageUtil.loadImage(touGao.author.avatarUrl, imageView: cell.authorAvatarImageView)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            touGaos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .Default, title: "取消收藏", handler: { (action, indexPath) in
            tableView.dataSource?.tableView?(
                tableView,
                commitEditingStyle: .Delete,
                forRowAtIndexPath: indexPath
            )
            return
        })
        
        deleteButton.backgroundColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0)
        
        return [deleteButton]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //        performSegueWithIdentifier(myListOptions[indexPath.row][2], sender: nil)
    }

}
