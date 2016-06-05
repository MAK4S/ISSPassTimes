//
//  Utils.swift
//  IISPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import Foundation
import UIKit

public class Utils {

    var messaggeFrame: UIView!
    var overlay: UIView!
    
    init(){ }
    
    class func newInstance() -> Utils {
    
        return Utils()
    }
    
    func showSimpleAlertView(controller: UIViewController, title: String, message: String?){
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let acceptAction = UIAlertAction(title: "Accept", style: .Default, handler: nil)

        alert.addAction(acceptAction)
        
        controller.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showSettingsAlertView(controller: UIViewController, title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .Default) { (action) -> Void in
            
            let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
        alert.addAction(settingsAction)
        
        controller.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showProgressBarDisplayer(view: UIView, messagge:String, indicator:Bool ) {
        
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        
        strLabel.text = messagge
        strLabel.textColor = UIColor.whiteColor()
        
        self.messaggeFrame = UIView(frame: CGRect(x: view.frame.midX - 130, y: view.frame.midY - 60 , width: 260, height: 50))
        self.messaggeFrame.layer.cornerRadius = 15
        self.messaggeFrame.backgroundColor = UIColor(white: 0.5, alpha: 0.6)
        
        if indicator {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            self.messaggeFrame.addSubview(activityIndicator)
        }
        
        self.messaggeFrame.addSubview(strLabel)
        view.addSubview(self.messaggeFrame)
    }
    
    func hideProgressBarDisplay(){
    
        self.messaggeFrame.removeFromSuperview()
    }
}

extension NSDate {
    
    var month: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.stringFromDate(self)
    }
    
    var month0x: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.stringFromDate(self)
    }
    
    var day: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(self)
    }
    
    var day0x: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(self)
    }
    
    var hour0x: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh"
        return dateFormatter.stringFromDate(self)
    }
    var minute0x: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm"
        return dateFormatter.stringFromDate(self)
    }
}






