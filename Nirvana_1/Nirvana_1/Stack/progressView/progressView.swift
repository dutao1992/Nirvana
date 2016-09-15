//
//  progressView.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/15.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit

class TestProgressViewController: UIViewController
{
    var progress:Float = 0.0
    var timer: NSTimer?
    var progressView: UIProgressView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = UIProgressView(progressViewStyle: .Default)
        if let myProgressView = progressView {
            myProgressView.center = view.center
            
            myProgressView.progress = progress
            myProgressView.trackTintColor = UIColor.lightGrayColor()
            myProgressView.tintColor = UIColor.blueColor()
            view.addSubview(myProgressView)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(TestProgressViewController.run), userInfo: nil, repeats: true);
        }

    }
    func run() {
        progress += 0.001
        print("progress is \(progress)")
        if let theProgressView = progressView  {
            theProgressView.progress = progress
            if progress >= 1.0 {
                timer?.invalidate()
            }
        }
    }
    

}
