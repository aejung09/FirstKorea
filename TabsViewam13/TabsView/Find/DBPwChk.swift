//
//  DBIdChk.swift
//  IDRnd
//
//  Created by 정정이 on 2021/03/04.
//

import Foundation

protocol DBPwChkProtocol: class {
    func pwResult(result: String)
}



class DBPwChk: NSObject {
    var delegate:DBPwChkProtocol!
    var urlPath = "http://127.0.0.1:8080/JSP/firstKorea_PwCheck.jsp"
    
    
    func check(userId: String ,phone: String){
        
        let urlAdd = "?userId=\(userId)&userTel=\(phone)"

        print("여기 디비")
        urlPath = urlPath + urlAdd // get 방식으로 보낼 값들 달아주기
        print("여기 핸펀" + phone)
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
        
        var result = ""
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            print(jsonElement)
            if let pwResult = jsonElement["result"] as? String{
                print("in if let")
                result = pwResult
            }
            print("in for" ,result)
            
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.pwResult(result: result)
            print(result)
        })
    }
    
}//-----
