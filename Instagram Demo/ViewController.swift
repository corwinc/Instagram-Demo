//
//  ViewController.swift
//  Instagram Demo
//
//  Created by Corwin Crownover on 3/15/16.
//  Copyright © 2016 Corwin Crownover. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    var photos: [NSDictionary] = []
    var headerView: UIView!
    var profileView: UIImageView!
//    var usernameLabel: UILabel!
    var textLabel: UILabel!
    
    let CellIdentifier = "TableViewCell", HeaderViewIdentifier = "TableViewHeaderView"
    
    
    
    
    
    // VIEW DID LOAD    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        tableView.rowHeight = 380
        
        // Data Request
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=e05c462ebd86446ea48a5af73769b602")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            if let data = data {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    print("responseDictionary: \(responseDictionary)")
                    
                    self.photos = responseDictionary["data"] as! [NSDictionary]
                    self.tableView.reloadData()
                }
            }
        })
        
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    // FUNCTIONS
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return photos.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Photo
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell")! as! PhotoCell
        
        let photo = photos[indexPath.section]
        let photoUrlString = photo.valueForKeyPath("images.standard_resolution.url") as? String
        
        if let photoUrl = NSURL(string: photoUrlString!) {
            cell.photoView.setImageWithURL(NSURL(string: photoUrlString!)!)
        } else {
        }
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let photo = photos[section]

        // Header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        
        // Username
        let usernameLabel = UILabel(frame: CGRectMake(50, 14, 200, 20))
        usernameLabel.text = photo.valueForKeyPath("user.username") as? String
        usernameLabel.textAlignment = NSTextAlignment.Left
        usernameLabel.font = UIFont(name: "Helvetica", size: 16)
        
        headerView.addSubview(usernameLabel)
 
        // To use basic iOS header text label:
        // headerView.textLabel!.text = photo.valueForKeyPath("user.username") as? String


        // Profile Pic
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1
        
        let profileUrlString = photo.valueForKeyPath("user.profile_picture") as? String
        
        if let profileUrl = NSURL(string: profileUrlString!) {
            profileView.setImageWithURL(NSURL(string: profileUrlString!)!)
        } else {
        }

        headerView.addSubview(profileView)

        // Return Header View
        return headerView
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {

        // doubletap: spring animate heart graphic: transform scale,
        // select heart icon (red) in footer // create footer
    }

    
    
    

}



/*
TODO - NICE TO HAVE
Double tap to heart
Profile detail view
Read photo dimensions and set cell size accordingly. Aspect Fit.
Add comment section
*/

