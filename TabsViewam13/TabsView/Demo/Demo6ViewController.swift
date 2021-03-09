//
//  Demo6ViewController.swift
//  TabsView
//
//  Created by dev on 2021/03/04.
//

import UIKit
import Kanna

class Demo6ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableViewMain: UITableView!
    
    var pageIndex: Int!
    
    var coinPrice = [""]
    var coinName = [""]
    var coinOneDay = [""]
    
    var coinOneWeek = [""]
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        tableViewMain.rowHeight = 100
        coinName.remove(at: 0)
        coinPrice.remove(at: 0)
        coinOneDay.remove(at: 0)
       
        coinOneWeek.remove(at: 0)
       
        
        for i in 1...10{
            coinCrawling(rank:i)
        }
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "myCoinCell", for: indexPath) as! CoinTableViewCell
        let coinIndex = indexPath.row
        //json 배열안에 제목 뽑아 테이블에 넣기
        if coinOneDay[coinIndex].hasPrefix("▼"){
            cell.oneDay.textColor = UIColor.red
        }else{
            cell.oneDay.textColor = UIColor.green
        }
        if coinOneWeek[coinIndex].hasPrefix("▼"){
            cell.oneWeek.textColor = UIColor.red
        }else{
            cell.oneWeek.textColor = UIColor.green
        }
        
        cell.coinName.text = coinName[coinIndex]
        cell.coinPrice.text = coinPrice[coinIndex]
        cell.oneDay.text = coinOneDay[coinIndex]
        cell.oneWeek.text = coinOneWeek[coinIndex]
       return cell
    }
        
    

    func coinCrawling(rank: Int){
        let mainURL = "https://coinmarketcap.com/ko/"
        guard let main = URL(string: mainURL) else{//사이트 구동되는지 아닌지 파악
            print("Error \(mainURL) doesn't seem to be a valid URL")
            return
        }

        do{
            let htmlData = try String(contentsOf: main)
            let doc = try HTML(html: htmlData, encoding: .utf8)

            for coinPrice in
                doc.xpath("//*[@id='__next']/div/div[2]/div/div/div[2]/table/tbody/tr[\(rank)]/td[4]/div/a"){
                self.coinPrice.append(coinPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                

            }
            for coinName in
                doc.xpath("//*[@id='__next']/div/div[2]/div/div/div[2]/table/tbody/tr[\(rank)]/td[3]/a/div/div/p"){
                self.coinName.append(coinName.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                
            }

            for coinOneDay in
                doc.xpath("//*[@id='__next']/div/div[2]/div/div/div[2]/table/tbody/tr[\(rank)]/td[5]/span"){
                print("name",":",coinOneDay.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                
                if coinOneDay.at_xpath("span")?["class"]! as Any as! String == "icon-Caret-down"{
                    self.coinOneDay.append("▼ \(coinOneDay.text!.trimmingCharacters(in: .whitespacesAndNewlines))")
                }else{
                    self.coinOneDay.append("▲ \(coinOneDay.text!.trimmingCharacters(in: .whitespacesAndNewlines))")
                }
                
            }

            for coinOneWeek in
                doc.xpath("//*[@id='__next']/div/div[2]/div/div/div[2]/table/tbody/tr[\(rank)]/td[6]/span"){
                if coinOneWeek.at_xpath("span")?["class"]! as Any as! String == "icon-Caret-down"{
                    self.coinOneWeek.append("▼ \(coinOneWeek.text!.trimmingCharacters(in: .whitespacesAndNewlines))")
                }else{
                    self.coinOneWeek.append("▲ \(coinOneWeek.text!.trimmingCharacters(in: .whitespacesAndNewlines))")
                }
            }
            
            
        
          

        }catch let error{
            print("error : \(error)")
        }

    }
    
    
  
    
    
    
   
}
