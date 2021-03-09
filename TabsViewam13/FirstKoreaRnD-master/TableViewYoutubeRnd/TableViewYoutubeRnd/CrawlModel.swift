//
//  CrawlModel.swift
//  Kanna_04
//
//  Created by 정정이 on 2021/02/10.
//

import Foundation
import Kanna

protocol CrawlModelProtocol: class {
    func itemDownloaded(items: NSArray) // 한번 셋팅되면 못바꾸는 NSArray
}

class CrawlModel: NSObject {
    var delegate: CrawlModelProtocol!
    
    func dataCrawlingGame() { // String인 이유는 URL에 적으려고
      
        
        let mainURL = "https://kr.noxinfluencer.com/youtube-channel-rank/top-100-kr-gaming-youtuber-sorted-by-subs-weekly"
        let locations = NSMutableArray() // 바꿀 수 있는 NSMutableArray
        
//        let locationsAddress = NSMutableArray()
       
        guard let main = URL(string: mainURL) else {
            print("Error \(mainURL) doesnt seem to ba a valid URL")
            return
              
        }
        
        do{
   
            let htmlDatas = try String(contentsOf: main, encoding: .utf8)
            let doc = try HTML(html: htmlDatas, encoding: .utf8)
            // //*[@id="top_movies_main"]/div/table/tbody/tr[1]/td[3]/a --> title 가져옴
            var count = 1
            for title in doc.xpath("//*[@id='rank-table-body']/tr/td"){
              
                // for Console
              count += 1
                print( title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                
                
                // working
                let tempStr = " \(String(title.text!.trimmingCharacters(in: .whitespacesAndNewlines)))" // 번호 뒤에 문자열 붙이기
              
                locations.add(tempStr)
                if count == 30 {
                    break
                }
                
              
                
            }
            
            
        }catch let error{
            print("Error : \(error)")
        }
        
        // 동시 실행 만들어진것을 async 통해서 주는거. (만들어지는게 아니라.)
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
        
    }
    
  
      
    
}
