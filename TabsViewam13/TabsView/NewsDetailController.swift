//
//  NewsDetailController.swift
//  NewsTable
//
//  Created by 고종찬 on 2021/03/02.
//

import UIKit

class NewsDetailController: UIViewController {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var labelMain: UILabel!
    
    
    var imageURL:String?
    var desc:String?
    
    //1.imageURL
    //2.description
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let img = imageURL{
            if let data = try? Data(contentsOf: URL(string: img)!){
            
                DispatchQueue.main.async {
                    self.imageMain.image = UIImage(data: data)
                }
            }
        }
        
        if let d = desc {
            self.labelMain.text = d
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
