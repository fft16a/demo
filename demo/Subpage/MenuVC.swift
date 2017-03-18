//
//  MenuVC.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/19.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import Foundation
import UIKit

class MenuVC: UIViewController
{
    var mainContens = ["MemberList", "Logout"]
    var mainImages = ["book", "settings"]
    
    @IBOutlet weak var m_pMainTableView: UITableView!
    
    //MARK:- override
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension MenuVC : UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.row
        {
            case 0:
                NotificationCenter.default.post(name: Constants.POST_NOTIFICATION_LIST, object: nil)
            case 1:
                NotificationCenter.default.post(name: Constants.POST_NOTIFICATION_LOGOUT, object: nil)
            default:
                NotificationCenter.default.post(name: Constants.POST_NOTIFICATION_UNDEFINED, object: nil)
        }
        
        self.slideMenuController()?.closeLeft()
    }
}

extension MenuVC : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.mainContens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = self.m_pMainTableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier") as! MenuCell
        
         //let cell = self.m_pMainTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableCell;

        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath) as! MenuCell
        
        cell.updateUI(pstrTitle: mainContens[indexPath.row], ImageName: mainImages[indexPath.row])
        return cell
    }
}
