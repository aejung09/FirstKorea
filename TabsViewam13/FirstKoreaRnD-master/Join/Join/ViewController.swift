//
//  ViewController.swift
//  Join
//
//  Created by 정정이 on 2021/03/01.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    @IBOutlet weak var tfPwChk: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var btnInsert: UIButton!
    @IBOutlet weak var labelPwChk: UILabel!
    @IBOutlet weak var labelPhoneChk: UILabel!
    let defaultColor = #colorLiteral(red: 0.3730975389, green: 0.6497389078, blue: 1, alpha: 1)
    var chk = 0
    var chk2 = 0
    var feedItem: NSArray = NSArray()

    var keyHeight: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        //텍스트 필드 밑줄
        tfEmail.borderStyle = .none // 보더값 없애주기
          let border = CALayer()
        border.frame = CGRect(x: 0, y: tfEmail.frame.size.height-1, width: tfEmail.frame.width, height: 1)
        border.backgroundColor = UIColor.gray.cgColor
        tfEmail.layer.addSublayer((border))
        
        //텍스트 필드 밑줄
        tfPw.borderStyle = .none // 보더값 없애주기
        let border1 = CALayer()
        border1.frame = CGRect(x: 0, y: tfPw.frame.size.height-1, width: tfPw.frame.width, height: 1)
        border1.backgroundColor = UIColor.gray.cgColor
        tfPw.layer.addSublayer((border1))
        
        //텍스트 필드 밑줄
        tfPwChk.borderStyle = .none // 보더값 없애주기
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfPwChk.frame.size.height-1, width: tfPwChk.frame.width, height: 1)
        border2.backgroundColor = UIColor.gray.cgColor
        tfPwChk.layer.addSublayer((border2))
        
        //텍스트 필드 밑줄
        tfPhone.borderStyle = .none // 보더값 없애주기
        let border3 = CALayer()
        border3.frame = CGRect(x: 0, y: tfPhone.frame.size.height-1, width: tfPhone.frame.width, height: 1)
        border3.backgroundColor = UIColor.gray.cgColor
        tfPhone.layer.addSublayer((border3))
        
        
        
        // 버튼 라운드
        btnInsert.layer.masksToBounds = true
        btnInsert.layer.cornerRadius = 15
        btnInsert.backgroundColor = UIColor.gray
        btnInsert.isEnabled = false
        
   
        
       
    }//---

    
   
    
     // 비밀번호 입력시 바로 체크
    @IBAction func tfPw(_ sender: UITextField) {
      
      pwChk()
        btnNil()
        
        
    }//---
    
    
    
    
    
    // 비밀번호 확인 입력시 바로 체크
    @IBAction func tfPwChk(_ sender: UITextField) {
        pwChk()
        btnNil()
    }//---
    
    
    
    // 이메일 입력시 바로 체크
    @IBAction func tfEmail(_ sender: UITextField) {
        btnNil()
    }//---
    
    
    
    // 전화번호 입력시 바로 체크
    @IBAction func tfPhone(_ sender: UITextField) {
        btnNil()
        
        
        if tfPhone.text?.count == 3||tfPhone.text?.count == 8{
            tfPhone.text? += "-"
    
            
        }
        if tfPhone.text!.count > 13{
            labelPhoneChk.text = "올바른 핸드폰 번호가 아닙니다."
            labelPhoneChk.textColor = UIColor.red
            
        }else if tfPhone.text!.count == 13{
            labelPhoneChk.text = "올바른 핸드폰 번호입니다."
            labelPhoneChk.textColor = UIColor.blue
        }
     
    }//---
    
    
    // 비밀번호 확인 함수
    func pwChk() {
        
        if tfPw.text == tfPwChk.text && tfPw.text!.count > 7 && tfPwChk.text!.count > 7{
            labelPwChk.text = "비밀번호가 일치합니다."
            labelPwChk.textColor = UIColor.blue
        }else{
            labelPwChk.text = "비밀번호가 일치하지 않습니다."
            labelPwChk.textColor = UIColor.red
        }
            
        if  tfPw.text!.count <= 8 && tfPwChk.text!.count <= 8{
            btnInsert.isEnabled = false
            btnInsert.backgroundColor = UIColor.gray
            labelPwChk.text = "8글자 이상 입력해 주세요."
            labelPwChk.textColor = UIColor.red
        }
       
    }//---
    
    
    
 

    // 비밀번호 Show btn
    @IBAction func btnShowPw(_ sender: UIButton) {
        if chk  == 0{

        tfPw.isSecureTextEntry = false
            chk = 1
        }else{
            tfPw.isSecureTextEntry = true
            chk = 0
        }
        
        
    }//---
    
    
    // 비밀번호 확인 Show btn
    @IBAction func btnShowPwChk(_ sender: UIButton) {
        if chk2 == 0{
        tfPwChk.isSecureTextEntry = false
            chk2 = 1
        }else{
            tfPwChk.isSecureTextEntry = true
            chk2 = 0
        }
        
    }//---
    
    
    // 회원가입 버튼
    @IBAction func btnInsert(_ sender: UIButton) {
      
        let userId = tfEmail.text
        let userPw = tfPw.text
        let userTel = tfPhone.text

        
        let insertModel = InsertModel()
        let result = insertModel.insertItems(userId: userId!, userPw: userPw!, userTel: userTel!)
        
        if result == true {
            let resultAlert = UIAlertController(title: "완료 ", message: "입력이 되었습니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }else{
            let resultAlert = UIAlertController(title: "실패 ", message: "에러가 발생되었습니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
        
        
    }//---
    
    
    
 
    
    
    // 회원가입 버튼 활성화
    func btnNil()  {
        if tfEmail.text?.count != 0 && tfPw.text?.count != 0 && tfPhone.text?.count != 0 &&
            tfPwChk.text?.count != 0{
            btnInsert.isEnabled = true
            btnInsert.backgroundColor = defaultColor
            
        }
    }//---
    
    
    // 키보드 없애기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//
//    @objc func keyboardWillShow(_ sender: Notification) {
//        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
//        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
//        let keyboardRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keyboardRectangle.height
//        keyHeight = keyboardHeight
//
//        self.view.frame.size.height -= keyboardHeight
//    }
//
//
//    @objc func keyboardWillHide(_ sender: Notification) {
//
//        self.view.frame.size.height += keyHeight!
//    }
//
//    func setKeyboardEvent() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc func keyboardWillAppear(_ sender: NotificationCenter){
//        self.myView.frame.origin.y -= 150
////
//
//    }
//    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
//        self.myView.frame.origin.y += 200
////        if self.vimyViewew.frame.origin.y == 100 {
////            self.view.frame.origin.y += 200
////        }
//
//    }
//
    
}//---end---

