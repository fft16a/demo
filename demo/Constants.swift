//
//  Constants.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/19.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import Foundation

class Constants
{
    //MARK:- Notifications
    static let POST_NOTIFICATION_UNDEFINED          = Notification.Name("Undefind")
    static let POST_NOTIFICATION_LOGIN              = Notification.Name("Notification_Login")
    static let POST_NOTIFICATION_SIGNUP             = Notification.Name("Notification_Signup")
    static let POST_NOTIFICATION_LOGOUT             = Notification.Name("Notification_Logout")
    static let POST_NOTIFICATION_LIST               = Notification.Name("Notification_List")

    
    //MARK:- API Related
    static let API_SERVER                               = "http://52.197.192.141:3443"
    //會員相闗
    static let API_MEMBER                               = "/member"
    
}
