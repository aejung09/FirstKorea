//
//  Demo4ViewController.swift
//  TabsView
//
//  Created by nina on 2021/03/04.
//

import UIKit

class Demo4ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FoodJsonModelProtocol  {
    var pageIndex: Int!
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet var foodListTableView: UITableView!
    var feedItem: NSArray = NSArray()
    let rank: NSArray = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.foodListTableView.delegate = self
        self.foodListTableView.dataSource = self
        
        
        let foodJsonModel = FoodJsonModel()
        foodJsonModel.delegate = self
        foodJsonModel.downloadItems()
        
        
        
        
        // 그림 크기
        foodListTableView.rowHeight = 202 // Cell 높이. <----------- 중요
    }
    
    
    @IBAction func btnSearch(_ sender: UIButton) {
        let foodJsonModel = FoodJsonModel()
        foodJsonModel.delegate = self
        foodJsonModel.searchItems(input: (self.tfSearch.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    }
    
    func itemDownloaded(items: NSArray) {
        // items == location
        feedItem = items
        self.foodListTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell

        // Configure the cell...
        // 셀 구성 정해주기
        let item: FoodDBModel = feedItem[indexPath.row] as! FoodDBModel
       
        
        cell.lblRank?.text = rank[indexPath.row] as! String
        cell.lblStoreName?.text = "\(item.storeName!)"
        cell.lblStoreScore?.text = "\(item.storeScore!)"
        cell.lblStoreCategory?.text = "\(item.storeCategory!)"
        cell.lblPriceRange?.text = "\(item.priceRange!)"
        cell.lblStoreAddress?.text = "\(item.storeAddress!)"
       
//        loadImage(imageView: cell.ivStoreImage, urlPath: item.storeImage!)
        
        let url = URL(string: item.storeImage!)
        let data = try? Data(contentsOf: url!)
        cell.ivStoreImage.image = UIImage(data: data!)
        
        return cell
    }
    
    func loadImage(imageView: UIImageView, urlPath: String){
        print("url경로--------\(urlPath)")
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloading")
                DispatchQueue.main.async {
                   imageView.image = UIImage(data: data!)
                    // png
//                    if let image = UIImage(data: data!){
//                        if let data = image.pngData(){
//                            let filename = self.getDocumentDirectory().appendingPathComponent("copy.png")
//                            try? data.write(to: filename)
//                        }
//                    }
                    // jpg
                    if let image = UIImage(data: data!){
                        if let data = image.jpegData(compressionQuality: 0.8){
                            let filename = self.getDocumentDirectory().appendingPathComponent("copy.png")
                            try? data.write(to: filename)
                            print("Data is writed")
                            print(self.getDocumentDirectory()) // write 위치 알기
                        }
                    }
                } // async End.
            } // else End.
        } // task End.
        task.resume()
    }
    
    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
