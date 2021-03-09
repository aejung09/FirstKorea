//
//  ViewController.swift
//  TabsView
//
//  Created by Derrick on 2021/03/02.
//

import UIKit
import Kanna
import CoreLocation
import GoogleSignIn

class ViewController: UIViewController,CLLocationManagerDelegate {
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLHeadingFilterNone
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        return manager
    }()
    let setTabsTimer: Selector = #selector(ViewController.timertabs)
    let changeLabelTimer: Selector = #selector(ViewController.changeLabel)
    
    //-----------
    // Properties
    //------------
    
    // --------------------현아-------------------------
    // 유저가 선택한 정보를 배열로 받아온다
    // 단, 받아오는 배열은 0,1 형태 0 == 선택안한거
    
    var userChoice = ["1","1","1","1","1","1"]
    // ---------------------------------------------------

    @IBOutlet weak var tabsView: TabsView!
    
    // ------------ 지석 ------------- //
    @IBOutlet weak var buttonMyLocation: UIButton! // 내위치 버튼
    @IBOutlet weak var labelTemperature: UILabel! // 현재 온도
    @IBOutlet weak var imageViewWeather: UIImageView! // 날씨 이미지
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    @IBOutlet weak var labelTodayCorona: UILabel! // 국내발생
    @IBOutlet weak var labelOverseasInflowCorona: UILabel! // 해외 유입
    
    // ------------ 지석 ------------- //

    var pageController: UIPageViewController!
    var currentIndex: Int = 0
 
    // -------------- 필드 변수 (지석) --------------
    
    // 코로나
    var baseData = "" // 기준 날짜
    var nationwideCorona:[String] = [] // 전국별 코로나 확진자 수
    var todayCorona:[String] = ["",""] // 0: 국내유입, 1: 해외유입
    
    // 날씨
    static var myLocation:[String] = ["",""] // [0:도/시], [1:군/구]
    var temperature:[String] = [] // 온도 [0:현재온도]
    var fineDust:[String] = [] // 미세먼지 [0:미세먼지], [1:초미세먼지], [2:오존]
    var weather:String = "" // 날씨정보
    var changLabelCheck = false
    var fineDustValue = 0
    var fineDustStr = ""
    var ultrafineDustValue = 0
    var ultrafineDustStr = ""
    

    // -------------- 필드 변수 (지석) --------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // ------- 지석 ------- //
        locationManager.startUpdatingLocation()// 위치정보 실행
        categoryTabStatusSelect(Share.userEmail) // 유저 탭 정보 가져오기
        weatherDataCrawling() // 날씨 크롤링
        coronaDataCrawling() // 코로나 크롤링
        weatherStatus() // 날씨 이미지 셋팅
        
        labelTemperature.text = "\(temperature[0]) 도"
        labelTodayCorona.text = todayCorona[0]
        labelOverseasInflowCorona.text = todayCorona[1]
        // 미세먼지 단위 자르기
        let fineDustStrIndex:String.Index = fineDust[0].index(fineDust[0].endIndex,offsetBy: -2)
        let fineDustValueIndex:String.Index = fineDust[0].index(fineDust[0].endIndex,offsetBy: -5)
        let ultrafineDustStrIndex:String.Index = fineDust[1].index(fineDust[1].endIndex,offsetBy: -2)
        let ultrafineDustValueIndex:String.Index = fineDust[1].index(fineDust[1].endIndex,offsetBy: -5)
        fineDustStr = "\(fineDust[0][fineDustStrIndex..<fineDust[0].endIndex])"
        fineDustValue = Int(fineDust[0][..<fineDustValueIndex])!
        ultrafineDustStr = "\(fineDust[1][ultrafineDustStrIndex..<fineDust[1].endIndex])"
        ultrafineDustValue = Int(fineDust[1][..<ultrafineDustValueIndex])!
        
        //print("ddd\(todayCorona[0])\(todayCorona[1])")
        
        var _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: setTabsTimer, userInfo: nil, repeats: false)
        
        // 배너
        var _ = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: changeLabelTimer, userInfo: nil, repeats: true)
        // ------- 지석 ------- //
    
        
    }
    // 다른창에서 다시 돌아올때 실행됨
    override func viewWillAppear(_ animated: Bool) {
        categoryTabStatusSelect(Share.userEmail) // 유저정보 가져오기
        var _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: setTabsTimer, userInfo: nil, repeats: false)

    }
    
    // 뷰디드 로드에 넣으면 파싱이 바로 안돼서 안뜸 0.1초후에 뜨게함.
    @objc func timertabs(){
        setupTabs()
        setupPageViewController()
    }
    
    // ---------------- 지석 배너 ---------------- //
    @objc func changeLabel(){
        if changLabelCheck{
            labelTitle.text = "코로나 일일확진자"
            labelFirst.text = "국내발생"
            labelSecond.text = "  해외유입"
            labelTodayCorona.text = todayCorona[0]
            labelOverseasInflowCorona.text = todayCorona[1]
            labelTodayCorona.font = labelTodayCorona.font.withSize(17)
            labelOverseasInflowCorona.font = labelTodayCorona.font.withSize(17)
            labelTodayCorona.textColor = UIColor.red
            labelOverseasInflowCorona.textColor = UIColor.red
            changLabelCheck = false
        }else{
            labelTitle.text = "오늘의 미세먼지"
            labelFirst.text = "미세먼지"
            labelSecond.text = "초미세먼지"
            labelTodayCorona.text = "\(fineDustValue) \(fineDustStr)"
            labelOverseasInflowCorona.text = "\(ultrafineDustValue) \(ultrafineDustStr)"
            labelTodayCorona.font = labelTodayCorona.font.withSize(12)
            labelOverseasInflowCorona.font = labelTodayCorona.font.withSize(12)
            changLabelCheck = true
            if fineDustStr == "좋음"{
                labelTodayCorona.textColor = UIColor.blue
            }else if fineDustStr == "보통"{
                labelTodayCorona.textColor = UIColor.green
            }else if fineDustStr == "나쁨"{
                labelTodayCorona.textColor = UIColor.orange
            }else{
                labelTodayCorona.textColor = UIColor.red
            }
            if ultrafineDustStr == "좋음"{
                labelOverseasInflowCorona.textColor = UIColor.blue
            }else if ultrafineDustStr == "보통"{
                labelOverseasInflowCorona.textColor = UIColor.green
            }else if ultrafineDustStr == "나쁨"{
                labelOverseasInflowCorona.textColor = UIColor.orange
            }else{
                labelOverseasInflowCorona.textColor = UIColor.red
            }
        }
        labelTitle.fadeTransition(1.0)
        labelFirst.fadeTransition(1.0)
        labelSecond.fadeTransition(1.0)
        labelTodayCorona.fadeTransition(1.0)
        labelOverseasInflowCorona.fadeTransition(1.0)
    }
    
    // ---------------- 지석 배너 ---------------- //

    
    func setupTabs() {
        // Add Tabs (Set 'icon'to nil if you don't want to have icons)
        tabsView.tabs = [
            Tab(icon: UIImage(systemName: "newspaper.fill"), title: "뉴스"),
            Tab(icon: UIImage(systemName: "play.rectangle.fill"), title: "유튜브"),
            Tab(icon: UIImage(systemName: "sportscourt.fill"), title: "스포츠"),
            Tab(icon: UIImage(systemName: "house.circle.fill"), title: "맛집"),
            Tab(icon: UIImage(systemName: "cart.fill"), title: "물가"),
            Tab(icon: UIImage(systemName: "cart.fill"), title: "코인")
        ]
        
        // Set TabMode to '.fixed' for stretched tabs in full width of screen or '.scrollable' for scrolling to see all tabs
        tabsView.tabMode = .fixed
        
        // TabView Customization
        tabsView.titleColor = .black
        tabsView.iconColor = .black
        tabsView.indicatorColor = .black
        
        tabsView.titleFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        tabsView.collectionView.backgroundColor = .lightGray
        
        // Set TabsView Delegate
        tabsView.delegate = self
        
        // Set the selected Tab when the app starts
        tabsView.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Refresh CollectionView Layout when you rotate the device
        tabsView.collectionView.collectionViewLayout.invalidateLayout()
    }
    func setupPageViewController() {
           // PageViewController
           self.pageController = storyboard?.instantiateViewController(withIdentifier: "TabsPageViewController") as! TabsPageViewController
           self.addChild(self.pageController)
           self.view.addSubview(self.pageController.view)
           
           // Set PageViewController Delegate & DataSource
           pageController.delegate = self
           pageController.dataSource = self
           
           // Set the selected ViewController in the PageViewController when the app starts
           pageController.setViewControllers([showViewController(0)!], direction: .forward, animated: true, completion: nil)
           
           // PageViewController Constraints
           self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               self.pageController.view.topAnchor.constraint(equalTo: self.tabsView.bottomAnchor),
               self.pageController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
               self.pageController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
               self.pageController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
           ])
           self.pageController.didMove(toParent: self)
       }
    // Show ViewController for the current position
    func showViewController(_ index: Int) -> UIViewController? {
        if (self.tabsView.tabs.count == 0) || (index >= self.tabsView.tabs.count) {
            return nil
        }
        
        currentIndex = index
        
        if index == 0 {
            
            if userChoice[0] == "1"{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "Demo1ViewController") as! Demo1ViewController
                contentVC.pageIndex = index
                return contentVC
            }else{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
                contentVC.pageIndex = index
                return contentVC
            }
            
        } else if index == 1 {
            if userChoice[1] == "1"{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "Demo2ViewController") as! Demo2ViewController
                contentVC.pageIndex = index
                return contentVC
            }else{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
                contentVC.pageIndex = index
                return contentVC
            }
        } else if index == 2 {
            if userChoice[2] == "1"{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "Demo3ViewController") as! Demo3ViewController
                contentVC.pageIndex = index
                return contentVC
            }else{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
                contentVC.pageIndex = index
                return contentVC
            }
        }  else if index == 3 {
            if userChoice[3] == "1"{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "Demo4ViewController") as! Demo4ViewController
                contentVC.pageIndex = index
                return contentVC
            }else{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
                contentVC.pageIndex = index
                return contentVC
            }
        }  else if index == 4 {
            if userChoice[4] == "1"{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "Demo5ViewController") as! Demo5ViewController
                contentVC.pageIndex = index
                return contentVC
            }else{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
                contentVC.pageIndex = index
                return contentVC
            }
        }  else if index == 5 {
            if userChoice[5] == "1"{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "Demo6ViewController") as! Demo6ViewController
                contentVC.pageIndex = index
                return contentVC
            }else{
                let contentVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
                contentVC.pageIndex = index
                return contentVC
            }
        }
        else {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "Demo1ViewController") as! Demo1ViewController
            contentVC.pageIndex = index
            return contentVC
        }
    }
}//---END
extension ViewController: TabsDelegate {
    func tabsViewDidSelectItemAt(position: Int) {
        // Check if the selected tab cell position is the same with the current position in pageController, if not, then go forward or backward
        if position != currentIndex {
            if position > currentIndex {
                self.pageController.setViewControllers([showViewController(position)!], direction: .forward, animated: true, completion: nil)
            } else {
                self.pageController.setViewControllers([showViewController(position)!], direction: .reverse, animated: true, completion: nil)
            }
            tabsView.collectionView.scrollToItem(at: IndexPath(item: position, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // return ViewController when go forward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        // Don't do anything when viewpager reach the number of tabs
        if index == tabsView.tabs.count {
            return nil
        } else {
            index += 1
            return self.showViewController(index)
        }
    }
    
    // return ViewController when go backward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        
        if index == 0 {
            return nil
        } else {
            index -= 1
            return self.showViewController(index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if completed {
                guard let vc = pageViewController.viewControllers?.first else { return }
                let index: Int
                
                index = getVCPageIndex(vc)
                
                tabsView.collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredVertically)
                // Animate the tab in the TabsView to be centered when you are scrolling using .scrollable
                tabsView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    // Return the current position that is saved in the UIViewControllers we have in the UIPageViewController
    func getVCPageIndex(_ viewController: UIViewController?) -> Int {
        switch viewController {
        case is Demo1ViewController:
            let vc = viewController as! Demo1ViewController
            return vc.pageIndex
        case is Demo2ViewController:
            let vc = viewController as! Demo2ViewController
            return vc.pageIndex
        case is Demo3ViewController:
            let vc = viewController as! Demo3ViewController
            return vc.pageIndex
        case is Demo4ViewController:
            let vc = viewController as! Demo4ViewController
            return vc.pageIndex
        case is Demo5ViewController:
            let vc = viewController as! Demo5ViewController
            return vc.pageIndex
        case is Demo6ViewController:
            let vc = viewController as! Demo6ViewController
            return vc.pageIndex
        case is DemoViewController:
            let vc = viewController as! DemoViewController
            return vc.pageIndex
        default:
            let vc = viewController as! Demo1ViewController
            return vc.pageIndex
        }
    }
    
    
    
    // --------------- 지석 함수 ---------------
    // 코로나 크롤링
    func coronaDataCrawling(){
        let mainURL = "http://ncov.mohw.go.kr/"
        print("왜?????")
        guard let main = URL(string: mainURL)else {
            print("Error \(mainURL) dosen't seem to be a valid URL")
            return
        }
        do{
            let htmlData = try String(contentsOf: main,encoding: .utf8)
            let doc = try HTML(html: htmlData, encoding: .utf8)
            
            // 기준 날짜
            for title in doc.xpath("//*[@class='livedate']"){
                baseData = title.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            // 국내확진, 해외유입
            print("^^^^^^^^^^^^^^^^^^^")
            todayCorona.removeAll()
            for title in doc.xpath("//*[@class='data']"){
                todayCorona.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                print(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            print("^^^^^^^^^^^^^^^^^^^")
            
            // 도/시 별 확진자 수
            var count = 0
            nationwideCorona.removeAll()
            for title in doc.xpath("///*[@id='main_maplayout']/button/span"){
                if count > 33{
                    nationwideCorona.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                }
                count += 1
            }
     
        }catch let error{
            print("error : \(error)")
        }
    }
    
    // %EB%82%A0%EC%94%A8 <- 날씨
    // 날씨 크롤링
    func weatherDataCrawling(){
        let locationEncode = ViewController.myLocation[1].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) // 현재 위치정보를 인코딩
        
        let mainURL = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+locationEncode!+"+%EB%82%A0%EC%94%A8"
        guard let main = URL(string: mainURL)else {
            print("Error \(mainURL) dosen't seem to be a valid URL")
            return
        }
        do{
            let htmlData = try String(contentsOf: main,encoding: .utf8)
            let doc = try HTML(html: htmlData, encoding: .utf8)
            
            for title in doc.xpath("//*[@class='livedate']"){
                baseData = title.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }

     
            // 온도
            temperature.removeAll()
            for title in doc.xpath(" //*[@class='todaytemp']"){
                print(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                temperature.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
            
            // 미세먼지
            fineDust.removeAll()
            for title in doc.xpath(" //*[@class='indicator']/dd"){
                print(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                fineDust.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            }
                
            print(" @@@@@@@@@@@@@@@@@@@@@@@@@ ")
            for title in doc.xpath("//*[@class='rain_rate']/span[@class='num']"){
                print(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            }
     
            // 현재 날씨
            
            for title in doc.xpath("//*[@class='today_area _mainTabContent']/div"){
                weather = (title.at_xpath("span")?["class"]! as Any) as! String
                print((title.at_xpath("span")?["class"]! as Any))
                break
            }

        }catch let error{
            print("error : \(error)")
        }
    }
    func weatherStatus(){
        imageViewWeather.tintColor = UIColor.black
        
        if weather == "ico_state ws1"{
            imageViewWeather.image = UIImage(systemName: "sun.max")
        }
        
        if weather == "ico_state ws2"{
            imageViewWeather.image = UIImage(systemName: "moon.stars.fill")
        }
        if weather == "ico_state ws3"{
            imageViewWeather.image = UIImage(systemName: "cloud.sun")
        }
        if weather == "ico_state ws4"{
            
        }
        if weather == "ico_state ws5"{
            
        }
        if weather == "ico_state ws6"{
            imageViewWeather.image = UIImage(systemName: "cloud.moon")
        }
        
        if weather == "ico_state ws7"{
            imageViewWeather.image = UIImage(systemName: "smoke")
        }
        if weather == "ico_state ws8"{
            
        }
        if weather == "ico_state ws9"{
            imageViewWeather.image = UIImage(systemName: "cloud.rain")
        }
        if weather == "ico_state ws15"{
            imageViewWeather.image = UIImage(systemName: "cloud.bolt.rain")
        }
        if weather == "ico_state ws17"{
            imageViewWeather.image = UIImage(systemName: "cloud.fog")
        }
        
        
    }
    // 위치 정보
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let location: CLLocation = locations[locations.count - 1]
        
        // 핸드폰 위치
        let coor = locationManager.location?.coordinate
        let longitude = coor?.longitude
        let latitude = coor?.latitude
        
//        let converter: LocationConverter = LocationConverter()
//        let (x, y): (Int, Int)
//            = converter.convertGrid(lon: longitude!, lat: latitude!)
        
        let findLocation: CLLocation = CLLocation(latitude: Double(latitude!), longitude: Double(longitude!))
        let geoCoder: CLGeocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") // Korea
        
        geoCoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (place, error) in
            if let address: [CLPlacemark] = place {
                print("시(도): \(String(describing: address.last?.administrativeArea))")
                print("구(군): \(String(describing: address.last?.locality))")
                ViewController.myLocation[0] = (address.last?.administrativeArea)!
                ViewController.myLocation[1] = (address.last?.locality)!
//                self.labelMyLocation.text = ViewController.myLocation[1]
//                self.abc()
                self.buttonMyLocation.setTitle(ViewController.myLocation[1], for: .normal)
       
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    // 관심사 정보 파싱
    
    // 유저탭 정보 가져오기
    func categoryTabStatusSelect(_ userId:String) {
        let urlPath = "http://127.0.0.1:8080/JSP/CategoryTabSelect.jsp?userid="+userId
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data,response, error) in // 네트워크에서 바로 파싱이됨.
            if error != nil {
                print("Failed to download data")
            }else{
                print("Data is downloading")
                self.categoryTabParser(data!)
                
            }
            
        }
        task.resume()
        
    }
    func categoryTabParser(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray // json model 탈피
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            print(jsonElement)
            if let coinTab = jsonElement["coinTab"] as? String,
               let famousRestaurantTab = jsonElement["famousRestaurantTab"] as? String,
               let newsTabs = jsonElement["newsTabs"] as? String,
               let priceTap = jsonElement["priceTap"] as? String,
               let sportTab = jsonElement["sportTab"] as? String,
               let youtubeTab = jsonElement["yutubeTab"] as? String{
                print("in if let")
//                news = newsTabs
//                sport = sportTab
//                youtube = youtubeTab
//                price = priceTap
//                famousRestaurant = famousRestaurantTab
//                coin = coinTab
                userChoice[0] = newsTabs
                userChoice[1] = youtubeTab
                userChoice[2] = sportTab
                userChoice[3] = famousRestaurantTab
                userChoice[4] = priceTap
                userChoice[5] = coinTab

            }
        }
       
    }
    
}
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
