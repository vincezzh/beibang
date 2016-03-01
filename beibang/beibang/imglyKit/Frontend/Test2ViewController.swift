//
//  Test2ViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-29.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class Test2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func clickTestButton(sender: AnyObject) {
        
        let editorViewController = IMGLYMainEditorViewController()
        editorViewController.highResolutionImage = UIImage(named: "test")
        editorViewController.initialFilterType = .None
        editorViewController.initialFilterIntensity = 0.5
        editorViewController.completionBlock = editorCompletionBlock
        
        let navigationController = IMGLYNavigationController(rootViewController: editorViewController)
        navigationController.navigationBar.barStyle = .Black
        navigationController.navigationBar.translucent = false
        navigationController.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.whiteColor() ]
        
        presentViewController(navigationController, animated: true, completion: nil)
        
    }
    
    func editorCompletionBlock(result: IMGLYEditorResult, image: UIImage?) {
        print("done")
    }
}
