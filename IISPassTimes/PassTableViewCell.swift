//
//  PassTableViewCell.swift
//  IISPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import UIKit

class PassTableViewCell: UITableViewCell {

    @IBOutlet weak var picturePassImageView: UIImageView!
    @IBOutlet weak var datePassLabel: UILabel!
    @IBOutlet weak var durationPassLabel: UILabel!
    
    func bind(passTime: PassTime) {
    
        
        self.picturePassImageView.image = UIImage(named: "ISS.jpg")
        self.picturePassImageView.layer.cornerRadius = self.picturePassImageView.frame.size.width / 2;
        self.picturePassImageView.clipsToBounds = true;
        
        var upperDate = passTime.getParseRiseTime();
        
        upperDate.replaceRange(upperDate.startIndex...upperDate.startIndex, with: String(upperDate[upperDate.startIndex]).capitalizedString)
        
        self.datePassLabel.text = upperDate
        self.durationPassLabel.text = passTime.getParseDuration()
    }
}
