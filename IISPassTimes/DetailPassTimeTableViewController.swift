//
//  DetailPassTimeTableViewController.swift
//  ISSPassTimes
//
//  Created by Mario Corte on 4/6/16.
//  Copyright © 2016 Mario Corte. All rights reserved.
//

import UIKit
import Spring

class DetailPassTimeTableViewController: UITableViewController {

    var passTime: PassTime!
    var currentAddress: String!
    var utils = Utils.newInstance()
    var overlay: SpringView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Próximo sobrevuelo"
        
        self.overlay = SpringView(frame: self.view.frame)
        self.overlay!.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view.addSubview(self.overlay!)
        self.utils.showProgressBarDisplayer(view, messagge: "Buscando anécdota...", indicator: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! DetailPassTableViewCell
        
        dispatch_async(dispatch_get_main_queue(), {
        
            cell.bind(self.passTime)
        })
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableView.bounds.size.height - 200
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderTableViewCell
        
        dispatch_async(dispatch_get_main_queue(), {
        
            cell.bind(self.view.bounds.size.width,address: self.currentAddress)
        })
        
        return cell.contentView
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FooterCell") as! FooterTableViewCell
        
        self.passTime.getAnecdote(self) { (anecdote) in
            
            dispatch_async(dispatch_get_main_queue(), {
            
                self.utils.hideProgressBarDisplay()
                self.overlay?.animation = "fadeOut"
                self.overlay?.animate()
                
                if let anecdote = anecdote {
                
                    cell.bind(anecdote)
                    
                }else{
                
                    cell.bind("It was an error while loaded the Pass Time Anecdote.")
                }
            })
        }
        
        return cell.contentView
    }
}
