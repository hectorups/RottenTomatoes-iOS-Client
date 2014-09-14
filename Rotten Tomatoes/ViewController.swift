//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 11/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let client = RTClient()
    var moviesArray: [Movie] = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shouldBeginEditing = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refersh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.addSubview(refreshControl)
        
        searchBar.delegate = self
        
        let yellow = UIColor(red: 235/255, green: 185/255, blue: 0.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = yellow
        navigationController?.navigationBar.titleTextAttributes = NSDictionary(object: yellow, forKey: NSForegroundColorAttributeName)
        navigationTitle.title = "Best Movies"
    }
    
    
    func fetchData(pullrefresh: Bool = false) {
        if !pullrefresh {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }
        
        var success = { (operation: AFHTTPRequestOperation!,
            responseObject: AnyObject!) -> Void in
            self.dataFetchFinished()
            
            self.moviesArray.removeAll(keepCapacity: false)
            var moviesJsonArray = responseObject["movies"] as? NSArray
            for movieDictionary in moviesJsonArray! {
                self.moviesArray.append(Movie(fromDictionary: movieDictionary as NSDictionary))
            }
            self.movieTableView.reloadData()
        }
        
        var failure = { (operation: AFHTTPRequestOperation!,
            error: NSError!) -> Void in
            self.dataFetchFinished()
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            ALAlertBanner(forView: appDelegate.window, style:ALAlertBannerStyleFailure,
                position: ALAlertBannerPositionUnderNavBar, title: "Network Error").show()
        }
        
        if searchBar.text.isEmpty {
            client.topRentals(
                success,
                failure: failure)
        } else {
            client.search(searchBar.text, success: success, failure: failure)
        }
        
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println("search bar button clicked \(searchBar.text)")
        fetchData(pullrefresh: false)
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            view.endEditing(true)
            fetchData()
        }
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

