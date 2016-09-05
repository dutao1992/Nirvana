//
//  TextfieldText.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/4.
//  Copyright © 2016年 APL. All rights reserved.
//


import UIKit
import QorumLogs

class TestTextFieldController: UIViewController, UITextFieldDelegate
{
    var textField: UITextField?
    var descLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = UITextField.init(frame: CGRectMake(38, 30, 2220, 31))
        textField!.delegate = self
        textField!.borderStyle = .RoundedRect
        textField!.contentVerticalAlignment = .Center
        textField!.text = " 哈哈哈"
        
        let currencyLabel = UILabel.init(frame: CGRectZero)
        currencyLabel.text = NSNumberFormatter.init().currencySymbol
        currencyLabel.font = textField?.font
        currencyLabel.textAlignment = .Right
        currencyLabel.sizeToFit()
        currencyLabel.frame.size.width += 10
        textField!.leftView = currencyLabel
        textField!.leftViewMode = .Always
        view.addSubview(textField!)
        
        descLabel = UILabel.init(frame: CGRect.init(x: 38, y: 61, width: 220, height: 31))
        view.addSubview(descLabel!)
        calculateAndDisplayTextFieldLengthWithText(textField!.text!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(paramTextField: UITextField,
      shouldChangeCharactersInRange range: NSRange,
      replacementString string: String)
      ->Bool
    {
        guard let textFieldText = paramTextField.text else{
            return false
        }
        
        let text = NSString.init(string: textFieldText)
        
        let wholeText = text.stringByReplacingCharactersInRange(range, withString: string)
        
        calculateAndDisplayTextFieldLengthWithText(wholeText)
        QL2(wholeText)
        
        return true
    }
    
    func calculateAndDisplayTextFieldLengthWithText(text: String) {
        
        var unitDesc = "Character"
        let textLength = text.characters.count
        
        unitDesc += textLength != 1 ? "s" : ""
        descLabel!.text = "\(textLength) \(unitDesc)"
        QL2(textLength)
    }
    
    
    
}