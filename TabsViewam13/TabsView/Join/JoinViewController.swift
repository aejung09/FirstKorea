//
//  JoinViewController.swift
//  TabsView
//
//  Created by 정정이 on 2021/03/04.
//

import UIKit

class JoinViewController: UIViewController,UITextFieldDelegate, JsonModelProtocol {
  
    
    
    

    @IBOutlet weak var tfPw: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwChk: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var btnInsert: UIButton!
    @IBOutlet weak var labelPwChk: UILabel!
    @IBOutlet weak var labelPhoneChk: UILabel!
    @IBOutlet weak var labelEmailChk: UILabel!
    
    let defaultColor = #colorLiteral(red: 0.4645312428, green: 0.6098279953, blue: 0.8870525956, alpha: 1)
    var chk = 0
    var chk2 = 0
    var feedItem: NSArray = NSArray()
    var emailCheck = false
    var pwCheck = false
    var telCheck = false
    var idCheck = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //비번 글자수 delegate
        tfPw.delegate = self
        tfPwChk.delegate = self
        //핸드폰번호 글자수 delegate
        tfPhone.delegate = self
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
        
        // tf에 아무것도 입력안했을 시 버튼 비활성화
        btnInsert.backgroundColor = UIColor.gray
        btnInsert.isEnabled = false
        
   

       
   
        
        
    }
    
    
    // 비밀번호 maxLength ,
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (tfPw.text?.count ?? 13 > maxLength) {
            tfPw.deleteBackward()
        }
        if (tfPwChk.text?.count ?? 13 > maxLength) {
            tfPwChk.deleteBackward()
        }
        if tfPhone.text?.count ?? 11 > maxLength {
            tfPhone.deleteBackward()
        }
    }//-----
    
    
    @IBAction func tfPw(_ sender: UITextField) {
        pwChk()
       
          checkMaxLength(textField: tfPw, maxLength: 13)
          
      
          
    }//---
    
    
    @IBAction func tfPwChk(_ sender: UITextField) {
        pwChk()
       
        checkMaxLength(textField: tfPwChk, maxLength: 13)
        
    }//---
    
    @IBAction func tfEmail(_ sender: UITextField) {
        
        let inputId = tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
        
        
        if isValidEmail(testStr: inputId){
            let jsonModel = JsonModel()
            jsonModel.delegate = self
            jsonModel.check(id: inputId)
            
        }else{
            labelEmailChk.text = "이메일 형식이 아닙니다."
            labelEmailChk.textColor = UIColor.red
            emailCheck = false
        }
       print("email : \(emailCheck),\(telCheck),\(pwCheck)")
        
    }//----
    
    
    
    @IBAction func tfPhone(_ sender: UITextField) {
        
        
        checkMaxLength(textField: tfPhone, maxLength: 11)
       
        if tfPhone.text!.count > 3{
            let startIndex: String.Index = (tfPhone.text?.index(tfPhone.text!.startIndex,offsetBy: 2))!
            if String(tfPhone.text![...startIndex]) != "010"{
                labelPhoneChk.text = "올바른 핸드폰 번호가 아닙니다."
                labelPhoneChk.textColor = UIColor.red
                telCheck = false
            }else if tfPhone.text!.count == 11{
                labelPhoneChk.text = "올바른 핸드폰 번호입니다."
                labelPhoneChk.textColor = UIColor.blue
                telCheck = true

            }else{
                labelPhoneChk.text = "올바른 핸드폰 번호가 아닙니다."
                labelPhoneChk.textColor = UIColor.red
                telCheck = false
            }
        }
        
        print("email : \(emailCheck),\(telCheck),\(pwCheck)")
        if pwCheck&&emailCheck&&telCheck{
            btnInsert.isEnabled = true
            btnInsert.backgroundColor = defaultColor
        }else{
            btnInsert.isEnabled = false
            btnInsert.backgroundColor = UIColor.gray
        }
        
        
    }//----
    
    
    
    // 비밀번호 확인 함수
    func pwChk() {
        
        if tfPw.text == tfPwChk.text && tfPw.text!.count > 7 && tfPwChk.text!.count > 7{
            labelPwChk.text = "비밀번호가 일치합니다."
            labelPwChk.textColor = UIColor.blue
            pwCheck = true
            
        }else{
            labelPwChk.text = "비밀번호가 일치하지 않습니다."
            labelPwChk.textColor = UIColor.red
            pwCheck = false
        }
            
        if  tfPw.text!.count <= 8 && tfPwChk.text!.count <= 8{
            btnInsert.isEnabled = false
            btnInsert.backgroundColor = UIColor.gray
            labelPwChk.text = "8글자 이상 입력해 주세요."
            labelPwChk.textColor = UIColor.red
        }
        print("email : \(emailCheck),\(telCheck),\(pwCheck)")
        if pwCheck&&emailCheck&&telCheck{
            btnInsert.isEnabled = true
            btnInsert.backgroundColor = defaultColor
        }else{
            btnInsert.isEnabled = false
            btnInsert.backgroundColor = UIColor.gray
        }
    }//---
    
    
    
    
    //이메일 정규식
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
    }//-----
    
    
    
    
    
    @IBAction func btnInsert(_ sender: UIButton) {
        
        let userId = tfEmail.text
        let userPw = tfPw.text
        let userTel = tfPhone.text

        
        let insertModel = InsertModel()
        let result = insertModel.insertItems(userId: userId!, userPw: userPw!, userTel: userTel!)
        
        if result == true {
            let t_userId = userId
            let resultAlert = UIAlertController(title: "완료 ", message: "관심사 선택창으로 이동합니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                //self.navigationController?.popViewController(animated: true)
                self.performSegue(withIdentifier: "joinNext", sender: t_userId)
                self.categoryInsert(t_userId: t_userId!)
                
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }else{
            let resultAlert = UIAlertController(title: "실패 ", message: "에러가 발생되었습니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
        
        
    }//-----
    
    func joinResult(result: Int) {
        switch result {
        case 1:
            labelEmailChk.text = "중복된 이메일 입니다."
            labelEmailChk.textColor = UIColor.red
            emailCheck = false
            
        default:
            labelEmailChk.text = "사용가능한 이메일 입니다."
            labelEmailChk.textColor = UIColor.blue
            emailCheck = true
        }
        print("email : \(emailCheck),\(telCheck),\(pwCheck)")
        if pwCheck&&emailCheck&&telCheck{
            btnInsert.isEnabled = true
            btnInsert.backgroundColor = defaultColor
        }else{
            btnInsert.isEnabled = false
            btnInsert.backgroundColor = UIColor.gray
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnShowPw(_ sender: UIButton) {
        if chk  == 0{

        tfPw.isSecureTextEntry = false
            chk = 1
        }else{
            tfPw.isSecureTextEntry = true
            chk = 0
        }
        
    }//----
    
    
    @IBAction func btnShowPwChk(_ sender: UIButton) {
  
        if chk2 == 0{
        tfPwChk.isSecureTextEntry = false
            chk2 = 1
        }else{
            tfPwChk.isSecureTextEntry = true
            chk2 = 0
        }
    }
    
    
    func categoryInsert(t_userId: String) -> Bool{
           
           var result: Bool = true
           var urlPath = "http://127.0.0.1:8080/JSP/firstKoreaInsertCategorytab.jsp"
           let urlAdd = "?t_userId=\(t_userId)"
           urlPath = urlPath + urlAdd
           
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! // 한글 표시를 % 로 바꿔준다.
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data") // 앱스토어에 올릴려면 print다 지워야함
                result = false
            }else{
                print("Data is inserted!")
                result = true
            }
        }
        task.resume()
        return result
        
    }
    
    
    
    // 키보드 없애기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // 카테고리선택으로 아이디 보내기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let joinCategory = segue.destination as? JoinCategoryTabViewController,
              let segueUserid = sender as? String else {return}
        joinCategory.userId = segueUserid
    }
    
    

}
