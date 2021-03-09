//
//  DemoViewController.swift
//  TabsView
//
//  Created by dev on 2021/03/04.
//

import UIKit

class DemoViewController: UIViewController {
    var pageIndex: Int!
    @IBOutlet weak var buttonInactive: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 버튼 라운드
        buttonInactive.layer.masksToBounds = true
        buttonInactive.layer.cornerRadius = 15
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
