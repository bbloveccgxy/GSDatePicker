//
//  ViewController.swift
//  GSDatePickerDemo
//
//  Created by gxy on 2017/3/20.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: UIButtonType.contactAdd)
        button.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonaction(_:)), for: UIControlEvents.touchUpInside)
        
    }
    
    @objc func buttonaction(_ button:UIButton) {
        let picker: GSDatePicker = GSDatePicker()
        picker.mode = .DateAndTime
        picker.startYear(2017).startMonth(1).startDay(1).startHour(1).startMinute(1)
        
        picker.show(completionClosure: {
            (dateString:String) in
            print(dateString)
            print("-----")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

