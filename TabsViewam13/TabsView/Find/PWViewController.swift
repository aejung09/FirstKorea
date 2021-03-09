//
//  PWViewController.swift
//  IDRnd
//
//  Created by 정정이 on 2021/03/04.
//

import UIKit

class PWViewController: UIViewController, DBPwChkProtocol ,UITextFieldDelegate{


    

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var buttonContinue: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        tfEmail.delegate = self
        tfPhone.delegate = self
        //텍스트 필드 밑줄
        tfEmail.borderStyle = .none // 보더값 없애주기
        let border1 = CALayer()
        border1.frame = CGRect(x: 0, y: tfEmail.frame.size.height-1, width: tfEmail.frame.width, height: 1)
        border1.backgroundColor = UIColor.gray.cgColor
        tfEmail.layer.addSublayer((border1))
        
        //텍스트 필드 밑줄
        tfPhone.borderStyle = .none // 보더값 없애주기
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfPhone.frame.size.height-1, width: tfPhone.frame.width, height: 1)
        border2.backgroundColor = UIColor.gray.cgColor
        tfPhone.layer.addSublayer((border2))
        
        buttonContinue.layer.masksToBounds = true
        buttonContinue.layer.cornerRadius = 15
    }
    
    
    
    
    
    @IBAction func btnFindPw(_ sender: UIButton) {
        
        
     
        let inputId = tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputPhone = tfPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let inputPw = tfPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
      
        
        let dbPwCheck = DBPwChk()
        dbPwCheck.delegate = self
        dbPwCheck.check( userId: inputId,phone: inputPhone)
    
        
    }
    
    
    
    func pwResult(result: String) {
        if result == ""{
            labelResult.text = "가입된 정보가 없습니다."
            labelResult.textColor = UIColor.red
        }else{
            
            labelResult.text = "회원님 비밀번호는 \n'\(result)'입니다."
            labelResult.textColor = UIColor.blue
        }
    
        
        
    }
    
    
    
    
    
    // 키보드 없애기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
