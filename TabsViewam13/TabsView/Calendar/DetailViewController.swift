//
//  DetailViewController.swift
//  FSCalendar_tutorial
//
//  Created by Derrick on 2021/03/03.
//

import UIKit

class DetailViewController: UIViewController {
    
    //-------------
    // Properties
    //-------------
    // 21.03.03
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var startTimeText: UITextField!
    @IBOutlet weak var endTimeText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var buttonUpdate: UIButton!
    @IBOutlet weak var contentText: UITextField!
    
    var db:DBHelper = DBHelper()
    var schedulers:[scheduler] = []
    // 날짜 값 받기
    var receiveDate = ""
    
    // TimePicker
    let startTimePicker = UIDatePicker()
    let startToolbar = UIToolbar()
    
    let endTimePicker = UIDatePicker()
    let endToolbar = UIToolbar()
    
    var detailStartTime = ""
    var detailEndTime = ""
    var detailTitle = ""
    var detailContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 선택한 날짜 띄우기 
      
        startTime()
        endTime()
        textInit()
        buttonUpdate.layer.masksToBounds = true
        buttonUpdate.layer.cornerRadius = 15
    }
    
    @IBAction func buttonModify(_ sender: UIButton) {
        // 처음 선택 하는 시간
        let startTime: String = startTimeText.text!
        // 이시간 까지
        let endTime: String = endTimeText.text!
        // 제목
        let title: String = titleText.text!
        // 내용
        let content: String = contentText.text!
        // id 는 시퀀스 넘버로, 0으로 입력해놓으면 AI
        let sNo: Int = Share.sNo
        // 제목과 내용이 안들어간 경우
        navigationController?.popViewController(animated: true)

        
        if titleText.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || contentText.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            titleText.text = "제목 없음"
            contentText.placeholder = "내용"
            
        }else{
            // sNo
            
            db.updateByID(sno: sNo ,startTime: "\(startTime)", endTime: "\(endTime)", title: "\(title)", content: "\(content)")
            performSegue(withIdentifier: "unwindDetailView", sender: self)

        }
    }
    

//-----------------------------------------------Timer..
    // Start Timer
    func startTime(){
        startToolbar.sizeToFit()
        let doneStartButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneStartClicked))
        startToolbar.items = [doneStartButton]
        // 처음 들어갈 곳
        startTimeText.inputAccessoryView = startToolbar
        startTimeText.inputView = startTimePicker
        startTimePicker.datePickerMode = .time
        startTimePicker.preferredDatePickerStyle = .wheels
    }
    
    // Start Timer
    @objc func doneStartClicked(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        startTimeText.text = formatter.string(from: startTimePicker.date)
        self.view.endEditing(true)
    }
    // End Timer
    func endTime(){
        endToolbar.sizeToFit()
        let doneEndButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEndClicked))
        endToolbar.items = [doneEndButton]
        // 처음 들어갈 곳
        endTimeText.inputAccessoryView = endToolbar
        endTimeText.inputView = endTimePicker
        endTimePicker.datePickerMode = .time
        endTimePicker.preferredDatePickerStyle = .wheels
    }
    
    // End Timer
    @objc func doneEndClicked(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        endTimeText.text = formatter.string(from: endTimePicker.date)
        self.view.endEditing(true)
    }
//-----------------------------------------------Timer..
    
    func textInit(){
        labelDate.text = receiveDate
    }
    // Prepare 에서 아이템들을 구동 시킬수 있다. --> TableView에 있음
    func receiveItems(_ date: String){
        receiveDate = date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleText.text = Share.title
        contentText.text = Share.content
        startTimeText.text = Share.startTime
        endTimeText.text = Share.endTime
        
        
    }
    
}
