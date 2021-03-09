//
//  LoginViewController.swift
//  TabsView
//
//  Created by TJ on 2021/03/04.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn

class LoginViewController: UIViewController, DbLoginCheckProtocol, GIDSignInDelegate{

    

    
    
    
    
    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    @IBOutlet weak var btnTabAutoLogin: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnFindId: UIButton!
    @IBOutlet weak var btnFindPw: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnKakaoLogin: UIButton!
    


    
    let rightButton  = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard !UserDefaults.standard.bool(forKey: "autoLogin") else {
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
            return
        }
        
        // 버튼 라운드
        btnLogin.layer.masksToBounds = true
        btnLogin.layer.cornerRadius = 15
        
        rightButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
        tfPw.rightViewMode = .always
        tfPw.rightView = rightButton
        self.rightButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        
        

 
        // 로그인
        //GIDSignIn.sharedInstance()?.signIn()
        // 로그아웃
        //GIDSignIn.sharedInstance()?.signOut()
        // 연동 해제
        //GIDSignIn.sharedInstance()?.disconnect()
        //------------
    }
    
    @objc
        func onTapButton() {
            print("Button was tapped.")
            if tfPw.isSecureTextEntry{
                tfPw.isSecureTextEntry = false
                rightButton.setImage(UIImage(systemName: "eye"), for: .normal)
            }else{
                tfPw.isSecureTextEntry = true
                rightButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                
            }
        }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnTabAutoLogin(_ sender: UIButton) {
        sender.isSelected.toggle()
        print(sender.isSelected)
        // true 일 때 : 색칠된 체크박스
        // false일 때 : 색칠안된 체크박스
    }
    
    
    // 로그인 버튼
    @IBAction func btnLogin(_ sender: UIButton) {
        let inputId = tfId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputPw = tfPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isValidEmail(testStr: inputId){
            let dbLoginCheck = DBLoginCheck()
            dbLoginCheck.delegate = self
            dbLoginCheck.check(id: inputId, pw: inputPw)
        }else{
            let emailAlert = UIAlertController(title: "오류", message: "이메일 형식이 아닙니다.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            emailAlert.addAction(okAction)
            present(emailAlert, animated: true, completion: nil)
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
    }
    
    
    func loginResult(result: Int) {
        print(result)
        switch result {
        case 1:
            print("로그인 성공")
            if btnTabAutoLogin.isSelected {
                UserDefaults.standard.set(true, forKey: "autoLogin")
            }
            // share에 아이디 저장
            Share.userEmail = self.tfId.text!
            
            // 메인으로 이동
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
            
            break
        case 0:
            print("비밀번호 틀림")
            let resultAlert = UIAlertController(title: "실패", message: "비밀번호를 다시 입력해주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                self.tfPw.becomeFirstResponder()
                
            })
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
            break
        case -1:
            print("아이디 없음")
            let resultAlert = UIAlertController(title: "실패", message: "존재하지 않는 아이디입니다", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                self.tfId.becomeFirstResponder()
                
            })
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    
    // 아이디 찾기
    @IBAction func btnFindId(_ sender: UIButton) {
    }
    
    // 비밀번호 찾기
    @IBAction func btnFindPw(_ sender: UIButton) {
    }
    
    // 회원가입
    @IBAction func btnSignIn(_ sender: UIButton) {
    }
    
    
    // MARK: KAKAO Login
    // 21.03.04 - 태현
//    @IBAction func btnKakaoLogin(_ sender: UIButton) {
//        
//        // 카카오톡 설치 여부 확인
//         if (AuthApi.isKakaoTalkLoginAvailable()) {
//             AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                 if let error = error {
//                     // 예외 처리 (로그인 취소 등)
//                     print(error)
//                 }
//                 else {
//                     print("loginWithKakaoTalk() success.")
//                     // do something
//                     _ = oauthToken
//                     // 어세스토큰
//                     let accessToken = oauthToken?.accessToken
//                     
//                     //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
//                     self.setUserInfo()
//                    // 메인으로 이동
//                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
//                 }
//             }
//         }
//         
//        // 앱 없을 경우 웹을 통한 카카오 계정 로그인
//        else{
//            AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//               if let error = error {
//                 print(error)
//               }
//               else {
//                print("loginWithKakaoAccount() success.")
//
//                //do something
//                _ = oauthToken
//                // 메인으로 이동
//                self.performSegue(withIdentifier: "loginSuccess", sender: self)
//               }
//            }
//         }
//      
//    }
    // KAKAO User Id 받아오기
    // 21.03.04 - 태현
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                Share.userEmail = (user?.kakaoAccount?.email)!

                // Id 값 가져옴
               // var userID = user?.kakaoAccount?.profile?.nickname
                // 프로필 사진 불러오기
//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                   var profileImage =  UIImage(data: data)
                }
            }
        }
    
//---------------------------------------------------
    
    // MARK: Google Login

    // 구글 로그인 버튼 설정
    @IBAction func buttonGoogleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
                GIDSignIn.sharedInstance().delegate=self
                GIDSignIn.sharedInstance().signIn()
    }
    
    // 연동을 시도 했을때 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }

        // 사용자 정보 가져오기
        if let userId = user.userID,                  // For client-side use only!
            let email = user.profile.email {
            Share.userEmail = email
            // 메인으로 이동
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
            
            } else {
            print("Error : User Data Not Found")
        }
    }
        
    // 구글 로그인 연동 해제했을때 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }

    
    @IBAction func unwindLogOut (segue : UIStoryboardSegue) {
        tfId.text = ""
        tfPw.text = ""
        tfId.becomeFirstResponder()
    }
    @IBAction func unwindSecede (segue : UIStoryboardSegue) {
        tfId.text = ""
        tfPw.text = ""
        tfId.becomeFirstResponder()
    }
    
    @IBAction func unwindLogin (segue : UIStoryboardSegue) {

    }
    
   

    
} // ----
