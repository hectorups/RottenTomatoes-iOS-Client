//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 11/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=fg5hr3dnejswzb6ybv9v9nxb"
    let manager = AFHTTPRequestOperationManager()
    var moviesArray: [Movie] = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refersh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.addSubview(refreshControl)
    }
    
    
    
    func fetchData(pullrefresh: Bool = false) {
        if !pullrefresh {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }
        manager.GET(
            RottenTomatoesURLString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                self.dataFetchFinished()
                
                self.moviesArray.removeAll(keepCapacity: false)
                var moviesJsonArray = responseObject["movies"] as? NSArray
                for movieDictionary in moviesJsonArray! {
                    self.moviesArray.append(Movie(fromDictionary: movieDictionary as NSDictionary))
                }
                self.movieTableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                self.dataFetchFinished()
                let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                ALAlertBanner(forView: appDelegate.window, style:ALAlertBannerStyleFailure,
                    position: ALAlertBannerPositionUnderNavBar, title: "Network Error").show()
        })
    }
    
    func dataFetchFinished(){
        self.refreshControl.endRefreshing()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    func refresh(sender:AnyObject){
        fetchData(pullrefresh: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCellWithIdentifier("com.codepath.rottentomatoes.moviecell") as MovieTableViewCell
        let movie = self.moviesArray[indexPath.row] as Movie
        cell.titleLabel.text = movie.title
        cell.synopsisLabel.text = movie.synopsis
        cell.thumbImage.setImageWithURL(NSURL(string: movie.thumbnailUrl))
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("on prepareforsegue")
        println(segue.identifier)
        if segue.identifier == "DetailSegue" {
            var controller = segue.destinationViewController as MovieDetailsViewController
            var indexPath : NSIndexPath! = moviesTableView.indexPathForCell(sender as MovieTableViewCell)
            println(indexPath.row)
            controller.movie = self.moviesArray[indexPath.row] as Movie
        }
    }


}

