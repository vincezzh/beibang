//
//  ImageUtil.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ImageUtil {
    class func loadImage(url: String, imageView: UIImageView) {
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
    
    class func loadImage(url: String, button: UIButton) {
        let session = NSURLSession.sharedSession()
        let imgURL: NSURL = NSURL(string: url)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let imageTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                button.setImage(UIImage(data: data!), forState: UIControlState.Normal)
            }
        })
        imageTask.resume()
    }
}