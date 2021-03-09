//
//  FoodJsonModel.swift
//  TabsView
//
//  Created by TJ on 2021/03/04.
//

import Foundation

protocol FoodJsonModelProtocol: class {
    func itemDownloaded(items: NSArray)
}

class FoodJsonModel: NSObject{
    var delegate: FoodJsonModelProtocol! // ! 못불러올 수도 있으니까
    let urlPath = "http://127.0.0.1:8080/JSP/food_store_select.jsp"
    
    func downloadItems(){
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloading")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    
    func searchItems(input: String){
        var urlSearch = "http://127.0.0.1:8080/JSP/food_store_search.jsp?searchText=\(input)"
        print("urlSearch = \(urlSearch)")
        
        // 한글 url encoding (한글 -> % 글씨로)
        urlSearch = urlSearch.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlSearch)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloading")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    /*
     json parsing 작업
     */
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray // json model 탈피
        }catch let error as NSError{
            print("parsing에서 에러 발생", error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray() // 딕셔너리에서 값만 써주기 위해
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
//            let query = DBModel() // instance
            
            
            
            if let getstoreSeqNo = jsonElement["storeSeqNo"] as? String, // let에 정상적으로 들어왔을 때.
               let getstoreName = jsonElement["storeName"] as? String,
               let getstoreScore = jsonElement["storeScore"] as? String,
               let getstoreCategory = jsonElement["storeCategory"] as? String,
               let getpriceRange = jsonElement["priceRange"] as? String,
               let getstoreAddress = jsonElement["storeAddress"] as? String,
               let getstoreImage = jsonElement["storeImage"] as? String{
                
                let query = FoodDBModel(storeSeqNo: Int(getstoreSeqNo), storeName: getstoreName, storeScore: Double(getstoreScore), storeCategory: getstoreCategory, priceRange: getpriceRange, storeAddress: getstoreAddress, storeImage: getstoreImage)
                locations.add(query)
//                print(getstoreSeqNo, getstoreName, getstoreScore, getstoreCategory, getpriceRange, getstoreAddress, getstoreImage)
            }
//            locations.add(query)
        } // for End.
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
    
    
    
    
    
    
    
}// ----
