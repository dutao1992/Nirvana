//
//  SetStrokeColorCommand.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/21.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit
import QorumLogs

typealias RGBValuesProvider = (inout red:CGFloat, inout green:CGFloat, inout blue:CGFloat)->Void
typealias PostColorUpdateProvider = (UIColor)->Void

protocol SetStrokeColorCommandDelegate
{
    func command(command: SetStrokeColorCommand,
                 inout didRequestColorComponentsForRed:CGFloat,
                 inout green: CGFloat,
                 inout blue: CGFloat);
    
    func command(command: SetStrokeColorCommand,
                 didFinishColorUpdateWithColor: UIColor)
    
}

class SetStrokeColorCommand: Command
{
    var delegate: SetStrokeColorCommandDelegate?
    var rGBValuesProvider: RGBValuesProvider?
    var postColorUpdateProvider: PostColorUpdateProvider?
    
    override func execute() {
        var redValue:CGFloat = 0.0
        var greenValue:CGFloat = 0.0
        var blueValue:CGFloat = 0.0
        
        delegate!.command(self, didRequestColorComponentsForRed: &redValue, green: &greenValue, blue: &blueValue)
        
        rGBValuesProvider?(red: &redValue, green: &greenValue, blue: &blueValue)
        
        let color = UIColor.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        // Assign color in canvas view
        QL2("\(color)")
        
        delegate!.command(self, didFinishColorUpdateWithColor: color)
        
        postColorUpdateProvider?(color)
        
    }
}