//
//  webview.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/4.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit
import WebKit

class TestWebViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate
{
    var web: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let originY = UIApplication.sharedApplication().statusBarFrame.height
        let height = (view.frame.height - originY) / 3.0 as CGFloat
        let frame1 = CGRect(x: 0, y: originY, width: view.frame.size.width, height: height)
        let frame2 = CGRect(x: 0, y: frame1.maxY, width: view.frame.size.width, height: height)
        let frame3 = CGRect(x: 0, y: frame2.maxY, width: view.frame.size.width, height: height)
        if let path = NSBundle.mainBundle().pathForResource("html", ofType: "data") {
            if let data = NSData(contentsOfFile: path) {
                web = UIWebView.init(frame: frame1)
                web!.loadData(data, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: NSURL.init())
                self.view.addSubview(web!)
            }
        }
        
        let web2 = UIWebView(frame: frame2)
        web2.delegate = self
        web2.scalesPageToFit = true;
        
        let url = NSURL(string: "http://www.apple.com")
        let request = NSURLRequest(URL: url!)
        web2.loadRequest(request)
        
        view.addSubview(web2)
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = false
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let web3 = WKWebView(frame: frame3, configuration: configuration)
        web3.loadRequest(request)
        web3.navigationDelegate = self
        view.addSubview(web3)
        
    }

    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWidthError error: NSError?) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        print(navigationResponse.response.MIMEType)
        decisionHandler(.Allow)
    }
    
}


