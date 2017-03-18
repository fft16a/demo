//
//  MenuCell.swift
//  demo
//
//  Created by Rusty Huang on 2017/3/19.
//  Copyright © 2017年 Rusty Huang. All rights reserved.
//

import Foundation
import UIKit
class MenuCell : UITableViewCell
{
    //MARK:-
    @IBOutlet weak var m_pImgView: UIImageView!
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
    func updateUI( pstrTitle:String, ImageName imgName:String ) -> Void
    {
        m_pLblTitle.text = pstrTitle;
        m_pImgView.image = UIImage.init(named: imgName);
    }
    
}
