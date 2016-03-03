//
//  TestViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-03-02.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func test(sender: AnyObject) {
        performSegueWithIdentifier("displayPictureEditorSegue", sender: nil)
    }
    
    func doPicturesWithData(images: [UIImage]) {
        if images.count > 0 {
            for index in 0...images.count-1 {
                print(images[index])
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "displayPictureEditorSegue" {
            if let viewController = segue.destinationViewController as? PictureListViewController {
                viewController.onDataAvailable = {[weak self]
                    (data) in
                    if let weakSelf = self {
                        weakSelf.doPicturesWithData(data)
                    }
                }
            }
        }
    }
    

}
