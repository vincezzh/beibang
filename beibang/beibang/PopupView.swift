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
    
    override func drawRect(rect: CGRect) {
        let wBounds = screenSize.width/2
        let hBounds = screenSize.height/2
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.frame = CGRectMake(0, 10, wBounds, hBounds-50)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.bounds.size.width * 3, height: hBounds/2)
        addSubview(scrollView)

        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: wBounds/2, y: hBounds - 20, width: 0, height: 0)
        pageControl.backgroundColor = UIColor.whiteColor()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        addSubview(pageControl)
        
        view1 = UIView()
        view1.backgroundColor = UIColor.greenColor()
        view1.frame = CGRectMake(0, 0, wBounds, hBounds)
        scrollView.addSubview(view1)
        scrollView.bringSubviewToFront(view1)
        
        //Notice the x position increases per number of views
        view2 = UIView()
        view2.backgroundColor = UIColor.redColor()
        view2.frame = CGRectMake(wBounds, 0, wBounds, hBounds)
        scrollView.addSubview(view2)
        scrollView.bringSubviewToFront(view2)
        
        //Notice the x position increases yet again (wBounds * 2)
        view3 = UIView()
        view3.backgroundColor = UIColor.blueColor()
        view3.frame = CGRectMake(wBounds * 2, 0, wBounds, hBounds)
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
