//
//  TabBarViewController.swift
//  TabsView
//
//  Created by 고종찬 on 2021/03/05.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 네비게이션 바 백버튼 지우기
        navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
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
