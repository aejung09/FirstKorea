//
//  Demo1ViewController.swift
//  TabsView
//
//  Created by Derrick on 2021/03/02.
//

import UIKit

class Demo1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    

    @IBOutlet weak var tableViewNews: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelSubject: UILabel!
    
    
    var newsData : Array<Dictionary<String,Any>>?
    var newsGenre = ["business","entertainment","science","sports","technology"]
    var genreSubject = ["비즈니스","연예","과학","스포츠","과학/기술"]
    let defaultColor = #colorLiteral(red: 0.4645312428, green: 0.6098279953, blue: 0.8870525956, alpha: 1)
    var pageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNews.delegate = self
        tableViewNews.dataSource = self
        view.backgroundColor = defaultColor
        
        pageControl.numberOfPages = newsGenre.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = defaultColor
     
        getNews(currentPage: 0)
        labelSubject.text = genreSubject[0]
        labelSubject.textColor = UIColor.white

    }
    
    
    @IBAction func pageControll(_ sender: UIPageControl) {
        getNews(currentPage: pageControl.currentPage)
        labelSubject.text = genreSubject[sender.currentPage]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsData != nil{
            //5개만 보이게
            return 5
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewNews.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        let newsIndex = indexPath.row
        //json 배열안에 제목 뽑아 테이블에 넣기
        if let news = newsData{
            let row = news[newsIndex]
            if let r = row as? Dictionary<String,Any> {
                if let title = r["title"] as? String{
                    cell.textLabel!.text = title
                }
            }
        }
        
       return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard.init(name:"Main", bundle: nil)
//        let newsDetail = storyboard.instantiateViewController(identifier: "NewsDetailController") as! NewsDetailController
//        if let news = newsData{
//            let row = news[indexPath.row]
//            if let r = row as? Dictionary<String,Any> {
//                if let imageURL = r["urlToImage"] as? String{
//                    newsDetail.imageURL = imageURL
//                }
//            }
//        }
//
//        if let news = newsData{
//            let row = news[indexPath.row]
//            if let r = row as? Dictionary<String,Any> {
//                if let desc = r["description"] as? String{
//                    newsDetail.desc = desc
//                }
//            }
//        }
//
//
//
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsDetail"{
            let newsDetail = segue.destination as! NewsDetailController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableViewNews.indexPath(for: cell)
            //json 배열안에 urlImage 뽑아 세그로 보내기
            if let news = newsData{
                let row = news[(indexPath! as NSIndexPath).row]
                if let r = row as? Dictionary<String,Any> {
                    if let imageURL = r["urlToImage"] as? String{
                        newsDetail.imageURL = imageURL
                    }
                }
            }
            //json 배열안에 기사내용 뽑아 세그로 보내기
            if let news = newsData{
                let row = news[(indexPath! as NSIndexPath).row]
                if let r = row as? Dictionary<String,Any> {
                    if let desc = r["description"] as? String{
                        newsDetail.desc = desc
                    }
                }
            }
           
            
    
        }
    
    }
    
    
    
    
    func getNews(currentPage: Int){
        //Api주소 받은거 파싱하기
        let task = URLSession.shared.dataTask(with: URL(string: "http://newsapi.org/v2/top-headlines?country=kr&category=\(newsGenre[currentPage])&apiKey=bb8ee225a55d4465903b8c797d07ec5f")!) { (data, response,error) in
            if let dataJson = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String,Any>
                  
                    let articles = json["articles"] as? Array<Dictionary<String,Any>>
                    self.newsData = articles
                    DispatchQueue.main.async {
                        self.tableViewNews.reloadData()
                    }
       
                }
                catch {
                    
                }
            }
       
        }
        task.resume()
    }
    
}
