//
//  UpdateSecedeDate.swift
//  TabsView
//
//  Created by mini on 2021/03/05.
//

import Foundation


class UpdateSecedeDate: NSObject{
    
    var urlPath = "http://127.0.0.1:8080/JSP/UpdateSecedeDate.jsp"
    
    func updateItems(userEmail: String) -> Bool{
        var result: Bool = true
        
        urlPath = urlPath + "?userId=\(userEmail)"
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to update data")
                result = false
            }else{
                print("Data is updated!")
                result = true
            }
        }
        task.resume()
        return result
    }
    
    
    
    
    
    
    
} // ----
