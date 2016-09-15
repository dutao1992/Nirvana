//
//  segmentedControl.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/15.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit


class TestSegmentedControlViewController: UIViewController
{
    lazy var mySegmentedControl: UISegmentedControl = {
        let segments = [
            "Red",
            UIImage(named: "blueDot")!,
            "Green",
            "Yellow",
            ]
        
        let segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.center = self.view.center
        segmentedControl.momentary = true
        segmentedControl.addTarget(self, action: #selector(TestSegmentedControlViewController.segmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        return segmentedControl
    }()
    
    lazy var mySlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 23))
        slider.center = CGPointMake(self.view.center.x, self.view.center.y-100)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = slider.maximumValue / 2.0
        
        slider.setThumbImage(UIImage(named: "ThumbNormal"), forState: .Normal)
        slider.setThumbImage(UIImage(named: "ThumbHighlighted"), forState: .Highlighted)
        slider.addTarget(self, action: #selector(TestSegmentedControlViewController.sliderValueChanged(_:)), forControlEvents: .ValueChanged)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mySegmentedControl)
        view.addSubview(mySlider)
    }
    
    
    func segmentedControlValueChanged(sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        let selectedSegmentText = sender.titleForSegmentAtIndex(selectedSegmentIndex)
        
        print("Segment \(selectedSegmentIndex) with text" +
            " of \(selectedSegmentText) is selected")
    }
    
    func sliderValueChanged(sender: UISlider) {
        print("Slider`s new value is \(sender.value)")
    }
    
}