//
//  PwUpdateViewController.swift
//  TabsView
//
//  Created by 정정이 on 2021/03/04.
//

import UIKit

class PwUpdateViewController: UIViewController,UITextFieldDelegate {
   
    

    @IBOutlet weak var tfUpdatePw: UITextField!
    @IBOutlet weak var tfUpdatePwChk: UITextField!
    @IBOutlet weak var lblPwChk: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
    
    var pwCheck = false
    let defaultColor = #colorLiteral(red: 0.4645312428, green: 0.6098279953, blue: 0.8870525956, alpha: 1)
    
    var showchk = 0
    var showchk1 = 0
    
    var userId = "gpwjddl@dddd.ddd"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        //비번 글자수 delegate
        tfUpdatePw.delegate = self
        tfUpdatePwChk.delegate = self
        
        //텍스트 필드 밑줄
        tfUpdatePw.borderStyle = .none // 보더값 없애주기
        let border1 = CALayer()
        border1.frame = CGRect(x: 0, y: tfUpdatePw.frame.size.height-1, width: tfUpdatePw.frame.width, height: 1)
        border1.backgroundColor = UIColor.gray.cgColor
        tfUpdatePw.layer.addSublayer((border1))
        
        //텍스트 필드 밑줄
        tfUpdatePwChk.borderStyle = .none // 보더값 없애주기
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfUpdatePwChk.frame.size.height-1, width: tfUpdatePwChk.frame.width, height: 1)
        border2.backgroundColor = UIColor.gray.cgColor
        tfUpdatePwChk.layer.addSublayer((border2))
        
        // 버튼 라운드
        btnUpdate.layer.masksToBounds = true
        btnUpdate.layer.cornerRadius = 15
        
        // tf에 아무것도 입력안했을 시 버튼 비활성화
        btnUpdate.backgroundColor = UIColor.gray
        btnUpdate.isEnabled = false
        
    }
    
    @IBAction func tfUpdatePw(_ sender: UITextField) {
        checkMaxLength(textField: tfUpdatePw, maxLength: 13)
        pwChk()
    }
    
    @IBAction func tfUpdatePwChk(_ sender: UITextField) {
        checkMaxLength(textField: tfUpdatePwChk, maxLength: 13)
        pwChk()
    }
    
    

    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (tfUpdatePw.text?.count ?? 13 > maxLength) {
            tfUpdatePw.deleteBackward()
        }
        if (tfUpdatePwChk.text?.count ?? 13 > maxLength) {
            tfUpdatePwChk.deleteBackward()
        }
       
    }//-----
    
    
    // 비밀번호 확인 함수
    func pwChk() {
        
        if tfUpdatePw.text == tfUpdatePwChk.text && tfUpdatePw.text!.count > 7 && tfUpdatePwChk.text!.count > 7{
            lblPwChk.text = "비밀번호가 일치합니다."
            lblPwChk.textColor = UIColor.blue
            pwCheck = true
            
        }else{
            lblPwChk.text = "비밀번호가 일치하지 않습니다."
            lblPwChk.textColor = UIColor.red
            pwCheck = false
        }
            
        if  tfUpdatePw.text!.count <= 8 && tfUpdatePwChk.text!.count <= 8{
            btnUpdate.isEnabled = false
            btnUpdate.backgroundColor = UIColor.gray
            lblPwChk.text = "8글자 이상 입력해 주세요."
            lblPwChk.textColor = UIColor.red
        }
        
        if pwCheck{
            btnUpdate.isEnabled = true
            btnUpdate.backgroundColor = defaultColor
        }else{
            btnUpdate.isEnabled = false
            btnUpdate.backgroundColor = UIColor.gray
        }
    }//---
    
    
    
    @IBAction func btnShowPw(_ sender: UIButton) {
        if showchk  == 0{

        tfUpdatePw.isSecureTextEntry = false
            showchk = 1
        }else{
            tfUpdatePw.isSecureTextEntry = true
            showchk = 0
        }
        
        
    }
    
    @IBAction func btnShowPwChk(_ sender: UIButton) {
        if showchk1  == 0{

        tfUpdatePwChk.isSecureTextEntry = false
            showchk1 = 1
        }else{
            tfUpdatePwChk.isSecureTextEntry = true
            showchk1 = 0
        }
    }
    
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        
        let Alert = UIAlertController(title: "알림", message: "수정하시겠습니까?", preferredStyle: UIAlertController.Style.alert )
      // Closure  를 이용한 실행
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {ACTION in
            self.pwUpdate(userPw: self.tfUpdatePw.text!,userId: self.userId)
            let success = UIAlertController(title: "알림", message: "수정이 완료되었습니다.", preferredStyle:.alert)
            let  okSuccess = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
                
            })
            success.addAction(okSuccess)
            self.present(success, animated: true, completion: nil)
            })
       
        
        let actionNo = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        Alert.addAction(action)
        Alert.addAction(actionNo)
        present(Alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // 키보드 없애기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    
    
    
    func pwUpdate(userPw: String,userId: String) -> Bool{
           var result: Bool = true
           var urlPathUp = "http://127.0.0.1:8080/JSP/firstKorea_pwUpdate.jsp"
           let urlAddUp = "?userPw=\(userPw)&userId=\(userId)"
           urlPathUp = urlPathUp + urlAddUp
           
           // 한글 url encoding
           urlPathUp = urlPathUp.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
           
           let url: URL = URL(string: urlPathUp)!
           let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
           
           let task = defaultSession.dataTask(with: url){(data, response, error) in
               if error != nil{
                   print("Failed to insert data")
                   result = false
               }else{
                   print("Data is inserted!")
                   result = true
               }
           }
           task.resume()
           return result
           
       }
    
    
    
}//----------
