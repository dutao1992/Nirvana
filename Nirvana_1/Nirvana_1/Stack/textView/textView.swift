//
//  textView.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/15.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit

class TestTextViewController: UIViewController {
    
    var myTextView: UITextView?
    
    let defaultContentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        myTextView = UITextView.init(frame: view.bounds)
        if let theTextView = myTextView {
            theTextView.text = "这里可以输入文字"
            theTextView.font = UIFont.systemFontOfSize(16)
            theTextView.contentInset = defaultContentInset
            theTextView.backgroundColor = UIColor.yellowColor()
            
            view.addSubview(theTextView)
            
            NSNotificationCenter.defaultCenter().addObserver(
                self,
                selector: #selector(TestTextViewController.handleKeyboardDidShow(_:)), name: UIKeyboardDidShowNotification,
                object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(
                self,
                selector: #selector(TestTextViewController.handleKeyboardWillHide(_:)),
                name: UIKeyboardDidHideNotification,
                object: nil)
            
        }
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func handleKeyboardDidShow(notification: NSNotification)
    {
        /* Get the frame of the keyboard, and place it in a CGRect */
        let keyborardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        var keyboardRect = CGRectZero
        keyborardRectAsObject.getValue(&keyboardRect)
        
        myTextView!.contentInset = UIEdgeInsets(top:defaultContentInset.top,
                                                left: 0,
                                                bottom:keyboardRect.height,
                                                right:0)
    }
    
    func handleKeyboardWillHide(notification: NSNotification)
    {
        myTextView!.contentInset = defaultContentInset
    }
}
