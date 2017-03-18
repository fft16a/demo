//
//  ViewController.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/18.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    
    
    @IBOutlet weak var m_pTFMemberName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationLogout), name: Constants.POST_NOTIFICATION_LOGOUT, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationList), name: Constants.POST_NOTIFICATION_LIST, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        

        if let data = UserDefaults.standard.data(forKey: "account"),
            let myAccountList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Account] {
            myAccountList.forEach({print( $0.m_pUserName, $0.m_pUserPassword, $0.m_dExp, $0.m_pToken)})
        }
        else
        {
            print("尚未登入")
            
            self.showLoingView()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: IBAction
    @IBAction func pressMenu(_ sender: Any)
    {
        self.slideMenuController()?.openLeft()
    }
    
    
    @IBAction func pressAddMember(_ sender: Any)
    {
        let name:String = self.m_pTFMemberName.text!
        
        if  name.isEmpty == true
        {
            self.view.makeToast(NSLocalizedString("please enter name", comment: ""),
                                duration: 1.0,
                                position: .center)
            self.m_pTFMemberName.becomeFirstResponder()
            return
        }

        
        
        //get token
        if let data = UserDefaults.standard.data(forKey: "account"),
            let myAccountList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Account]
        {
            
            let account:Account = myAccountList[0]
        
            let token:String = account.m_pToken
            
            let strServer = Constants.API_SERVER
            let strModule = Constants.API_MEMBER
            let strFormat = "%@%@"
            
            let parameters: Parameters = ["name":name]
            
            let strApiUrl:String = String.init(format: strFormat, locale: nil,  strServer, strModule)
            
            Alamofire.request(strApiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Authorization" : token])
                .responseJSON { response in
                    
                    if let dic:[String:Any]  = response.result.value as! [String:Any]?
                    {
                        if let code:String = dic["code"] as? String
                        {
                            print("code : \(code)")
                            
                            self.view.makeToast(code,
                                                duration: 1.0,
                                                position: .center)
                        
                            
                            //clear input
                            self.m_pTFMemberName.text = ""
                        }

                    }

                    
                    
            }
            
        }
        
        
    }
    
    
    //MARK: Customized Methods
    func showLoingView() -> Void
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! Login
        
        let nvc: UINavigationController = UINavigationController(rootViewController: vc)
        
        
        self.present(nvc, animated: true, completion: nil)
    }
    
    //MARK: Notifiactions
    func handleNotificationLogout() -> Void
    {
        //clear uerDefault
        UserDefaults.standard.removeObject(forKey: "account")
        self.showLoingView()
    }
    
    func handleNotificationList() -> Void
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MemberListVC") as! MemberListVC
        
        let nvc: UINavigationController = UINavigationController(rootViewController: vc)
        
        
        self.present(nvc, animated: true, completion: nil)
    }

}

