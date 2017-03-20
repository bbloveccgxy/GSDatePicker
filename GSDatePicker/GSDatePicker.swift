//
//  GSDatePicker.swift
//  GSDatePickerDemo
//
//  Created by gxy on 2017/3/20.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import UIKit

class GSDatePicker: UIControl {
    
    var mode : GSDatePickerMode = .Date {
        willSet {
            switch newValue {
            case .Date:
                self.picker.datePickerMode = UIDatePickerMode.date
                formatter = "YYYY-M-d"
            case .DateAndTime:
                self.picker.datePickerMode = UIDatePickerMode.dateAndTime
                formatter = "YYYY-M-d H:mm"
            case .Time:
                self.picker.datePickerMode = UIDatePickerMode.time
                formatter = "HH:mm aa"
            }
        }
    }
    
    /// add the picker to the window
    ///
    /// - Parameter completionClosure: return the selected date string
    func show(completionClosure: @escaping (_ dateString : String) -> Void) {
        self.completion = completionClosure
        
        self.setStartDateIfNeeded()
        self.setEndDateIfNeeded()

        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let appDelegate = UIApplication.shared.delegate!
        appDelegate.window!?.addSubview(self)
        
        UIView.animate(withDuration: 0.3, animations: {
            [unowned self] in
            self.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
        })
    }
    
    //private
    fileprivate var completion:((_ dateString : String) -> Void)? = nil
    fileprivate var formatter : String = "YYYY-M-d"
    
    //视图相关
    fileprivate let screenWidth:CGFloat = UIScreen.main.bounds.size.width
    fileprivate let screenHeight:CGFloat = UIScreen.main.bounds.size.height
    
    fileprivate let cancelButton : UIButton = UIButton(type: UIButtonType.custom)
    fileprivate let okButton : UIButton = UIButton(type: UIButtonType.custom)
    fileprivate let picker : UIDatePicker = UIDatePicker()
    
    //lazy date data
    fileprivate lazy var start_year:Int = 0
    fileprivate lazy var start_month:Int = 0
    fileprivate lazy var start_day:Int = 0
    fileprivate lazy var start_hour:Int = 0
    fileprivate lazy var start_minute:Int = 0
    fileprivate lazy var end_year:Int = 0
    fileprivate lazy var end_month:Int = 0
    fileprivate lazy var end_day:Int = 0
    fileprivate lazy var end_hour:Int = 0
    fileprivate lazy var end_minute:Int = 0
    
    typealias DateClosure = (Int) -> GSDatePicker
    
    lazy var startYear: DateClosure = {
        [unowned self]
        number in
        self.start_year = number
        return self
    }
    
    lazy var startMonth: DateClosure = {
        [unowned self]
        number in
        self.start_month = number
        return self
    }
    
    lazy var startDay: DateClosure = {
        [unowned self]
        number in
        self.start_day = number
        return self
    }
    
    lazy var startHour: DateClosure = {
        [unowned self]
        number in
        self.start_hour = number
        return self
    }
    
    lazy var startMinute: DateClosure = {
        [unowned self]
        number in
        self.start_minute = number
        return self
    }
    
    lazy var endYear: DateClosure = {
        [unowned self]
        number in
        self.end_year = number
        return self
    }
    
    lazy var endMonth: DateClosure = {
        [unowned self]
        number in
        self.end_month = number
        return self
    }
    
    lazy var endDay: DateClosure = {
        [unowned self]
        number in
        self.end_day = number
        return self
    }
    
    lazy var endHour: DateClosure = {
        [unowned self]
        number in
        self.end_hour = number
        return self
    }
    
    lazy var endMinute: DateClosure = {
        [unowned self]
        number in
        self.end_minute = number
        return self
    }

    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.backgroundColor = UIColor.clear
        self.addTarget(self, action: #selector(dismissFromSuperview), for: UIControlEvents.touchUpInside)
        self.configerSubviews()
    }
    
    deinit {
        self.completion = nil
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
    }
}

extension GSDatePicker {
    //视图布局
    fileprivate func configerSubviews() {
        cancelButton.layer.cornerRadius = 5
        cancelButton.backgroundColor = UIColor(red: 32.0/255, green: 137.0/255, blue: 212.0/255, alpha: 1.0)
        cancelButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelButton.setTitle("取消", for: UIControlState.normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: UIControlEvents.touchUpInside)
        
        okButton.layer.cornerRadius = 5
        okButton.backgroundColor = UIColor(red: 32.0/255, green: 137.0/255, blue: 212.0/255, alpha: 1.0)
        okButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        okButton.setTitle("确定", for: UIControlState.normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: UIControlEvents.touchUpInside)

        
        let backViewHeight:CGFloat = 250
        let buttonWidth:CGFloat = 50
        let buttonHeight:CGFloat = 30

        let backView: UIView = UIView(frame: CGRect(x: 0, y: screenHeight - backViewHeight, width: screenWidth, height: screenHeight))
        backView.backgroundColor = UIColor.white
        self.addSubview(backView)
        
        cancelButton.frame = CGRect(x: 20, y: 5, width: buttonWidth, height: buttonHeight)
        okButton.frame = CGRect(x: screenWidth-buttonWidth-20, y: 5, width: buttonWidth, height: buttonHeight)
        picker.frame = CGRect(x: 0, y: buttonHeight+10, width: screenWidth, height: backViewHeight-(buttonHeight+5))
        
        backView.addSubview(cancelButton)
        backView.addSubview(okButton)
        backView.addSubview(picker)
    }
}

extension GSDatePicker {
    //按钮动作
    @objc fileprivate func cancelButtonAction(_ button:UIButton) {
        self.dismissFromSuperview()
    }
    
    @objc fileprivate func okButtonAction(_ button :UIButton) {
        self.dismissFromSuperview()
        let formatter : DateFormatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = self.formatter
        let s_date = formatter.string(from: self.picker.date)
        if let t_completion = self.completion {
            t_completion(s_date)
        }
    }
    
    @objc func dismissFromSuperview() {
        self.removeFromSuperview()
        UIView.animate(withDuration: 0.3, animations: {
            [unowned self] in
            self.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
            self.removeFromSuperview()
        })
    }
}

extension GSDatePicker {
    enum GSDatePickerMode {
        case Date,DateAndTime,Time
    }
}

extension GSDatePicker {
    fileprivate func setStartDateIfNeeded() {
        switch self.mode {
        case .Date:
            let isYear:Bool = start_year > 1900
            let isMonth:Bool = start_month > 0 && start_month < 13
            let isDay:Bool = start_day > 0 && start_day < 32
            if isDay && isYear && isMonth {
                let dateString = "\(start_year)-\(start_month)-\(start_day)"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = self.formatter
                if let s_date = dateFormat.date(from: dateString) {
                    self.picker.minimumDate = s_date
                    self.picker.date = s_date
                }
            }

        case .DateAndTime:
            let isYear:Bool = start_year > 1900
            let isMonth:Bool = start_month > 0 && start_month < 13
            let isDay:Bool = start_day > 0 && start_day < 32
            let isHour:Bool = start_hour >= 0 && start_hour < 25;
            let isMinute:Bool  = start_minute >= 0 && start_minute < 61;
            
            if isYear && isMonth && isDay && isHour && isMinute {
                let dateString = "\(start_year)-\(start_month)-\(start_day) \(start_hour):\(start_minute)"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = self.formatter
                if let s_date = dateFormat.date(from: dateString) {
                    self.picker.minimumDate = s_date
                    self.picker.date = s_date
                }
            }

        case .Time:
            let isHour:Bool = start_hour >= 0 && start_hour < 25;
            let isMinute:Bool  = start_minute >= 0 && start_minute < 61;
            
            if isHour && isMinute {
                let dateString = "\(start_hour):\(start_minute)"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = self.formatter
                if let s_date = dateFormat.date(from: dateString) {
                    self.picker.minimumDate = s_date
                    self.picker.date = s_date
                }
            }
        }
    }
    
    fileprivate func setEndDateIfNeeded() {
        switch self.mode {
        case .Date:
            let isYear:Bool = end_year > start_year
            
            var isMonth:Bool = false
            if end_year == start_year {
                isMonth = end_month >= start_month && end_month < 13;
            }else {
                isMonth = end_month > 0 && end_month < 13;
            }
            
            var isDay:Bool = false
            if end_year == start_year && end_month == start_month {
                isDay = end_day > start_day && end_day < 32;
            }
            else {
                isDay = start_day > 0 && start_day < 32;
            }
            
            if isDay && isYear && isMonth {
                let dateString = "\(end_year)-\(end_month)-\(end_day)"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = self.formatter
                if let s_date = dateFormat.date(from: dateString) {
                    self.picker.minimumDate = s_date
                    self.picker.date = s_date
                }
            }
            
        case .DateAndTime:
            let isYear:Bool = end_year > start_year
            
            var isMonth:Bool = false
            if end_year == start_year {
                isMonth = end_month >= start_month && end_month < 13;
            }else {
                isMonth = end_month > 0 && end_month < 13;
            }
            
            var isDay:Bool = false
            if end_year == start_year && end_month == start_month {
                isDay = end_day > start_day && end_day < 32;
            }
            else {
                isDay = start_day > 0 && start_day < 32;
            }
            
            var isHour:Bool = false
            if end_year == start_year && end_month == start_month && end_day == start_day {
                isHour = end_hour >= start_hour && end_hour < 13;
            }
            else {
                isHour = end_hour >= 0 && end_hour < 13;
            }
            
            var isMinute:Bool = false
            if end_year == start_year && end_month == start_month && end_day == start_day && end_hour == start_hour {
                isMinute = end_minute > start_minute && end_minute < 61;
            }else {
                isMinute = end_minute >= 0 && end_minute < 61;
            }
            
            if isYear && isMonth && isDay && isHour && isMinute {
                let dateString = "\(start_year)-\(start_month)-\(start_day) \(start_hour):\(start_minute)"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = self.formatter
                if let s_date = dateFormat.date(from: dateString) {
                    self.picker.minimumDate = s_date
                    self.picker.date = s_date
                }
            }
            
            print()
            
        case .Time:
            let isHour:Bool = end_hour >= start_hour && end_hour < 13
            
            var isMinute:Bool = false
            if end_hour == start_hour {
                isMinute = end_minute > start_minute && end_minute < 61;
            }else {
                isMinute = end_minute >= 0 && end_minute < 61;
            }
            
            if isHour && isMinute {
                let dateString = "\(end_hour):\(end_minute)"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = self.formatter
                if let s_date = dateFormat.date(from: dateString) {
                    self.picker.minimumDate = s_date
                    self.picker.date = s_date
                }
            }

            print()
        }
    }
}














