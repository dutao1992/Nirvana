//
//  button.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/15.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit

class TestButtonController: UIViewController
{
    var button: UIButton!
    var mainSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalImage = UIImage(named: "NormalBlueButton")
        let highlightedImage = UIImage(named: "HighlightedBluedButton")
        
        button = UIButton(type: .Custom)
        button.frame = CGRect(x: 110, y: 70, width: 100, height: 44)
        
        button.setTitle("Normal", forState: .Normal)
        button.setTitle("Pressed", forState: .Highlighted)
        
        button.setBackgroundImage(normalImage, forState: .Normal)
        button.setBackgroundImage(highlightedImage, forState: .Highlighted)
        
        button.addTarget(self, action: #selector(TestButtonController.buttonIsPressed(_:)), forControlEvents: .TouchDown)
        button.addTarget(self, action: #selector(TestButtonController.buttonIsTapped(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        mainSwitch = UISwitch(frame: CGRect(x: 100, y: 150, width: 0, height: 0))
        mainSwitch.tintColor = UIColor.redColor()
        mainSwitch.onTintColor = UIColor.brownColor()
        mainSwitch.thumbTintColor = UIColor.greenColor()
        mainSwitch.addTarget(self, action: #selector(TestButtonController.switchIsChanged(_:)), forControlEvents: .ValueChanged)
        view.addSubview(mainSwitch)
    }
    
    func buttonIsPressed(sender: UIButton) {
        print("Button is pressed down")
    }
    
    func buttonIsTapped(sender: UIButton) {
        print("Button is Tapped up")
    }
    
    func switchIsChanged(sender: UISwitch) {
        print("Sender is \(sender)")
        
        if sender.on{
            print("The switch is turned on")
        } else {
            print("The switch is turned off")
        }
        
    }
    
}
