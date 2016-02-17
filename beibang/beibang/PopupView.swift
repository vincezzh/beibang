//
//  PopupView.swift
//  CustomPopupView
//
//  Created by Zaid Pathan on 20/04/15.
//  Copyright (c) 2015 ZaidPathan. All rights reserved.
//

import UIKit

class PopupView: UIView, UIScrollViewDelegate {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var scrollView:UIScrollView!
    var pageControl:UIPageControl!
    var view1:UIView!
    var view2:UIView!
    var view3:UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func drawRect(rect: CGRect) {
        closeButton.layer.zPosition = 100
        
        let wBounds = screenSize.width/2
        let hBounds = screenSize.height/2
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.frame = CGRectMake(0, 10, wBounds-10, hBounds-10)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.bounds.size.width * 3, height: hBounds/2)
        scrollView.layer.zPosition = 1
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0).CGColor
        scrollView.layer.cornerRadius = 5
        addSubview(scrollView)

        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: wBounds/2-5, y: hBounds - 20, width: 0, height: 0)
        pageControl.backgroundColor = UIColor.whiteColor()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.layer.zPosition = 100
        addSubview(pageControl)
        
        view1 = UIView()
        view1.backgroundColor = UIColor.whiteColor()
        view1.frame = CGRectMake(0, 0, wBounds-10, hBounds-10)
        let image1 = UIImageView(image: UIImage(named: "placeholder"))
        image1.frame = CGRectMake(wBounds/2-55, 30, 100, 100)
        view1.addSubview(image1)
        let textView1 = UITextView(frame: CGRectMake(wBounds/2-105, 150, 200, 200))
        textView1.text = "陪伴宝宝成长的每个瞬间，\n也都会涉及到消费的方方面面。\n一次愉快的亲子活动，一次令人难忘的旅行，\n不同的生命轨迹会让你找到无数有\n共鸣的爸爸妈妈。"
        textView1.textAlignment = NSTextAlignment.Center
        view1.addSubview(textView1)
        scrollView.addSubview(view1)
        scrollView.bringSubviewToFront(view1)
        
        //Notice the x position increases per number of views
        view2 = UIView()
        view2.backgroundColor = UIColor.whiteColor()
        view2.frame = CGRectMake(wBounds-10, 0, wBounds-10, hBounds-10)
        let image2 = UIImageView(image: UIImage(named: "placeholder"))
        image2.frame = CGRectMake(wBounds/2-55, 30, 100, 100)
        view2.addSubview(image2)
        let textView2 = UITextView(frame: CGRectMake(wBounds/2-105, 150, 200, 200))
        textView2.text = "陪伴宝宝成长的每个瞬间，\n也都会涉及到消费的方方面面。\n一次愉快的亲子活动，一次令人难忘的旅行，\n不同的生命轨迹会让你找到无数有\n共鸣的爸爸妈妈。"
        textView2.textAlignment = NSTextAlignment.Center
        view2.addSubview(textView2)
        scrollView.addSubview(view2)
        scrollView.bringSubviewToFront(view2)
        
        //Notice the x position increases yet again (wBounds * 2)
        view3 = UIView()
        view3.backgroundColor = UIColor.whiteColor()
        view3.frame = CGRectMake((wBounds-10) * 2, 0, wBounds-10, hBounds-10)
        let image3 = UIImageView(image: UIImage(named: "placeholder"))
        image3.frame = CGRectMake(wBounds/2-55, 30, 100, 100)
        view3.addSubview(image3)
        let textView3 = UITextView(frame: CGRectMake(wBounds/2-105, 150, 200, 200))
        textView3.text = "陪伴宝宝成长的每个瞬间，\n也都会涉及到消费的方方面面。\n一次愉快的亲子活动，一次令人难忘的旅行，\n不同的生命轨迹会让你找到无数有\n共鸣的爸爸妈妈。"
        textView3.textAlignment = NSTextAlignment.Center
        view3.addSubview(textView3)
        scrollView.addSubview(view3)
        scrollView.bringSubviewToFront(view3)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let xOffset: CGFloat = scrollView.contentOffset.x
        
        //Change the pageControl dots depending on the page / offset values
        if (xOffset < 1.0) {
            pageControl.currentPage = 0
        } else if (xOffset < self.bounds.width + 1) {
            pageControl.currentPage = 1
        } else {
            pageControl.currentPage = 2
        }
        
    }

}
