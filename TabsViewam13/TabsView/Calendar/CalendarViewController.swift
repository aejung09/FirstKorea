//
//  CalendarViewController.swift
//  TabsView
//
//  Created by Derrick on 2021/03/04.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource {
    
    //----------
    // Properties
    //----------
    let cellReuseIdentifier = "myCell"
    var db:DBHelper = DBHelper()
    
    var schedulers:[scheduler] = []
    
    // receiveItem 에 보낼 선택된 날짜.
    var sendDate = ""
    var sendSno = 0
    var sendStartTime = ""
    var sendEndTime = ""
    var sendTitle = ""
    var sendContent = ""
    
    @IBOutlet weak var tableViewSchedule: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    var formatter = DateFormatter()
    var events:[Date] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
     
        //calendar.scope = .week
        
        self.view.addSubview(calendar)
        tableViewSchedule.delegate = self
        tableViewSchedule.dataSource = self
      
        
        calendarSetting()
      
        
        
        
        // Ediit 버튼을 마들고 삭제 기능 추가하기, 왼쪽으로 배치
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // 입력 수정 삭제 후 DB 재구성
        
        let db:DBHelper = DBHelper()
        let _:[scheduler] = []
        
        tableViewSchedule.delegate = self
        tableViewSchedule.dataSource = self
        tableViewSchedule.rowHeight = 100 // 셀높이
        
        self.schedulers = db.read(date: "\(sendDate)")
        
        self.tableViewSchedule.reloadData()
        print("viewWillAppear Success")
    }
    
    
    
    
    //MARK:- Table
    
    // Delete
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // 글지움
            schedulers.remove(at: (indexPath as NSIndexPath).row)
            // 테이블 한 row 지움
            tableViewSchedule.deleteRows(at: [indexPath], with: .fade)
       
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // Delete 글자를 삭제로 변경하기
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    // Override to support rearranging the table view.
     func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // 이동할 item의 위치 - 1
        let itemToMove = schedulers[(fromIndexPath as NSIndexPath).row]
        // 이동할 item을 삭제 - 3
        schedulers.remove(at: (fromIndexPath as NSIndexPath).row)
        // items 삽입 (1,2번)
        schedulers.insert(itemToMove, at: (to as NSIndexPath).row)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schedulers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewSchedule.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! TableViewCell

        
        cell.hiddenSno?.text = String(schedulers[indexPath.row].sno)
        cell.beforeTime?.text = String(schedulers[indexPath.row].startTime)
        cell.afterTime?.text = "~ \(schedulers[indexPath.row].endTime)"
        
        cell.title?.text = String(schedulers[indexPath.row].title)
        cell.content?.text = schedulers[indexPath.row].content

  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sendSno = schedulers[indexPath.row].sno
        sendStartTime = schedulers[indexPath.row].startTime
        sendEndTime = schedulers[indexPath.row].endTime
        sendTitle = schedulers[indexPath.row].title
        sendContent = schedulers[indexPath.row].content
        
        Share.startTime = sendStartTime
        Share.endTime = sendEndTime
        Share.title = sendTitle
        Share.content = sendContent
        Share.sNo = sendSno
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

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
        formatter.dateFormat = "YYYY-MM-dd"
        print("Data De-Selected == \(formatter.string(from: date))")
        sendDate = ""
        // 선택을 리셋시킴

    }
    // 선택 했을때
    //  It specifies date in the calendar is selected by tapping.
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        formatter.dateFormat = "YYYY-MM-dd"
        print("Data Selected == \(formatter.string(from: date))")

        // 일자 저장시키기
        sendDate = formatter.string(from: date)
        
        self.schedulers = db.read(date: "\(sendDate)")
        self.tableViewSchedule.reloadData()

    }
    

    // It specifies whether date is allowed to be selected by tapping.
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        formatter.dateFormat = "YYYY-MM-dd"
        print("Data Selected == \(formatter.string(from: date))")
        return true
    }


 
    


    //이벤트 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 1
            } else {
            return 0
            }
        }
    // Basic Setting
    func calendarSetting(){
        // 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월 "
        // 달력의 요일 글자 바꾸는 방법 1
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase

        
        
        
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        // 오늘의 날짜 체크
//        calendar.appearance.todayColor = .systemBlue
        // 날짜 선택한 경우 글자색
        calendar.appearance.titleTodayColor = .darkGray
        // 날짜 선택된경우 배경색
        calendar.appearance.titleDefaultColor = .lightGray
//        // 오늘 날짜 색 2021.03
//        calendar.appearance.headerTitleColor = .darkGray
//        calendar.appearance.weekdayTextColor = .darkGray
        
        calendar.delegate = self
        calendar.dataSource = self
        // 꾸욱 눌러서 스와이프 동작으로 다중 선택
        calendar.swipeToChooseGesture.isEnabled = true
        // 다중 선택
        calendar.allowsMultipleSelection = false
       // calendar.weekdayHeight = 10
        
        // 오늘날짜 구하기
        
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "YYYY-MM-dd"
        
        sendDate = formatter_year.string(from: Date())
        
        self.schedulers = db.read(date: "\(sendDate)")
        self.tableViewSchedule.reloadData()
        
        // Event 표시 컬러
        calendar.appearance.eventDefaultColor = UIColor.blue
        calendar.appearance.eventSelectionColor = UIColor.blue

        //---------------------------------------------
        // Events
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let sampledate = formatter.date(from: sendDate)
        events = [sampledate!]
        //---------------------------------------------
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // 등록 페이지
      
        if segue.identifier == "addSchedule"{
            let addView = segue.destination as! AddViewController
            addView.receiveItems(sendDate)
           }
        
        // 수정 페이지
        if segue.identifier == "detailSchedule" {
            let detailView = segue.destination as! DetailViewController
            
            detailView.receiveItems(sendDate)
        }
    }

    
    
    
    // segue to return to EMOMCommentViewController
    @IBAction func unwindAddView (segue : UIStoryboardSegue) {
        let db:DBHelper = DBHelper()
        let _:[scheduler] = []
        
        tableViewSchedule.delegate = self
        tableViewSchedule.dataSource = self
        tableViewSchedule.rowHeight = 100 // 셀높이
        
        self.schedulers = db.read(date: "\(sendDate)")
        
        self.tableViewSchedule.reloadData()
    }
    
    
    // Show Detail 이후 ViewWillAppear 기능을 하는 곳.
    // segue to return to EMOMCommentViewController
    @IBAction func unwindDetailView (segue : UIStoryboardSegue) {
        // 입력 수정 삭제 후 DB 재구성
        
        let db:DBHelper = DBHelper()
        let _:[scheduler] = []
        
        tableViewSchedule.delegate = self
        tableViewSchedule.dataSource = self
        tableViewSchedule.rowHeight = 100 // 셀높이
        
        self.schedulers = db.read(date: "\(sendDate)")
        
        self.tableViewSchedule.reloadData()
   
        
    }
    
    
}////---END
