//
//  ChaoZhiView.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-26.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ChaoZhiView: UIView {
    
    var touGaos: [TouGao] = []
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    class func instanceFromNib() -> ChaoZhiView {
        return NSBundle.mainBundle().loadNibNamed("ChaoZhiView", owner: self, options: nil).first as! ChaoZhiView
    }

    override func drawRect(rect: CGRect) {
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.tableFooterView = UIView(frame: CGRectZero)
    }

}

extension ChaoZhiView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touGaos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("titleCell") as? ArticleTitleCell
        if cell == nil {
            tableView.registerNib(UINib(nibName: "ArticleTitleCell", bundle: nil), forCellReuseIdentifier: "titleCell")
            cell = tableView.dequeueReusableCellWithIdentifier("titleCell") as? ArticleTitleCell
        }
        cell!.initializeData(touGaos[indexPath.row])
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        performSegueWithIdentifier(myListOptions[indexPath.row][2], sender: nil)
    }
}
