//
//  MyPageViewController.swift
//  TabsView
//
//  Created by mini on 2021/03/05.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet var lblUserId: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserId.text = "\(Share.userEmail) 님의 마이페이지"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        let logOutAlert = UIAlertController(title: "로그아웃", message: "로그아웃하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        // Closure 을 이용한 실행
        let logOutAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {ACTION in
            // 로그아웃
            UserDefaults.standard.set(false, forKey: "autoLogin")
            self.performSegue(withIdentifier: "unwindLogOut", sender: self)
        })
        
        let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default, handler: nil)
        
        logOutAlert.addAction(logOutAction)
        logOutAlert.addAction(cancelAction)
        
        present(logOutAlert, animated: true, completion: nil)
        
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
