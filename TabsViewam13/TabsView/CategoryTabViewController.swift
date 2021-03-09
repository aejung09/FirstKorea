//
//  CategoryTabViewController.swift
//  TabsView
//
//  Created by 최지석 on 2021/03/04.
//

import UIKit

class CategoryTabViewController: UIViewController {
    let timer: Selector = #selector(CategoryTabViewController.timerUp)
    var userId = Share.userEmail
    let defaultColor = #colorLiteral(red: 0.4645312428, green: 0.6098279953, blue: 0.8870525956, alpha: 1)
    var timerCount = 0

    @IBOutlet weak var buttonNews: UIButton!
    @IBOutlet weak var buttonSport: UIButton!
    @IBOutlet weak var buttonYoutube: UIButton!
    @IBOutlet weak var buttonPrice: UIButton!
    @IBOutlet weak var buttonFamousRestaurant: UIButton!
    @IBOutlet weak var buttonCoin: UIButton!
    @IBOutlet weak var buttonUpdate: UIButton!
    var timeCount = 0
    var news:String = ""
    var sport:String = ""
    var youtube:String = ""
    var price:String = ""
    var famousRestaurant:String = ""
    var coin:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTabStatusSelect(userId)
        
        var _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timer, userInfo: nil, repeats: false)
        // 버튼 라운드
        buttonUpdate.layer.masksToBounds = true
        buttonUpdate.layer.cornerRadius = 15
    }
    

    
    
    @objc func timerUp(){
        print("a")
        buttonSet()
        
    }
    

    // --------------- 탭 버튼 --------------- //
    @IBAction func buttonNews(_ sender: UIButton) {
        if news == "0"{
            buttonNews.backgroundColor = defaultColor
            news = "1"
        }else{
            buttonNews.backgroundColor = UIColor.systemGray
            news = "0"
        }
        print(news)
    }
    @IBAction func buttonSport(_ sender: UIButton) {
        if sport == "0"{
            buttonSport.backgroundColor = defaultColor
            sport = "1"
        }else{
            buttonSport.backgroundColor = UIColor.systemGray
            sport = "0"
        }
        print(sport)
    }
    @IBAction func buttonYoutube(_ sender: UIButton) {
        if youtube == "0"{
            buttonYoutube.backgroundColor = defaultColor
            youtube = "1"
        }else{
            buttonYoutube.backgroundColor = UIColor.systemGray
            youtube = "0"
        }
        print(youtube)
    }
    
    
    @IBAction func buttonPrice(_ sender: UIButton) {
        if price == "0"{
            buttonPrice.backgroundColor = defaultColor
            price = "1"
        }else{
            buttonPrice.backgroundColor = UIColor.systemGray
            price = "0"
        }
        print(price)
        
    }
    
    
    @IBAction func buttonFamousRestaurant(_ sender: UIButton) {
        if famousRestaurant == "0"{
            buttonFamousRestaurant.backgroundColor = defaultColor
            famousRestaurant = "1"
        }else{
            buttonFamousRestaurant.backgroundColor = UIColor.systemGray
            famousRestaurant = "0"
        }
        print(famousRestaurant)
    }
    
    
    @IBAction func buttonCoin(_ sender: UIButton) {
        if coin == "0"{
            buttonCoin.backgroundColor = defaultColor
            coin = "1"
        }else{
            buttonCoin.backgroundColor = UIColor.systemGray
            coin = "0"
        }
        print(coin)
    }
    
    // --------------- 탭 버튼 --------------- //
    

    
    // 수정하기
    @IBAction func buttonUpdate(_ sender: UIButton) {
        categoryTabStatusUpdate(news: news, sport: sport, youtube: youtube, price: price, famousRestaurant: famousRestaurant, coin: coin)
        let Alert = UIAlertController(title: "수정 완료", message: "수정이 되었습니다.", preferredStyle: UIAlertController.Style.alert )
        
        // Closure  를 이용한 실행
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {ACTION in
            
        })

       Alert.addAction(action)
       

        present(Alert, animated: true, completion: nil)
       
    }
    
    
    //
    func buttonSet(){
        if news == "0"{
           
        }else{
            buttonNews.backgroundColor = defaultColor
        }
        
        if sport == "0"{
            
        }else{
            buttonSport.backgroundColor = defaultColor
        }
        
        if youtube == "0"{
            //buttonYoutube.backgroundColor = UIColor.gray
        }else{
            buttonYoutube.backgroundColor = defaultColor
        }
        
        if price == "0"{
            //buttonYoutube.backgroundColor = UIColor.gray
        }else{
            buttonPrice.backgroundColor = defaultColor
        }
        
        if famousRestaurant == "0"{
            //buttonFamousRestaurant.backgroundColor = UIColor.gray
        }else{
            buttonFamousRestaurant.backgroundColor = defaultColor
        }
        
        if coin == "0"{
           // buttonCoin.backgroundColor = UIColor.gray
        }else{
            buttonCoin.backgroundColor = defaultColor
        }
        
        
    }
   
    

    
    // 유저탭 정보 가져오기
    func categoryTabStatusSelect(_ userId:String) {
        let urlPath = "http://127.0.0.1:8080/JSP/CategoryTabSelect.jsp?userid="+userId
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data,response, error) in // 네트워크에서 바로 파싱이됨.
            if error != nil {
                print("Failed to download data")
            }else{
                print("Data is downloading")
                self.categoryTabParser(data!)
                
            }
            
        }
        task.resume()
        
    }
    func categoryTabParser(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray // json model 탈피
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            print(jsonElement)
            if let coinTab = jsonElement["coinTab"] as? String,
               let famousRestaurantTab = jsonElement["famousRestaurantTab"] as? String,
               let newsTabs = jsonElement["newsTabs"] as? String,
               let priceTap = jsonElement["priceTap"] as? String,
               let sportTab = jsonElement["sportTab"] as? String,
               let youtubeTab = jsonElement["yutubeTab"] as? String{
                print("in if let")
                news = newsTabs
                sport = sportTab
                youtube = youtubeTab
                price = priceTap
                famousRestaurant = famousRestaurantTab
                coin = coinTab

            }
        }
       
    }
    
    // 업데이트
    func categoryTabStatusUpdate(news:String, sport:String, youtube:String, price:String, famousRestaurant:String, coin:String) -> Bool{
        var result: Bool = true
        var urlPathUp = "http://127.0.0.1:8080/IOS/CategoryTabUpdate.jsp"
        let urlAddUp = "?newsTabs=\(news)&sportTab=\(sport)&yutubeTab=\(youtube)&priceTap=\(price)&famousRestaurantTab=\(famousRestaurant)&coinTab=\(coin)&userid="+userId
        urlPathUp = urlPathUp + urlAddUp
        
        // 한글 url encoding
        urlPathUp = urlPathUp.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPathUp)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
                result = false
            }else{
                print("Data is inserted!")
                result = true
            }
        }
        task.resume()
        return result
        
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
