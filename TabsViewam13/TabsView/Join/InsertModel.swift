//
//  InsertModel.swift
//  MySQL
//
//  Created by 정정이 on 2021/02/16.
//

import Foundation


class InsertModel: NSObject{ // 한방향으로 들어가는거라 따로 protocol이 필요없음
    
    var urlPath = "http://127.0.0.1:8080/JSP/firstKoreaInsert.jsp"
    
    func insertItems(userId: String, userPw: String, userTel: String) -> Bool{ // 잘됐는지 안됐는지 확인하려고 return값을 준다. (true,false로)
        var result: Bool = true
        let urlAdd = "?userId=\(userId)&userPw=\(userPw)&userTel=\(userTel)" // urlPath뒤에 붙여줄거
        urlPath = urlPath + urlAdd
        
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! // 한글 표시를 % 로 바꿔준다.
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data") // 앱스토어에 올릴려면 print다 지워야함
                result = false
            }else{
                print("Data is inserted!")
                result = true
            }
        }
        task.resume()
        return result
        
    }
    
    
}
