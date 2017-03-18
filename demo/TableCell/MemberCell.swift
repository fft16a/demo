//
//  MemberCell.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/19.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import Foundation
import UIKit
class MemberCell : UITableViewCell
{
    //MARK:-
    @IBOutlet weak var m_pLblTitle: UILabel!
    
    //MARK:- override
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    //MARK:- Custom
    func updateUI( pstrTitle:String ) -> Void
    {
        m_pLblTitle.text = pstrTitle;
    }
    
}
