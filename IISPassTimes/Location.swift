//
//  Location.swift
//  IISPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class Location {
    
    private var latitude: Double
    private var longitude: Double
    
    private var name: String
    private var street: String
    private var number: String?
    private var city: String?
    private var zipCode: String
    private var state: String
    private var country: String
    
    init(latitude: Double, longitude: Double){
        
        self.latitude = latitude
        self.longitude = longitude
        
        self.name = ""
        self.street = ""
        self.zipCode = ""
        self.state = ""
        self.country = ""
    }
    
    func getPasses(controller: UIViewController, completion: (passes: [PassTime]?) -> Void) {
        
        let postEndpoint: String =
            "http://api.open-notify.org/iss-pass.json?lat=\(self.latitude)&lon=\(self.longitude)"
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            guard let realResponse = response as? NSHTTPURLResponse
                where realResponse.statusCode == 200 else {

                    completion(passes: nil)
                    return
            }
            
            do {
                if NSString(data:data!, encoding: NSUTF8StringEncoding) != nil {
                    
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    let passesArray = jsonDictionary["response"] as! NSArray
                    
                    var passes = [PassTime]()
                    
                    for pass in passesArray {
                    
                        if let risetime = pass["risetime"] as? NSNumber {
                        
                            if let duration = pass["duration"] as? NSNumber {
                        
                                let passTime = PassTime(riseTime: Int(risetime), duration: Int(duration))
                                passes.append(passTime)
                            }
                        }
                    }
                   
                    completion(passes: passes)
                }
            } catch {
                
                completion(passes: nil)
            }
            
        }).resume()
    }
    
    func getAddressFromLocation(completion: (address: String!) -> Void) {
        
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
        
        let geoCoder: CLGeocoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let addresDictionary = placeMark.addressDictionary {
            
                if let n = addresDictionary["Name"] as? String {
                    
                    self.name = n as String
                    
                    if let s = addresDictionary["Thoroughfare"] as? String {
                        self.street = s as String
                    }else{
                        self.street = n as String
                    }
                    
                }else{
                    
                    if let s = addresDictionary["Thoroughfare"] as? String {
                        self.name = s as String
                        self.street = s as String
                    }
                }
                
                if let n = addresDictionary["SubThoroughfare"] as? String {
                    self.number = n as String
                }
                
                if let c = addresDictionary["City"] as? String {
                    self.city = c as String
                }
                
                if let zc = addresDictionary["ZIP"] as? String {
                    self.zipCode = zc as String
                }
                
                if let s = addresDictionary["State"] as? String {
                    self.state = s as String
                }
                
                if let zc = addresDictionary["Country"] as? String {
                    self.country = zc as String
                }
                
                completion(address: self.getFullAddress())
                
            }else{
            
                completion(address: "No se ha podido obtener la dirección")
            }
        })
    }

    func getFullAddress() -> String {
        
        let address1 = self.getAddressLine1()
        let address2 = self.getAddressLine2()
        let address3 = self.getAddressLine3()
        
        return "\(address1), \(address2), \(address3)"
    }
    
    func getAddressLine1() -> String {
        
        return self.name
    }
    
    func getAddressLine2() -> String {
        
        if let number = self.number { return "\(self.street), \(number)" } else { return self.street }
        
    }
    
    func getAddressLine3() -> String {
        
        if let city = self.city {
        
            return "\(self.zipCode) \(city), \(self.country)"
        
        }else{
        
            return "\(self.zipCode), \(self.country)"
        }
    }
}
