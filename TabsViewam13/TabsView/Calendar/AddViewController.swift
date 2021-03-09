//
//  AddViewController.swift
//  TabsView
//
//  Created by Derrick on 2021/03/04.
//

import UIKit

class AddViewController: UIViewController {

    
    //-------------
    // Properties
    //-------------
    
    // 21.03.02
    var db:DBHelper = DBHelper()
    var schedulers:[scheduler] = []
    // 날짜 값 받기
    var receiveDate = ""

    // TimePicker
    let startTimePicker = UIDatePicker()
    let startToolbar = UIToolbar()
    
    let endTimePicker = UIDatePicker()
    let endToolbar = UIToolbar()
    
    @IBOutlet weak var textDate: UILabel!
    @IBOutlet weak var textStartTime: UITextField!
    @IBOutlet weak var textEndTime: UITextField!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textContent: UITextField!
    @IBOutlet weak var buttonInsert: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textDate.text = receiveDate
        startTime()
        endTime()
        buttonInsert.layer.masksToBounds = true
        buttonInsert.layer.cornerRadius = 15
    }
    
    // Start Timer
    func startTime(){
        startToolbar.sizeToFit()
        let doneStartButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneStartClicked))
        startToolbar.items = [doneStartButton]
        // 처음 들어갈 곳
        textStartTime.inputAccessoryView = startToolbar
        textStartTime.inputView = startTimePicker
        startTimePicker.datePickerMode = .time
        startTimePicker.preferredDatePickerStyle = .wheels
    }
    
    // Start Timer
    @objc func doneStartClicked(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        textStartTime.text = formatter.string(from: startTimePicker.date)
        self.view.endEditing(true)
    }
    
    // End Timer
    func endTime(){
        endToolbar.sizeToFit()
        let doneEndButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEndClicked))
        endToolbar.items = [doneEndButton]
        // 처음 들어갈 곳
        textEndTime.inputAccessoryView = endToolbar
        textEndTime.inputView = endTimePicker
        endTimePicker.datePickerMode = .time
        endTimePicker.preferredDatePickerStyle = .wheels
    }
    // End Timer
    @objc func doneEndClicked(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        textEndTime.text = formatter.string(from: endTimePicker.date)
        self.view.endEditing(true)
    }
    
    
    
    // 21.03.02
    // Prepare 에서 아이템들을 구동 시킬수 있다. --> TableView에 있음
    func receiveItems(_ date: String){
        receiveDate = date
        
    }

    // 21.03.02
    @IBAction func buttonInsert(_ sender: UIButton) {
        
        // 처음 선택 하는 시간
        let startTime: String = textStartTime.text!
        // 이시간 까지
        let endTime: String = textEndTime.text!
        // 제목
        let title: String = textTitle.text!
        // 내용
        let content: String = textContent.text!
        // 날짜
        let date: String = receiveDate
        // id 는 시퀀스 넘버로, 0으로 입력해놓으면 AI
    
        // 제목과 내용이 안들어간 경우
        if textTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || textContent.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            textTitle.text = "제목 없음"
            textContent.text = " "
            
        }else{
            // sNo
            db.insert(sno: 0, startTime: "\(startTime)", endTime: "\(endTime)", title: "\(title)", content: "\(content)", date: "\(date)")
            performSegue(withIdentifier: "unwindADDView", sender: self)

        }
    }
}
