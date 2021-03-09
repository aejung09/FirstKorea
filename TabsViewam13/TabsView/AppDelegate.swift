//
//  AppDelegate.swift
//  TabsView
//
//  Created by Derrick on 2021/03/02.
//

import UIKit
import KakaoSDKCommon
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate  {


    
    
    //-----------
    // Properties. - 태현 21.03.04
    //-----------
    
    // google login 추가
    // User 정보를 서버로 부터 가져올경우 다음 싱글톤 객체 사용 (user.profile.suerId 등등)
    public static var user: GIDGoogleUser!
    
    
    // MARK: KAKAO API - 태현 21.03.04
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        KakaoSDKCommon.initSDK(appKey: "1ec014675519465a29fcdd9fdd20a5f6")
        
        // OAuth 2.0 클라이언트 ID
        FirebaseApp.configure()
               
        GIDSignIn.sharedInstance()?.clientID = "359705597439-tcllj189ncc6tqhuii5cet329cs5ej4f.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }

    //-------------------------------------------------------
    
    // MARK: Google API - 태현 21.03.04
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return (GIDSignIn.sharedInstance()?.handle(url))!
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("not signed in before or signed out")
            } else {
                print(error.localizedDescription)
            }
        }
        // singleton 객체 - user가 로그인을 하면, AppDelegate.user로 다른곳에서 사용 가능
        AppDelegate.user = user
        
        return
    }
    
    //-------------------------------------------------------

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

