//
//  HeaderTableViewCell.swift
//  IISPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func bind(width: CGFloat, address: String){
        
        self.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.contentView.alpha = 0.97
        
        self.infoLabel.text = "Estás en:"
        self.addressLabel.text = address;
        
        let border = UIView()
        let height = CGFloat(0.2)
        
        border.backgroundColor = UIColor.lightGrayColor()
        border.frame = CGRect(x: 0, y: self.frame.size.height - height, width:  width, height: self.frame.size.height)
        
        self.contentView.addSubview(border)
        self.layer.masksToBounds = true
    }
}
