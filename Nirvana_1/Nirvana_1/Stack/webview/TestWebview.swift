//
//  webview.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/4.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit

class TestWebViewController: UIViewController
{
    var web: UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = NSBundle.mainBundle().pathForResource("html", ofType: "data") {
            if let data = NSData(contentsOfFile: path) {
                web = UIWebView.init(frame: self.view.frame)
                web!.loadData(data, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: NSURL.init())
                self.view.addSubview(web!)
            }
        }
        
    }
    
}


