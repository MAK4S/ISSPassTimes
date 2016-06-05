//
//  DetailPassTableViewCell.swift
//  ISSPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import UIKit

class DetailPassTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    func bind(passTime: PassTime){
    
        self.titleLabel.text = "Hasta el sobrevuelo quedan:"
        
        self.secondsLabel.text = "segundos"
        
        self.timeLabel.text = String(passTime.getRemainigTime())
        
        self.durationLabel.text = passTime.getParseDurationDetail()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(DetailPassTableViewCell.updateTime), userInfo: nil, repeats: true)
        
    }
    
    func updateTime()
    {
        let time = Int(self.timeLabel.text!)!-1;
        
        self.timeLabel.text = String(time)
    }
}
