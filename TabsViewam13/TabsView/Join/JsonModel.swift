//
//  JsonModel.swift
//  ServerJson_01
//
//  Created by 정정이 on 2021/02/15.
//

import Foundation

protocol JsonModelProtocol: class {
    func joinResult(result: Int)
}
class JsonModel: NSObject {
    var delegate: JsonModelProtocol!
    var urlPath = "http://127.0.0.1:8080/JSP/firstKorea.jsp"
    
    
    func check(id: String){
        
        let urlAdd = "?userId=\(id)"
        print(id)
        urlPath = urlPath + urlAdd // get 방식으로 보낼 값들 달아주기
        
        // 한글 url encoding (한글 -> % 글씨로)
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
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
    

    /*
     json parsing 작업
     */
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray // json model 탈피
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        
        var result = 0
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            print(jsonElement)
            if let loginResult = jsonElement["result"] as? String{
                print("in if let")
                result = Int(loginResult)!
            }
            print("in for" ,result)
            
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.joinResult(result: result)
        })
    }
    
}//--------

