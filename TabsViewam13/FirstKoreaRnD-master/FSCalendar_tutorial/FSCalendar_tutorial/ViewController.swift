//
//  ViewController.swift
//  FSCalendar_tutorial
//
//  Created by Derrick on 2021/03/01.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    //----------
    // Properties
    //----------
    @IBOutlet weak var calendar: FSCalendar!
    var formatter = DateFormatter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
     
//        calendar.scope = .week
     
        self.view.addSubview(calendar)

        
        // 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월 "
        // 달력의 요일 글자 바꾸는 방법 1
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase

        
        
        
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        // 오늘의 날짜 체크
        calendar.appearance.todayColor = .systemBlue
        // 날짜 선택한 경우 글자색
        calendar.appearance.titleTodayColor = .darkGray
        // 날짜 선택된경우 배경색
        calendar.appearance.titleDefaultColor = .darkGray
        // 오늘 날짜 색 2021.03
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.weekdayTextColor = .darkGray
        
        calendar.delegate = self
        calendar.dataSource = self
        // 꾸욱 눌러서 스와이프 동작으로 다중 선택
        calendar.swipeToChooseGesture.isEnabled = true
        // 다중 선택
        calendar.allowsMultipleSelection = true

  
    }
    

        
    //MARK:- Data Source
    func minimumDate(for calendar: FSCalendar) -> Date {
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "YYYY-MM-dd"
        
        
        return dateFormatter.date(from: "1900-01-01")!; Date()
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "YYYY-MM-dd"
        
        return dateFormatter.date(from: "2100-01-01") ?? Date()
    }
    //MARK:- Delegate
    
    // 선택 풀었을때.
   
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Data De-Selected == \(formatter.string(from: date))")

    }
    // 선택 했을때
    //  It specifies date in the calendar is selected by tapping.
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Data Selected == \(formatter.string(from: date))")

    }
    

    // It specifies whether date is allowed to be selected by tapping.
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Data Selected == \(formatter.string(from: date))")
    }
