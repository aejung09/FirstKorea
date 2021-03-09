//
//  JsonModel.swift
//  ServerJson_01
//
//  Created by 정정이 on 2021/02/15.
//

import Foundation

protocol JsonModelProtocol: class {
    func itemDownloaded(items: NSArray)
}
class JsonModel: NSObject {
    var delegate: JsonModelProtocol!
    let urlPath = "http://127.0.0.1:8080/IOS/firstKorea.jsp"
    
    
    func downloadItems() {
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data,response, error) in // 네트워크에서 바로 파싱이됨.
            if error != nil {
                print("Failed to download data")
            }else{
                print("Data is downloading")
                self.parseJSONS(data!)
                
            }
            
        }
        task.resume()
    }
    

    
    func parseJSONS(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
            
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            
            
            if let userId = jsonElement["userId"] as? String,
               let userPw = jsonElement["userPw"] as? String,
               let userTel = jsonElement["userTel"] as? String
             {
                let query = DBModel(userId: userId,userPw: userPw, userTel: userTel)
                locations.add(query)
            }
        
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
            
    }
    
}//--------

