//
//  http_request.swift
//  Nirvana_1
//
//  Created by 田盛 on 16/9/4.
//  Copyright © 2016年 APL. All rights reserved.
//

import UIKit

import Alamofire
import QorumLogs

class HttpRequestControllerTest: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        get()
    }

    
    func get()
    {
        Alamofire.request(.GET, "http://localhost/test2.php", parameters: ["str":"getParam","num":123.1, "bool":true])
            .responseJSON {response in
                QL1(response.request!.URL!)
                //Optional(<NSMutableURLRequest: 0x7fe5d15469d0> { URL: http://localhost/test2.php?bool=1&num=123.1&str=getParam })
                do {
                    let dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.init(rawValue: 0))
                    if  ((dict as? [String:AnyObject]) != nil) {
                        let json = dict as! [String: AnyObject]
                        QL2(json["data"]!)
                    }
                }catch let error as NSError {
                    QL4(error)
                }
                QL2(response.result)    // SUCCESS
                QL3(response.response!.statusCode)
                QL1(response.timeline.totalDuration)
                QL1(response.description)
                QL1(response.debugDescription)
            }
    }
    
}