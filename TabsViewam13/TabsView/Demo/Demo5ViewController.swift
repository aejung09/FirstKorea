//
//  Demo5ViewController.swift
//  TabsView
//
//  Created by dev on 2021/03/04.
//

import UIKit
import Kanna

// 물가탭 작업자 : 최현아

class Demo5ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var pageIndex: Int!

 
    @IBOutlet weak var cartTable: UITableView!
  
    @IBOutlet weak var uptext: UILabel!

    @IBOutlet weak var uppercent: UILabel!

    @IBOutlet weak var downtext: UILabel!
    

    @IBOutlet weak var downpercent: UILabel!
    
    var list:[String] = ["쌀 (20kg)", "찹쌀 (1kg)", "흰 콩(국산)(500g) 상", "흰 콩(국산)(500g) 중", "붉은 팥(국산)(500g)", "녹두 국산(500g)", "고구마 (1kg) 상", "고구마 (1kg) 중", "감자 수미(100g) 상", "감자 수미(100g) 중", "감자 대지마(100g)", "배추 월동(1포기) 상", "배추 월동(1포기) 중", "양배추(1포기) 상", "양배추(1포기) 중", "시금치(1kg)", "상추 적(100g) 상", "상추 적(100g) 중", "상추 청(100g) 상", "상추 청(100g) 중", "얼갈이배추(1kg)", "수박(1개) 상", "수박(1개) 중", "오이 가시계통(10개)", "오이 다다기계통(10개) 상", "오이 다다기계통(10개) 중", "취청(10개)", "애호박(1개) 상", "애호박(1개) 중", "쥬키니(1개)", "토마토(1kg)", "딸기(100g) 상", "딸기(100g) 중", "무 월동(1개) 상", "무 월동(1개) 중", "당근 무세척(1kg) 상", "당근 무세척(1kg) 중", "열무(1kg)", "건고추 화건(600g) 상", "건고추 화건(600g) 중", "건고추 양건(600g) 상", "건고추 양건(600g) 중", "풋고추(100g)", "꽈리고추(100g) 상", "꽈리고추(100g) 중", "청양고추(100g) 상", "청양고추(100g) 중", "붉은고추(100g) 상", "붉은고추(100g) 중", "양파(1kg) 상", "양파(1kg) 중", "대파(1kg) 상","대파(1kg) 중", "쪽파(1kg) 상", "쪽파(1kg) 중", "생강 국산(1kg) 상", "생강 국산(1kg) 중", "고춧가루 국산(1kg)", "고춧가루 중국(1kg)", "미나리(100g)", "깻잎(100g) 상", "깻잎(100g) 중", "피망 청(100g) 상", "피망 청(100g) 중", "파프리카(200g) 상", "파프리카(200g) 중", "멜론(1개) 상", "멜론(1개) 중", "깐마늘(국산)(1kg) 상", "깐마늘(국산)(1kg) 중", "참깨 백색(국산)(500g)", "참깨 중국(500g)", "참깨 인도(500g)", "참깨 국산(100g)", "참깨 수입(100g)", "느타리버섯(100g) 상", "느타리버섯(100g) 중", "애느타리버섯(100g) 상", "애느타리버섯(100g) 중","팽이버섯(150g) 상", "팽이버섯(150g) 중","새송이버섯(100g) 상", "새송이버섯(100g) 중", "호두 수입(100g)", "아몬드 수입(100g)", "사과(10개) 상", "사과(10개) 중","배(10개) 상","배(10개) 중", "샤인머스켓(2kg)", "노지(10개) M과", "노지(10개) S과","단감(10개) 상", "단감(10개) 중", "바나나 (100g) 상", "바나나 (100g) 중",  "참다래 국산(10개) 상", "참다래 국산(10개) 중", "파인애플 수입(1개) 상", "파인애플 수입(1개) 중","오렌지 네이블 미국(10개) 상", "오렌지 네이블 미국(10개) 중", "방울토마토(1kg)", "대추방울토마토(1kg)", "레몬 수입(10개) 상", "레몬 수입(10개) 중",  "건포도 수입(100g)", "건블루베리 수입(100g)", "망고 수입(1개)", "한우등심(100g)1등급", "한우등심(100g)1+등급", "한우양지(100g) 1등급", "한우양지(100g) 1+등급", "한우안심(100g) 1등급","한우안심(100g) 1+등급", "한우설도(100g) 1등급", "한우설도(100g) 1+등급", "미국산갈비(100g)", "미국산갈비살(100g)", "호주산갈비(100g) 냉장", "호주산갈비(100g) 냉동", "삼겹살(국산냉장)(100g)", "삼겹살(수입냉동)(100g)", "목살(100g)", "돼지갈비(100g)", "앞다리살(100g)", "도계(1kg)", "특란(30개)", "특란(소비쿠폰 적용)(30개)", "우유(1리터)", "생선(1마리)", "냉동(1마리)", "염장(2마리)", "냉동(수입)(5마리)", "생선(1마리)", "냉동(1마리)", "냉동(1마리)", "생선(1마리)", "냉동(1마리)", "건멸치(100g)", "건오징어(10마리)", "마른김(10장)", "얼구운김(10장)", "건미역(100g)", "굴(1kg)", "부세수입(냉동)(1마리)", "새우젓(1kg)", "멸치액젓(1kg)", "굵은소금(5kg)", "전복(5마리)", "흰다리(수입)(10마리)"]
    var list2:[String] = []
    var list3:[String] = []
    var list4:[Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartCrawling()
        print(list.count)
        print(list2.count)
        print(list3.count)
        print(list4)
        
        cartTable.rowHeight = 70
        
        var uppercent1 = list4.max()
        var uppercent_index1 = list4.index(of:list4.max()!)
     
        var downpercent1 = list4.min()
        
        var downpercent_index1 = list4.index(of:list4.min()!)
    
        uppercent.text = String(format: "%.2f", list4.max()!)+"%"
        downpercent.text = String(format: "%.2f", list4.min()!)+"%"
        
        uptext.text = String(list[uppercent_index1!] + " / " + list2[uppercent_index1!] + "원")
        downtext.text = String(list[downpercent_index1!] + " / " + list2[downpercent_index1!] + "원")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartListTableViewCell

        
        //@IBOutlet weak var cartImage: UIImageView!
      
        if list4[indexPath.row] > 0{
            cell.cartHowmuch.textColor = UIColor.red
            cell.cartImage.text = "▲"
            cell.cartImage.textColor = UIColor.red
            //cell.cartImage.tintColor = UIColor.red
            
        }else if list4[indexPath.row] == 0{
            cell.cartHowmuch.textColor = UIColor.gray
            cell.cartImage.text = "-"
            cell.cartImage.textColor = UIColor.gray
        }
        else{
            cell.cartHowmuch.textColor = UIColor.blue
            cell.cartImage.text = "▼"
            cell.cartImage.textColor = UIColor.blue
            //cell.cartImage.tintColor = UIColor.blue
        }
        
        
            cell.CartWhat.text = "\(list[indexPath.row])"
            cell.cartWon.text = "\(list2[indexPath.row])"+"원"
            cell.cartHowmuch.text = String(format: "%.2f", list4[indexPath.row])+"%"
            
        return cell
    }
    
    
    
    
    func cartCrawling(){
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var current_date_string = formatter.string(from: Date())
        print(current_date_string)
        
        let mainURL = "https://www.kamis.or.kr/customer/price/retail/catalogue.do?action=daily&regday=2021-03-04&countycode=&itemcategorycode=&convert_kg_yn=N"
        guard let main = URL(string: mainURL)else {
            print("Error \(mainURL) dosen't seem to be a valid URL")
            return
        }
        do{
            let htmlData = try String(contentsOf: main,encoding: .utf8)
            let doc = try HTML(html: htmlData, encoding: .utf8)
            
            for title2 in doc.xpath("//*[@id='itemTable_1']/tr/td[4]"){

                //if title2.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "-"{
                   // list2.append("1")
                //}
                //else{
                    list2.append(contentsOf: [title2.text!.trimmingCharacters(in: .whitespacesAndNewlines)])
                //}
               
            }

            for title3 in doc.xpath("//*[@id='itemTable_1']/tr/td[8]"){

               // if title3.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "-"{
                   // list3.append("1")
                //}
               // else{
                    list3.append(contentsOf: [title3.text!.trimmingCharacters(in: .whitespacesAndNewlines)])
               // }
            }

            for i in 0...150{
                
                print(list[i]+","+list2[i]+","+list3[i])
                print("------------------------------------------------")
                print (list2[i])
                if (list2[i] == "-" || list3[i] == "-"){
                    list4.append(0)
                }else{
                    var num1 = Double(list2[i].replacingOccurrences(of: ",", with: "") )!
                    var num2 = Double(list3[i].replacingOccurrences(of: ",", with: "") )!
                    
                    
                    list4.append(Double((num1-num2)/num1*100))
                }
            }
        }catch let error{
            print("error : \(error)")
        }
    }
    
    // 테이블뷰 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // row 갯수 5위니까 5
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 151

    }
    
}
