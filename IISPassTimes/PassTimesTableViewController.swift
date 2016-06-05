//
//  PassTimesViewController.swift
//  IISPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import UIKit
import MapKit
import Spring

class PassTimesTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let reachability = Reachability()
    var locationManager: CLLocationManager!
    var location: Location?
    let utils = Utils.newInstance()
    var passes = [PassTime]()
    var messageFrame = UIView()
    var currentAddress: String?
    var overlay: SpringView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Próximos Sobrevuelos"
        
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if reachability.isConnectedToNetwork() {
            
            if (NSProcessInfo.processInfo().environment["SIMULATOR_DEVICE_NAME"] != nil){
                
                self.utils.showSimpleAlertView(self, title: "Using simulator", message: "The application will not work on simulator because it needs to access location services.")
            }
            else{
                
                if self.overlay == nil {
                
                    self.overlay = SpringView(frame: view.frame)
                    self.overlay!.backgroundColor = UIColor.groupTableViewBackgroundColor()
                }
                
                self.view.addSubview(self.overlay!)
                
                switch status{
                    
                case .NotDetermined:
                 
                    break;
                    
                case .Restricted, .Denied:
                    
                    self.utils.showSettingsAlertView(self, title: "Location Not Authorized", message: "In order to search I.S.S. Pass Times near you, please open this app's settings and set location access to 'When in use'.")
                    
                    break;
                    
                case .AuthorizedWhenInUse, .AuthorizedAlways:
                    
                    if let location = manager.location {
                        
                        self.utils.showProgressBarDisplayer(view, messagge: "Buscando sobrevuelos...", indicator: true)
                        
                        self.locationManager.startUpdatingLocation()
                        
                        self.location = Location(latitude: location.coordinate.latitude,longitude: location.coordinate.longitude)
                        
                        self.locationManager.stopUpdatingLocation()
                        
                        self.location?.getAddressFromLocation({ (address) in
                            
                            self.currentAddress = address
                            
                            self.location?.getPasses(self,completion: { (passes) in
                                
                                if let passes = passes {
                                
                                    self.passes.removeAll()
                                    self.passes = passes
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        self.utils.hideProgressBarDisplay()
                                        
                                        self.overlay?.animation = "fadeOut"
                                        self.overlay?.animate()
                                        
                                        self.tableView.reloadData()
                                    })
                                }else{
                                
                                    self.utils.hideProgressBarDisplay()
                                    self.utils.showSimpleAlertView(self, title: "Error", message: "It was an error while loaded the International Space Station Pass Times.")
                                }
                            })
                        })
                        
                    }else{
                    
                        self.utils.showSimpleAlertView(self, title: "Error", message: "It was an error while get the current location. Location is necesary, Otherwise you can not use the application.")
                    }
                    
                    break;
                }
            }
            
        }else{
            
            self.utils.showSettingsAlertView(self, title: "You are offline", message: "Please check the internet connection. Otherwise you can not use the application.")
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderTableViewCell
        
        if let currentAddress = self.currentAddress {
        
            cell.bind(view.bounds.size.width,address: currentAddress)
        }
        return cell.contentView
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.passes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PassCell", forIndexPath: indexPath) as! PassTableViewCell
        
        cell.bind(passes[indexPath.row])
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DetailSegue" {
            
            let index = tableView.indexPathForSelectedRow
            
            let vc = segue.destinationViewController as! DetailPassTimeTableViewController
            
            vc.passTime = self.passes[(index?.row)!]
            vc.currentAddress = self.currentAddress!
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
        }
    }
}
















