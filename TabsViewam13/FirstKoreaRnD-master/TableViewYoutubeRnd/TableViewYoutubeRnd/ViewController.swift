//
//  ViewController.swift
//  TableViewYoutubeRnd
//
//  Created by 정정이 on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnBlog: UIButton!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var btnMovie: UIButton!
    @IBOutlet weak var btnGame: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnBlog.layer.masksToBounds = true
        btnBlog.layer.cornerRadius = 10
        btnEnter.layer.masksToBounds = true
        btnEnter.layer.cornerRadius = 10
        btnMovie.layer.masksToBounds = true
        btnMovie.layer.cornerRadius = 10
        btnGame.layer.masksToBounds = true
        btnGame.layer.cornerRadius = 10
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
