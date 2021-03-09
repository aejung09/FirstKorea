//
//  SecedeViewController.swift
//  TabsView
//
//  Created by mini on 2021/03/05.
//

import UIKit

class SecedeViewController: UIViewController {

    @IBOutlet var tfSecede: UITextField!
    @IBOutlet weak var buttonSecession: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 버튼 라운드
        buttonSecession.layer.masksToBounds = true
        buttonSecession.layer.cornerRadius = 15
    }
    
    @IBAction func btnSecede(_ sender: UIButton) {
        
        if tfSecede.text == "탈퇴합니다" {
            print("탈퇴")
            
            
            let updateSecedeDate = UpdateSecedeDate()
            let result = updateSecedeDate.updateItems(userEmail: Share.userEmail)
            
            if result == true {
                let resultAlert = UIAlertController(title: "완료", message: "탈퇴 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                    
                    self.performSegue(withIdentifier: "unwindSecede", sender: self)
                })
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
            }else{
                let resultAlert = UIAlertController(title: "실패", message: "에러가 발생되었습니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
            }
            
            
            
        }else{
            print("탈퇴 실패")
            let secedeAlert = UIAlertController(title: "회원탈퇴", message: "일치하지 않습니다", preferredStyle: UIAlertController.Style.alert)
            
            
            
            let cancelAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            
            secedeAlert.addAction(cancelAction)
            
            present(secedeAlert, animated: true, completion: nil)
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

}
