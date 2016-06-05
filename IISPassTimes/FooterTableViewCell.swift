//
//  FooterTableViewCell.swift
//  ISSPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    @IBOutlet weak var anecdoteLabel: UILabel!
    
    func bind(anecdote: String){
    
        self.contentView.backgroundColor = UIColor(red:0.96, green:0.25, blue:0.51, alpha:1.0)
        
        self.anecdoteLabel.text = anecdote
    }
}
