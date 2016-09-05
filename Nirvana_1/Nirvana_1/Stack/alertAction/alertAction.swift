//
//  alertAction.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/5.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit
import QorumLogs

class TestAlertActionController: UIViewController
{
    lazy var alertController: UIAlertController = {
        var controller = UIAlertController(title: "title", message: "long long Message", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Done", style: .Default, handler: {
            [weak self] (paramAction: UIAlertAction) in
            
            if let textFields = self?.alertController.textFields {
                let theTextFileds = textFields as [UITextField]
                let userName = theTextFileds[0].text
                QL1("Your username is \(userName)")
                self!.presentViewController(self!.actionController, animated: true, completion: nil)
            }
            })
        controller.addTextFieldWithConfigurationHandler({ (paramTextFiled: UITextField) in
            paramTextFiled.placeholder = "XXXXX"
        })
        controller.addAction(action)
        return controller
    }()
    
    lazy var actionController: UIAlertController = {
        
            let controller = UIAlertController.init(title: "Choose one", message: " haha", preferredStyle: .ActionSheet)
            let actionEmail = UIAlertAction.init(title: "Email", style: .Default) {
                (paramAction: UIAlertAction!) in
                QL2("Email")
            }
            let actionIMessage = UIAlertAction(title: "iMessage",
                                               style: .Default,
                                               handler: {(paramAction: UIAlertAction!) in QL2("iMessage")})
            controller.addAction(actionEmail)
            controller.addAction(actionIMessage)
        
        return controller;

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}