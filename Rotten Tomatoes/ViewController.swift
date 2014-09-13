//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 11/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=fg5hr3dnejswzb6ybv9v9nxb"
    let manager = AFHTTPRequestOperationManager()
    var moviesArray: NSArray?
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.GET(
            RottenTomatoesURLString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                println("request finished")
                self.moviesArray = responseObject["movies"] as? NSArray
                self.movieTableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesArray != nil {
            return moviesArray!.count
        } else {
           return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCellWithIdentifier("com.codepath.rottentomatoes.moviecell") as MovieTableViewCell
        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
        cell.titleLabel.text = movieDictionary["title"] as NSString
        cell.synopsisLabel.text = movieDictionary["synopsis"] as NSString
        cell.thumbImage.setImageFromUrl((movieDictionary["posters"] as NSDictionary)["thumbnail"] as NSString)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailsViewController = MovieDetailsViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }


}

