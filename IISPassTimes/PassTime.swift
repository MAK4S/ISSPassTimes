//
//  PassTime.swift
//  IISPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import Foundation
import UIKit

public class PassTime {

    private var riseTime: Int
    private var duration: Int
    private var date: NSDate
    
    init(riseTime: Int, duration: Int){
    
        self.riseTime = riseTime
        self.duration = duration
        self.date = NSDate(timeIntervalSince1970: Double(riseTime))
    }
    
    func getParseRiseTime() -> String {
        
        let dateString = "\(date.day) \(date.day0x) de \(date.month)\na las \(date.hour0x):\(date.minute0x)"
        
        return String(dateString)
    }
    
    func getParseDuration() -> String {
        
        return String("Durante \(self.duration/60) minutos y \(self.duration%60) segundos")
    }
    
    func getParseDurationDetail() -> String {
        
        return String("El sobrevuelo durará \(self.duration/60) minutos y \(self.duration%60) segundos")
    }
    
    func getRemainigTime() -> Int {
    
        return Int(NSDate().timeIntervalSinceDate(self.date)*(-1))
    }
    
    func getAnecdote(controller: UIViewController, completion: (anecdote: String?) -> Void){
    
        let postEndpoint: String = "http://numbersapi.com/\(date.month0x)/\(date.day0x)/date"
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            guard let realResponse = response as? NSHTTPURLResponse
                where realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            if let anecdote = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                
                completion(anecdote: anecdote)
                
            }else {
                
                completion(anecdote: nil)
            }
            
        }).resume()
    }
    
}
