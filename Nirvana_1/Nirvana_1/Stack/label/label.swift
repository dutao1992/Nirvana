//
//  label.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/15.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit

class TestLabelViewController: UIViewController {
    
    var label: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.attributedText = attributedText()
        label.sizeToFit()
        label.center = CGPoint(x: view.center.x, y: 100)
        view.addSubview(label)
    }
    
    func attributedText() ->NSAttributedString {
        let string = "iOS SDK" as NSString
        let result = NSMutableAttributedString(string: String(string))
        
        let attributesForFirstWord = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(60),
            NSForegroundColorAttributeName: UIColor.redColor(),
            NSBackgroundColorAttributeName: UIColor.blackColor()
        ]
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGrayColor()
        shadow.shadowOffset = CGSize(width: 4, height:6)
        
        let attributesForSecondWord = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(60),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSBackgroundColorAttributeName: UIColor.redColor(),
            NSShadowAttributeName: shadow,
        ]
        
        result.setAttributes(attributesForFirstWord, range: string.rangeOfString("iOS"))
        result.setAttributes(attributesForSecondWord, range: string.rangeOfString("SDK"))
        
        return NSAttributedString(attributedString: result)
    }
}
