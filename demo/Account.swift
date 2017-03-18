//
//  Account.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/19.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import Foundation

class Account:NSObject, NSCoding
{
    let m_pUserName:String
    let m_pUserPassword:String
    let m_dExp:Double
    let m_pToken:String
    
    init(name: String, password: String, exp: Double, token:String)
    {
        self.m_pUserName = name
        self.m_pUserPassword = password
        self.m_dExp = exp
        self.m_pToken = token
    }
    required init(coder decoder: NSCoder) {
        self.m_pUserName = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.m_pUserPassword = decoder.decodeObject(forKey: "password") as? String ?? ""
        self.m_dExp = decoder.decodeDouble(forKey: "exp")
        self.m_pToken = decoder.decodeObject(forKey: "token") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(m_pUserName, forKey: "name")
        coder.encode(m_pUserPassword, forKey: "password")
        coder.encode(m_dExp, forKey: "exp")
        coder.encode(m_pToken, forKey: "token")
    }
}
