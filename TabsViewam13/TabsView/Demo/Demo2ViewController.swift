//
//  Demo2ViewController.swift
//  TabsView
//
//  Created by Derrick on 2021/03/02.
//

import UIKit
import Kanna

class Demo2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    //게임
    var getGameData:[String] = []
    var chanelGameName:[String] = []
    var subGame:[String] = []
    var viewsGame:[String] = []
    var imageUrlGame:[URL] = []
   
    //엔터
    var getEnterData:[String] = []
    var chanelEnterName:[String] = []
    var subEnter:[String] = []
    var viewsEnter:[String] = []
    var imageUrlEnter:[URL] = []
    
    
    //블로그
    var getBlogData:[String] = []
    var chanelBlogName:[String] = []
    var subBlog:[String] = []
    var viewsBlog:[String] = []
    var imageUrlBlog:[URL] = []
    
    
    //영화
    var getMovieData:[String] = []
    var chanelMovieName:[String] = []
    var subMovie:[String] = []
    var viewsMovie:[String] = []
    var imageUrlMovie:[URL] = []
    
    
    @IBOutlet weak var youtubeListView: UITableView!
    //-----------
    // Properties
    //------------
    
    var pageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        youtubeListView.delegate = self
        youtubeListView.dataSource = self
        youtubeListView.rowHeight = 110
        
        var count = 0 // 순위
        
        dataCrawlingGame()
        
        dataCrawlingEntertainment()
        
        dataCrawlingBlog()
        
        dataCrawlingMovie()
        
        // 게임
        
        // 채널명
        for i in 0..<5{
            count += 1
            print("\(count)위  : \(getGameData[(i*6)+1])")
            chanelGameName.append(getGameData[(i*6)+1])
            
        }
        // 구독자수
        for i in 0..<5{
            print("\(getGameData[(i*6)+3])")
            subGame.append(getGameData[(i*6)+3])
            
        }
        
        // 조회수
        for i in 0..<5{
            print("\(getGameData[(i*6)+4])")
            viewsGame.append(getGameData[(i*6)+4])
            
        }
        
        
        //엔터테인먼트
        
        // 채널명
        for i in 0..<5{
            count += 1
            print("\(count)위  : \(getEnterData[(i*6)+1])")
            chanelEnterName.append(getEnterData[(i*6)+1])
            
        }
        // 구독자수
        for i in 0..<5{
            print("\(getEnterData[(i*6)+3])")
            subEnter.append(getEnterData[(i*6)+3])
            
        }
        
        // 조회수
        for i in 0..<5{
            print("\(getEnterData[(i*6)+4])")
            viewsEnter.append(getEnterData[(i*6)+4])
            
        }
        
        //블로그
        
        // 채널명
        for i in 0..<5{
            count += 1
            print("\(count)위  : \(getBlogData[(i*6)+1])")
            chanelBlogName.append(getBlogData[(i*6)+1])
            
        }
        // 구독자수
        for i in 0..<5{
            print("\(getBlogData[(i*6)+3])")
            subBlog.append(getBlogData[(i*6)+3])
            
        }
        
        // 조회수
        for i in 0..<5{
            print("\(getBlogData[(i*6)+4])")
            viewsBlog.append(getBlogData[(i*6)+4])
            
        }
        
        //영화
        
        // 채널명
        for i in 0..<5{
            count += 1
            print("\(count)위  : \(getMovieData[(i*6)+1])")
            chanelMovieName.append(getMovieData[(i*6)+1])
            
        }
        // 구독자수
        for i in 0..<5{
            print("\(getMovieData[(i*6)+3])")
            subMovie.append(getMovieData[(i*6)+3])
            
        }
        
        // 조회수
        for i in 0..<5{
            print("\(getMovieData[(i*6)+4])")
            viewsMovie.append(getMovieData[(i*6)+4])
            
        }
    
        youtubeListView.reloadData()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       4
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
       
       return 5
   }
   
   
   
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = youtubeListView.dequeueReusableCell(withIdentifier: "youtubeCell", for: indexPath) as! YoutubeTableViewCell
       
   switch indexPath.section {
   case 0:
        //게임
       cell.lblYoutubeChanelName.text = "\(chanelGameName[indexPath.row])"
       cell.lblYoutubeNum.text = "\(indexPath.row+1)"
       cell.lblYoutubeSub.text = "\(subGame[indexPath.row])"
       cell.lblYoutubeViews.text = "\(viewsGame[indexPath.row])"

       if cell.lblYoutubeNum.text == "\(1)" {
           let firstColor = #colorLiteral(red: 0.8441851735, green: 0.6620926857, blue: 0.3147920668, alpha: 1)
           cell.lblYoutubeNum.textColor = firstColor
       }
       if cell.lblYoutubeNum.text == "\(2)" {
           let second = #colorLiteral(red: 0.3163542449, green: 0.3409048319, blue: 0.4538033605, alpha: 1)
           cell.lblYoutubeNum.textColor = second
       }
       if cell.lblYoutubeNum.text == "\(3)" {
           let third = #colorLiteral(red: 0.3884379268, green: 0.3042663336, blue: 0.1507078409, alpha: 1)
           cell.lblYoutubeNum.textColor = third
       }
       //이미지 URL 크롤링
       DispatchQueue.global().async { [self] in
           let data = try? Data(contentsOf: self.imageUrlGame[indexPath.row])
           DispatchQueue.main.async {
               cell.imgYoutube.image = UIImage(data: data!)
               cell.imgYoutube.layer.cornerRadius = cell.imgYoutube.frame.height/2
           }
       }
   case 1:
        //엔터테인먼트
       cell.lblYoutubeChanelName.text = "\(chanelEnterName[indexPath.row])"
       cell.lblYoutubeNum.text = "\(indexPath.row+1)"
       cell.lblYoutubeSub.text = "\(subEnter[indexPath.row])"
       cell.lblYoutubeViews.text = "\(viewsEnter[indexPath.row])"

       if cell.lblYoutubeNum.text == "\(1)" {
           let firstColor = #colorLiteral(red: 0.8441851735, green: 0.6620926857, blue: 0.3147920668, alpha: 1)
           cell.lblYoutubeNum.textColor = firstColor
       }
       if cell.lblYoutubeNum.text == "\(2)" {
           let second = #colorLiteral(red: 0.3163542449, green: 0.3409048319, blue: 0.4538033605, alpha: 1)
           cell.lblYoutubeNum.textColor = second
       }
       if cell.lblYoutubeNum.text == "\(3)" {
           let third = #colorLiteral(red: 0.3884379268, green: 0.3042663336, blue: 0.1507078409, alpha: 1)
           cell.lblYoutubeNum.textColor = third
       }
       //이미지 URL 크롤링
       DispatchQueue.global().async { [self] in
           let data = try? Data(contentsOf: self.imageUrlEnter[indexPath.row])
           DispatchQueue.main.async {
               cell.imgYoutube.image = UIImage(data: data!)
               cell.imgYoutube.layer.cornerRadius = cell.imgYoutube.frame.height/2
           }
       }
   case 2:
        //블로그
       cell.lblYoutubeChanelName.text = "\(chanelBlogName[indexPath.row])"
       cell.lblYoutubeNum.text = "\(indexPath.row+1)"
       cell.lblYoutubeSub.text = "\(subBlog[indexPath.row])"
       cell.lblYoutubeViews.text = "\(viewsBlog[indexPath.row])"

       if cell.lblYoutubeNum.text == "\(1)" {
           let firstColor = #colorLiteral(red: 0.8441851735, green: 0.6620926857, blue: 0.3147920668, alpha: 1)
           cell.lblYoutubeNum.textColor = firstColor
       }
       if cell.lblYoutubeNum.text == "\(2)" {
           let second = #colorLiteral(red: 0.3163542449, green: 0.3409048319, blue: 0.4538033605, alpha: 1)
           cell.lblYoutubeNum.textColor = second
       }
       if cell.lblYoutubeNum.text == "\(3)" {
           let third = #colorLiteral(red: 0.3884379268, green: 0.3042663336, blue: 0.1507078409, alpha: 1)
           cell.lblYoutubeNum.textColor = third
       }
       //이미지 URL 크롤링
       DispatchQueue.global().async { [self] in
           let data = try? Data(contentsOf: self.imageUrlBlog[indexPath.row])
           DispatchQueue.main.async {
               cell.imgYoutube.image = UIImage(data: data!)
               cell.imgYoutube.layer.cornerRadius = cell.imgYoutube.frame.height/2
           }
       }

   default:
        
        //영화
       cell.lblYoutubeChanelName.text = "\(chanelMovieName[indexPath.row])"
       cell.lblYoutubeNum.text = "\(indexPath.row+1)"
       cell.lblYoutubeSub.text = "\(subMovie[indexPath.row])"
       cell.lblYoutubeViews.text = "\(viewsMovie[indexPath.row])"

       if cell.lblYoutubeNum.text == "\(1)" {
           let firstColor = #colorLiteral(red: 0.8441851735, green: 0.6620926857, blue: 0.3147920668, alpha: 1)
           cell.lblYoutubeNum.textColor = firstColor
       }
       if cell.lblYoutubeNum.text == "\(2)" {
           let second = #colorLiteral(red: 0.3163542449, green: 0.3409048319, blue: 0.4538033605, alpha: 1)
           cell.lblYoutubeNum.textColor = second
       }
       if cell.lblYoutubeNum.text == "\(3)" {
           let third = #colorLiteral(red: 0.3884379268, green: 0.3042663336, blue: 0.1507078409, alpha: 1)
           cell.lblYoutubeNum.textColor = third
       }
       //이미지 URL 크롤링
       DispatchQueue.global().async { [self] in
           let data = try? Data(contentsOf: self.imageUrlMovie[indexPath.row])
           DispatchQueue.main.async {
               cell.imgYoutube.image = UIImage(data: data!)
               cell.imgYoutube.layer.cornerRadius = cell.imgYoutube.frame.height/2
           }
       }
       
   }

   
    
       return cell
   }
   
   
    
    // 헤더
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       switch section {
       case 0:
           return "게임"
       case 1:
           return "엔터테인먼트"
       case 2 :
           return "인물 / 블로그"
       
       default:
           return "영화 / 애니메이션"
           
       }
   }
   
   
 
   
   
   // 게임

   func dataCrawlingGame(){
       let mainURL = "https://kr.noxinfluencer.com/youtube-channel-rank/top-100-kr-gaming-youtuber-sorted-by-subs-weekly"
       guard let main = URL(string: mainURL) else {
           print("Error \(mainURL) doesnt seem to ba a valid URL")
           return
       }
       
       do{
           let htmlDatas = try String(contentsOf: main, encoding: .utf8)
           let doc = try HTML(html: htmlDatas, encoding: .utf8)
          
       
           var count = 1
           

           for title in
               doc.xpath("//*[@id='rank-table-body']/tr/td"){
               count += 1
               getGameData.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
               
               if count == 30 {
                   break
               }
           }
           count = 0
           for img in
               doc.xpath("//*[@id='rank-table-body']/tr/td/a"){

               if count % 2 == 0{
                   imageUrlGame.append(URL(string:(img.at_xpath("img")?["src"])!)!)
                   
               }
               count += 1
               if count == 10 {
                   break
               }
           }

           
       }catch let error{
           print("Error : \(error)")
       }
   }//--------
   
   
   
   // 엔터테인먼트

   func dataCrawlingEntertainment(){
       let mainURL = "https://kr.noxinfluencer.com/youtube-channel-rank/top-100-kr-entertainment-youtuber-sorted-by-subs-weekly"
       guard let main = URL(string: mainURL) else {
           print("Error \(mainURL) doesnt seem to ba a valid URL")
           return
       }
       
       do{
           let htmlDatas = try String(contentsOf: main, encoding: .utf8)
           let doc = try HTML(html: htmlDatas, encoding: .utf8)
          
       
           var count = 1
           

           for title in
               doc.xpath("//*[@id='rank-table-body']/tr/td"){
               count += 1
               getEnterData.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
               
               if count == 30 {
                   break
               }
           }
           count = 0
           for img in
               doc.xpath("//*[@id='rank-table-body']/tr/td/a"){

               if count % 2 == 0{
                   imageUrlEnter.append(URL(string:(img.at_xpath("img")?["src"])!)!)
                   
               }
               count += 1
               if count == 10 {
                   break
               }
           }

           
       }catch let error{
           print("Error : \(error)")
       }
   }//--------

   
   
   //블로그

   func dataCrawlingBlog(){
       let mainURL = "https://kr.noxinfluencer.com/youtube-channel-rank/top-100-kr-people%20%26%20blogs-youtuber-sorted-by-subs-weekly"
       guard let main = URL(string: mainURL) else {
           print("Error \(mainURL) doesnt seem to ba a valid URL")
           return
       }
       
       do{
           let htmlDatas = try String(contentsOf: main, encoding: .utf8)
           let doc = try HTML(html: htmlDatas, encoding: .utf8)
          
       
           var count = 1
           

           for title in
               doc.xpath("//*[@id='rank-table-body']/tr/td"){
               count += 1
               getBlogData.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
               
               if count == 30 {
                   break
               }
           }
           count = 0
           for img in
               doc.xpath("//*[@id='rank-table-body']/tr/td/a"){

               if count % 2 == 0{
                   imageUrlBlog.append(URL(string:(img.at_xpath("img")?["src"])!)!)
                   
               }
               count += 1
               if count == 10 {
                   break
               }
           }

           
       }catch let error{
           print("Error : \(error)")
       }
   }//------
   
   
   
   
   // 영화

   func dataCrawlingMovie(){
       let mainURL = "https://kr.noxinfluencer.com/youtube-channel-rank/top-100-kr-film%20%26%20animation-youtuber-sorted-by-subs-weekly"
       guard let main = URL(string: mainURL) else {
           print("Error \(mainURL) doesnt seem to ba a valid URL")
           return
       }
       
       do{
           let htmlDatas = try String(contentsOf: main, encoding: .utf8)
           let doc = try HTML(html: htmlDatas, encoding: .utf8)
          
       
           var count = 1
           

           for title in
               doc.xpath("//*[@id='rank-table-body']/tr/td"){
               count += 1
               getMovieData.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
               
               if count == 30 {
                   break
               }
           }
           count = 0
           for img in
               doc.xpath("//*[@id='rank-table-body']/tr/td/a"){

               if count % 2 == 0{
                   imageUrlMovie.append(URL(string:(img.at_xpath("img")?["src"])!)!)
                   
               }
               count += 1
               if count == 10 {
                   break
               }
           }

           
           
       }catch let error{
           print("Error : \(error)")
       }
   }//-------

    
    


}//------끝
