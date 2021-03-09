//
//  Demo3ViewController.swift
//  TabsView
//
//  Created by Derrick on 2021/03/02.
//

import UIKit
import Kanna

class Demo3ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var TableViewSport: UITableView!
   
    // ------------ 태현 -------------
    var ufcPlayers:[String] = [] // 출력할 ufc 변수
    
    // ------------ 지석 -------------
    var getDataTeamTables:[String] = [] // 받아온 데이터
    var soccerTeamTables:[String] = [] // 받아온 데이터를 정리할 변수 ( 2020-2021 시즌 )
    var soccerTeamName:[String] = [] // 탑 5 팀 이름
    // ------------ 지석 -------------
    // ------------ 애정 -------------
    var getDataTables:[String] = [] // 받아온 데이터
    var basballTeamName:[String] = [] // 탑 5 팀 이름
    // ------------ 애정 -------------
    
    

    

    //-----------
    // Properties
    //------------
    
    var pageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // ---------- 지석 viewDidLoad ---------//
        
        soccerData() // 축구 데이터 크롤링후 정제
        
        // ---------- 지석 viewDidLoad ---------//
       
        // ---------- 애정 viewDidLoad ---------//
        
        baseballCrawling() // 축구 데이터 크롤링후 정제
        
        // ---------- 태현 viewDidLoad ---------//
        
        ufcCrawling()
        
        var count = 0
            
            for i in 0..<5{
                count += 1
                print("\(count)위  : \(getDataTables[(i*12)+1])")
                basballTeamName.append(getDataTables[(i*12)+1])
                
            }
         
        
        // ---------- 애정 viewDidLoad ---------//
        
    }
    
    
    
    // 테이블뷰 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // 테이블뷰 헤더
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "UFC" // 헤더 이름
        case 1:
            return "축구(프리미어리그 순위)"
        default:
            return "야구"
        }
    }
    
    // row 갯수 5위니까 5
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return 5
 
        
    }
    
    
    // 테이블값 셋팅
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = TableViewSport.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath)
        switch indexPath.section {
        // case 0 에다가 순위 넣으면됨 indexPath 0 ~ 4
        // UFC
        case 0:
                cell.textLabel?.text = "Champion.  \(ufcPlayers[indexPath.row])"
        // 축구
        case 1:
            cell.textLabel?.text = "\(indexPath.row+1).   \(soccerTeamName[indexPath.row])"
           
        // 야구
        default:
            cell.textLabel?.text = "\(indexPath.row+1). \(basballTeamName[indexPath.row])"
            
               
        }
        
        return cell
    }
    
    //  -------- UFC 선수 크롤링 -------- //
    
    
    func ufcCrawling(){
        let mainURL = "https://www.foxsports.com/ufc/rankings"
        guard let main = URL(string: mainURL)else {
            print("Error \(mainURL) dosen't seem to be a valid URL")
            return
        }
        do{
            
            let htmlData = try String(contentsOf: main,encoding: .utf8)
            let doc = try HTML(html: htmlData, encoding: .utf8)
            var count = 1
           
            for title in doc.xpath("//*[@id='wisbb_rankings']/div/div/table/tr[1]/td/span[2]/a"){

                ufcPlayers.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                count += 1
                if count == 7{
                    break
                }
            }

        }catch let error{
            print("error : \(error)")
        }
    }
    
    
    
    
    
    
    
    
    //  -------- 축구 크롤링 -------- //
    func soccerCrawling(){
        let mainURL = "https://www.premierleague.com/tables"
        guard let main = URL(string: mainURL)else {
            print("Error \(mainURL) dosen't seem to be a valid URL")
            return
        }
        do{
            let htmlData = try String(contentsOf: main,encoding: .utf8)
            let doc = try HTML(html: htmlData, encoding: .utf8)
          
            for title in doc.xpath("//*[@class='table wrapper col-12']/table/tbody/tr/td"){

                getDataTeamTables.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
           
            }

        }catch let error{
            print("error : \(error)")
        }
    }


    func soccerData(){
        soccerCrawling()
        for i in 0..<20{
            for j in 1..<10{
                soccerTeamTables.append(getDataTeamTables[(14*i)+j+1])
            }
        }
        
        for i in 0..<5{
            let index:String.Index = soccerTeamTables[i*9].index(soccerTeamTables[i*9].endIndex,offsetBy: -21)
            soccerTeamTables[(i*9)] = String(soccerTeamTables[(i*9)][...index])
            if soccerTeamTables[(i*9)] == "Manchester City"{
                soccerTeamTables[(i*9)] = "맨체스터 시티 FC"
            }
            if soccerTeamTables[(i*9)] == "Manchester United"{
                soccerTeamTables[(i*9)] = "맨체스터 유나이티드 FC"
            }
            if soccerTeamTables[(i*9)] == "Leicester City"{
                soccerTeamTables[(i*9)] = "레스터 시티 FC"
            }
            if soccerTeamTables[(i*9)] == "West Ham United"{
                soccerTeamTables[(i*9)] = "웨스트 햄 유나이티드 FC"
            }
            if soccerTeamTables[(i*9)] == "Chelsea"{
                soccerTeamTables[(i*9)] = "첼시 FC"
            }
            if soccerTeamTables[(i*9)] == "Liverpool"{
                soccerTeamTables[(i*9)] = "리버풀 FC"
            }
            if soccerTeamTables[(i*9)] == "Everton"{
                soccerTeamTables[(i*9)] = "에버턴 FC"
            }
            if soccerTeamTables[(i*9)] == "Tottenham Hotspur"{
                soccerTeamTables[(i*9)] = "토트넘 훗스퍼 FC"
            }
            if soccerTeamTables[(i*9)] == "Aston Villa"{
                soccerTeamTables[(i*9)] = "아스톤 빌라 FC"
            }
            if soccerTeamTables[(i*9)] == "Arsenal"{
                soccerTeamTables[(i*9)] = "아스널 FC"
            }
            if soccerTeamTables[(i*9)] == "Leeds United"{
                soccerTeamTables[(i*9)] = "리즈 유나이티드 FC"
            }
            if soccerTeamTables[(i*9)] == "Wolverhampton Wanderers"{
                soccerTeamTables[(i*9)] = "울버햄튼 원더러스 FC"
            }
            if soccerTeamTables[(i*9)] == "Crystal Palace"{
                soccerTeamTables[(i*9)] = "크리스탈 팰리스 FC"
            }
            if soccerTeamTables[(i*9)] == "Southampton"{
                soccerTeamTables[(i*9)] = "사우샘프턴 FC"
            }
            if soccerTeamTables[(i*9)] == "Burnley"{
                soccerTeamTables[(i*9)] = "번리 FC"
            }
            if soccerTeamTables[(i*9)] == "Brighton and Hove Albion"{
                soccerTeamTables[(i*9)] = "브라이튼 앤 호브 알비온 FC"
            }
            if soccerTeamTables[(i*9)] == "Newcastle United"{
                soccerTeamTables[(i*9)] = "뉴캐슬 유나이티드 FC"
            }
            if soccerTeamTables[(i*9)] == "Fulham"{
                soccerTeamTables[(i*9)] = "풀럼 FC"
            }
            if soccerTeamTables[(i*9)] == "West Bromwich Albion"{
                soccerTeamTables[(i*9)] = "웨스트 브로미치 앨비언 FC"
            }
            if soccerTeamTables[(i*9)] == "Sheffield United"{
                soccerTeamTables[(i*9)] = "셰필드 유나이티드 FC"
            }
            soccerTeamName.append(soccerTeamTables[(i*9)])
            
        }
        //  -------- 축구 크롤링 -------- //
    }
    
    //  -------- 야구 크롤링 -------- //
    func baseballCrawling(){
        let mainURL = "https://www.koreabaseball.com/TeamRank/TeamRank.aspx"
        
        guard let main = URL(string: mainURL)else {
            print("Error \(mainURL) dosen't seem to be a valid URL")
            return
        }
        do{
            let htmlData = try String(contentsOf: main,encoding: .utf8)
            let doc = try HTML(html: htmlData, encoding: .utf8)
            var count = 0
            
            for title in doc.xpath("//*[@id='cphContents_cphContents_cphContents_udpRecord']/table/tbody/tr/td"){
                count+=1
                print("\(count)."+title.text!.trimmingCharacters(in: .whitespacesAndNewlines)+"나야구")
                getDataTables.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                
            }

        }catch let error{
            print("error : \(error)")
        }
    }

}
