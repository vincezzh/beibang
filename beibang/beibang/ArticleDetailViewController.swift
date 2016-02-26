//
//  ArticleDetailViewController.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-26.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    var touGao: TouGao!

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func initializeDecoration() {
        title = touGao.titleText
        
        let button = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
        self.navigationItem.leftBarButtonItem = button
    }
    
    func goBack() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.popViewControllerAnimated(true)
    }

}
