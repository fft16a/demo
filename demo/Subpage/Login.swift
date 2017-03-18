//
//  Login.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/19.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
import Alamofire

class Login: UIViewController
{
    //MARK:- Variables

    
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var m_pTFName: UITextField!

    @IBOutlet weak var m_pTFPassword: UITextField!
    
    @IBOutlet weak var m_pBtnAutoLogin: UISwitch!
    //MARK:- IBAction
    
    
    @IBAction func pressLogin(_ sender: Any)
    {
        let name:String = self.m_pTFName.text!
        let password:String = self.m_pTFPassword.text!
        
        if  name.isEmpty == true
        {
            self.view.makeToast(NSLocalizedString("please enter your name", comment: ""),
                                duration: 1.0,
                                position: .center)
            self.m_pTFName.becomeFirstResponder()
            return
        }
        
        if  password.isEmpty == true
        {
            self.view.makeToast(NSLocalizedString("please enter your password", comment: ""),
                                duration: 1.0,
                                position: .center)
            self.m_pTFPassword.becomeFirstResponder()
            return
        }
        
        
        let strServer = Constants.API_SERVER
        let strModule = ""
        let strFormat = "%@%@"
        
        let parameters: Parameters = ["name":name, "pwd":password]
        
        let strApiUrl:String = String.init(format: strFormat, locale: nil,  strServer, strModule)

        Alamofire.request(strApiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
//                print(response.request as Any)  // original URL request
//                print(response.response as Any) // URL response
                print(response.result.value as Any)   // result of response serialization
                
                
                if let dic:[String:Any]  = response.result.value as! [String:Any]?
                {
                    if let tokenDic:[String:Any] = (dic["token"] as? [String:Any])
                    {
                        print("tokenDic : \(tokenDic)")
                        
                        //save data
                        
                        let exp:Double = tokenDic["exp"] as! Double
                        let token:String = tokenDic["token"] as! String
                        
                        let newAccount:Account = Account.init(name: name, password: password, exp: exp, token: token)
                        var account = [Account]()
                        account.append(newAccount)
                        let encodedData = NSKeyedArchiver.archivedData(withRootObject: account)
                        UserDefaults.standard.set(encodedData, forKey: "account")
                        self.dismiss(animated: true, completion: nil)
                    }
                    else
                    {
                        let errorString:String = (dic["code"] as? String)!
                        
                        self.view.makeToast(errorString,
                                            duration: 1.0,
                                            position: .center)
                    }
                }
                
        }
        
        
//        Alamofire.request(strApiUrl, method: .post, parameters: parameters, encoding: JSONEncoding, headers: nil).responseJSON{ response in
//
//            print("response\(response.result.value)")
//            
//            
//        }
//
//        
//        
//        Alamofire.request(strApiUrl,
//                          method: .post,
//                          parameters: parameters).responseJSON { response in
//                            
//                            print("response\(response.result.value)")
//                            
//                    
//        }


    }
    
    
    //MARK:- override
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return true
    }
    
    
    
    //MARK:- TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }

    
}
