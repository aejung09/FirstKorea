//
//  AddViewController.swift
//  TableControl
//
//  Created by 고종찬 on 2021/02/09.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txtAddItem: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    var imageArray = [UIImage?]()
    var imageFileName = ["cart.png","clock.png","pencil.png"]
    var imageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<imageFileName.count{
            imageArray.append(UIImage(named: imageFileName[i]))
        }
        
        imgView.image = imageArray[0]

     
        
    }
    
    
    //필드값에 있는것이 아니라 클래스 선언 위에 하면 불러올수 있다. segue
    @IBAction func btnAddItem(_ sender: UIButton) {
        // items에 text field의 text값을 추가
        items.append(txtAddItem.text!)
        itemsImageFile.append(imageFileName[imageNumber])
        txtAddItem.text = ""
        navigationController?.popViewController(animated: true)
    }
            
  
        //-----------------------------------
        // UIPickerViewDataSource의 stubs   //
        //-----------------------------------
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return imageArray.count
        }
        
        
 
        //------------------------------------
        //  UIPickerViewDelegate의 stubs     //
        //------------------------------------
        // Picker View에 파일명 배치
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return imageFileName[row]
//        }
        // Picker View에 사진을 배치
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let imageView = UIImageView(image: imageArray[row])
            imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
            return imageView
        }
        // Picker View로 선택된 파일명을 레이블 및 image view에 출력
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           
            imgView.image = imageArray[row]
            imageNumber = row
        }

    

}
