//
//  File.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/15.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit

class TestScrollView: UIViewController, UIScrollViewDelegate
{
    var myImageView: UIImageView!
    var myScrollView: UIScrollView!
    let myImage = UIImage(named: "Safari")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: 200, height: 200)
        
        myImageView = UIImageView(image: myImage)
        blurView.center = view.center
        myImageView.addSubview(blurView)
        
        myScrollView = UIScrollView(frame: view.bounds)
        
        myScrollView.addSubview(myImageView)
        myScrollView.contentSize = myImageView.bounds.size
        myScrollView.delegate = self
        myScrollView.indicatorStyle = .White
        view.addSubview(myScrollView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.alpha = 0.5
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        myScrollView.alpha = 1
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        myScrollView.alpha = 1
    }
    
    
    
    
}
