//
//  Command.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/21.
//  Copyright © 2016年 APL. All rights reserved.
//

import Foundation


class Command
{
    func execute() {
        // do nothing 
        // sub class need to override this
        preconditionFailure("This method must be overridden")
    }
    
    func undo() {
        preconditionFailure("This method must be overridden")
    }
}