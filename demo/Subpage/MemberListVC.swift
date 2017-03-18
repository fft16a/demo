//
//  MemberListVC.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/19.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MemberListVC: UIViewController
{
    var m_pMemberArray:[[String:Any]]?
    
    @IBOutlet weak var m_pMainTableView: UITableView!
    
    //MARK:- override
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.loadMemeberData()
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
    
    //MARK:IBAction
    
    @IBAction func pressBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:Customized Methods
    func loadMemeberData() -> Void
    {
        //get token
        if let data = UserDefaults.standard.data(forKey: "account"),
            let myAccountList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Account]
        {
            
            let account:Account = myAccountList[0]
            
            let token:String = account.m_pToken
            
            let strServer = Constants.API_SERVER
            let strModule = Constants.API_MEMBER
            let strFormat = "%@%@"
            
            let strApiUrl:String = String.init(format: strFormat, locale: nil,  strServer, strModule)
            
            Alamofire.request(strApiUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : token])
                .responseJSON { response in
                    
                     print(response.result.value as Any)
                    
                    if let dic:[String:Any]  = response.result.value as! [String:Any]?
                    {
                        self.m_pMemberArray = dic["data"] as? [[String:Any]]
                        
                        self.m_pMainTableView.reloadData()
                        
                    }
                    
                    
                    
            }
            
        }

    }
    
}


extension MemberListVC : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var nCount:Int = 0
        
        if self.m_pMemberArray != nil
        {
            nCount = self.m_pMemberArray!.count
        }
        
        
        return nCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        
        
        let dic:[String:Any] = self.m_pMemberArray![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCellIdentifier", for: indexPath) as! MemberCell
        
        let name:String = dic["name"] as! String
        
        cell.updateUI(pstrTitle: name)
        
    
        
        return cell
    }
}
