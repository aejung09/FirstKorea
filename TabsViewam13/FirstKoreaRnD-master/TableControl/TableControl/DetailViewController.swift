//
//  DetailViewController.swift
//  TableControl
//
//  Created by 고종찬 on 2021/02/09.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var itemsImageFile = ["cart.png","clock.png","pencil.png"]
    
    var receiveItem = ""
    var imageField :UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblItem.text = receiveItem
        imgView.image = imageField
    }
    
    
    func receiveItems(_ item: String,imagePath: String){
        receiveItem = item
        imageField = UIImage(named: imagePath)
        
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
