//
//  AppDelegate.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/18.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var m_bIsUpdating = false;
    
    fileprivate func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        
        let nvc: UINavigationController = UINavigationController(rootViewController: vc)
        
        
        
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: menuVC)
        
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
        self.createMenuView()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        self.silentLogin()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func silentLogin() -> Void
    {
        if self.m_bIsUpdating
        {
            //still in update status
            print("still updating")
            return
        }
        
        if let data = UserDefaults.standard.data(forKey: "account"),
            let myAccountList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Account]
        {
            let account:Account = myAccountList[0]
            
            
            //current timestamp
            let dTimeStamp:Double = NSDate().timeIntervalSince1970
            //print("current : \(dTimeStamp)")
            
            
            let diff = account.m_dExp - dTimeStamp
            
            //剩不到五分鐘
            if  diff < ( 300 )
            {
                print("剩不到五分鐘")
                //need update
                m_bIsUpdating = true
                
                let strServer = Constants.API_SERVER
                let strModule = ""
                let strFormat = "%@%@"
                
                let parameters: Parameters = ["name":account.m_pUserName, "pwd":account.m_pUserPassword]
                
                let strApiUrl:String = String.init(format: strFormat, locale: nil,  strServer, strModule)
                
                Alamofire.request(strApiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
                    .responseJSON { response in
                        
                        self.m_bIsUpdating = false
                        if let dic:[String:Any]  = response.result.value as! [String:Any]?
                        {
                            if let tokenDic:[String:Any] = (dic["token"] as? [String:Any])
                            {
                                print("tokenDic : \(tokenDic)")
                                
                                //save data
                                
                                let exp:Double = tokenDic["exp"] as! Double
                                let token:String = tokenDic["token"] as! String
                                
                                let newAccount:Account = Account.init(name: account.m_pUserName, password: account.m_pUserPassword, exp: exp, token: token)
                                var account = [Account]()
                                account.append(newAccount)
                                let encodedData = NSKeyedArchiver.archivedData(withRootObject: account)
                                UserDefaults.standard.set(encodedData, forKey: "account")
                
                            }
                            else
                            {
                                //login error
                            }
                        }
                        
                }

                
                
            }
        }

        
    }

}

