//
//  IDViewController.swift
//  IDRnd
//
//  Created by 정정이 on 2021/03/04.
//

import UIKit

class IDViewController: UIViewController , DBIdChkProtocol,UITextFieldDelegate{
 
    

    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var tfFindID: UITextField!
    @IBOutlet weak var buttonContinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tfFindID.delegate = self
        
        //텍스트 필드 밑줄
        tfFindID.borderStyle = .none // 보더값 없애주기
        let border1 = CALayer()
        border1.frame = CGRect(x: 0, y: tfFindID.frame.size.height-1, width: tfFindID.frame.width, height: 1)
        border1.backgroundColor = UIColor.gray.cgColor
        tfFindID.layer.addSublayer((border1))
        
        
        buttonContinue.layer.masksToBounds = true
        buttonContinue.layer.cornerRadius = 15
    }
    
    
    
    
    
    @IBAction func btnIDFind(_ sender: UIButton) {
        let inputPhone = tfFindID.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let inputPw = tfPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
            let dbIdCheck = DBIdChk()
        dbIdCheck.delegate = self
        dbIdCheck.check(phone: inputPhone)
    
     
        
    }
    
    
    func idResult(result: String) {
        if result == ""{
            labelId.text = "가입된 핸드폰번호가 없습니다."
            labelId.textColor = UIColor.red
        }else{
            
            labelId.text = "회원님의 아이디는 \n'\(result)'입니다."
            labelId.textColor = UIColor.blue
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
