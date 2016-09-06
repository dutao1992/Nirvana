//
//  navigationBars.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/7.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit
import QorumLogs

class TestNavigationBarsController: UIViewController
{
    let items = ["Up", "Down"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var barButtonItems = [UIBarButtonItem]()
        
        barButtonItems.append(UIBarButtonItem( title: "Add", style: .Plain, target: self, action: #selector(self.performAdd(_:))
//            action: #selector(TestNavigationBarsController.performAdd(_:))       // 二者区别在哪？
        ))
        
        barButtonItems.append(UIBarButtonItem.init(barButtonSystemItem: .Add, target: self, action: #selector(self.performAdd(_:))))
        let aSwitch = UISwitch.init()
        aSwitch.on = true
        aSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), forControlEvents: .ValueChanged)
        barButtonItems.append(UIBarButtonItem.init(customView: aSwitch))
        
        let aSegmentedControl = UISegmentedControl(items: items)
        aSegmentedControl.momentary = true;
        aSegmentedControl.addTarget(self, action: #selector(self.segmentedControlTapped(_:)), forControlEvents: .ValueChanged)
        barButtonItems.append(UIBarButtonItem(customView: aSegmentedControl))
        
        navigationItem.setRightBarButtonItems(barButtonItems, animated: true)
        
    }
    
    func performAdd(sender: UIBarButtonItem) {
        QL1("Add button tapped");
    }
    
    func switchChanged(sender: UISwitch) {
        if sender.on {
            QL2("Switch is on")
        } else {
            QL2("Switch is off")
        }
    }
    
    func segmentedControlTapped(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex < items.count {
            QL2(items[sender.selectedSegmentIndex])
        } else {
            QL4("Unknown button is pressed")
        }
    }
    
}
