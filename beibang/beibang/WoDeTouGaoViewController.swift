//
//  WoDeTouGaoViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeTouGaoViewController: UIViewController {
    
    var touGaos:[TouGao] = []

    @IBOutlet weak var touGaoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
        
        let tougao = TouGao()
        tougao.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tougao.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        tougao.postDateString = "2016/02/29"
        touGaos.append(tougao)
        
        let tougao1 = TouGao()
        tougao1.titleImageUrl = "http://www.akhaltech.com/img/profile.png"
        tougao1.titleText = "发现了什么好价格和不能错过的优惠活动？赶快在这里推荐给各位爸爸妈妈们吧！"
        tougao1.postDateString = "2016/02/29"
        touGaos.append(tougao1)
    }
    
    func initializeDecoration() {
        title = "我的投稿"
        
        touGaoTableView.delegate = self
        touGaoTableView.dataSource = self
        touGaoTableView.tableFooterView = UIView(frame: CGRectZero)
        touGaoTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

}

extension WoDeTouGaoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touGaos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! WoDeTouGaoTableViewCell
        let touGao = touGaos[indexPath.row]
        cell.titleLabel.text = touGao.titleText
        cell.postDateLabel.text = touGao.postDateString
        cell.statusLabel.text = "已发布"
        cell.statusImageView.image = UIImage(named: "placeholder")
        ImageUtil.loadImage(touGao.titleImageUrl, imageView: cell.titleImageView)
        
        return cell
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        performSegueWithIdentifier(myListOptions[indexPath.row][2], sender: nil)
    }
}
