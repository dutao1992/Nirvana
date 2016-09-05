//
//  JsonFromFile.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/4.
//  Copyright © 2016年 APL. All rights reserved.
//

import Foundation
import UIKit
import QorumLogs

class TestJsonFromFileController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()

        JsonFromFile.test()

    }
    
}

class JsonFromFile {
    
    static func test() {
        let url = NSBundle.mainBundle().URLForResource("0700", withExtension: "json")
        QL1(url)
        
        let data = NSData(contentsOfURL: url!)!
        var error:NSError?
        let result: AnyObject?
        do {
            result = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        } catch let error1 as NSError {
            error = error1
            result = nil
        }
        print(result?.dynamicType)
        if result != nil
        {
            let json = result as! [String:AnyObject]
            QL2(json)
        }
    }
    
    
}