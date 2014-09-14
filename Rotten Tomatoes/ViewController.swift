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
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refersh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.addSubview(refreshControl)
        
        navigationTitle.title = "Best Movies"
        
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
        
        cell.thumbImage.setImageWithURLRequest(
            NSURLRequest(URL: NSURL(string: movie.thumbnailUrl)),
            placeholderImage: nil,
            success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) in
                println("Image loaded")
                cell.thumbImage.alpha = 0.0
                cell.thumbImage.image = image
                UIView.animateWithDuration(0.5, animations: {cell.thumbImage.alpha = 1.0})
            },
            failure: { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) in
                println("Image failed to load")
        })
        
        // Customize background when the cell is selected
        var selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 235/255, green: 185/255, blue: 0.0, alpha: 1.0)
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("on prepareforsegue")
        println(segue.identifier)
        if segue.identifier == "DetailSegue" {
            var controller = segue.destinationViewController as MovieDetailsViewController
            var cell = sender as MovieTableViewCell
            var indexPath : NSIndexPath! = moviesTableView.indexPathForCell(cell)
            println(indexPath.row)
            controller.movie = self.moviesArray[indexPath.row] as Movie
            controller.thumbnail = cell.thumbImage.image
        }
    }


}

