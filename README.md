
# GGDatePicker
## Breif Introduction
A simple date picker(Swift)
## Usage
```swift
	let picker: GSDatePicker = GSDatePicker()
  picker.mode = .DateAndTime
  picker.startYear(2017).startMonth(1).startDay(1).startHour(1).startMinute(1)
  //this closure will be called after "确定"(ok) button
  picker.show(completionClosure: {
      (dateString:String) in
       print(dateString)
       print("-----")
   })
```
## Picker show
![Image has gone](https://github.com/bbloveccgxy/GGDatePicker/blob/master/Image/Image.png?raw=true "GGDatePicker")
## Problems
I have not test all the date setting wheather correct....  
