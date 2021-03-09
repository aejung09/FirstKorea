//
//  DBLoginCheck.swift
//  loginView
//
//  Created by TJ on 2021/02/25.
//

import Foundation

protocol DbLoginCheckProtocol: class {
    func loginResult(result: Int)
}


class DBLoginCheck: NSObject {
    var delegate: DbLoginCheckProtocol!
    
    var urlPath = "http://127.0.0.1:8080/JSP/login_check.jsp"
    
    func check(id: String, pw: String){
        
        let urlAdd = "?id=\(id)&pw=\(pw)"
        print(id,pw)
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
            self.delegate.loginResult(result: result)
        })
    }
    
    
} // ----
