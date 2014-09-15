//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 11/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var detailsNavigation: UINavigationItem!
    @IBOutlet weak var detailsScroll: UIScrollView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var criticsLabel: UILabel!
    
    var movie : Movie?
    var thumbnail : UIImage?
    
    override func loadView() {
        super.loadView()

        titleLabel.text = "\(movie!.title) (\(movie!.year))"
        detailsNavigation.title = movie?.title
        criticsLabel.text = "Critics Score \(movie!.criticsScore), Audience Score: \(movie!.audienceScore)"
        synopsisLabel.text = movie?.synopsis
        synopsisLabel.sizeToFit()
        
        
        var contentRect = CGRectZero
        for view in containerView.subviews {
            contentRect = CGRectUnion(contentRect, view.frame)
        }
        
        println("view Y \(containerView.frame.minY)")
        println("view height \(containerView.frame.height)")
        
        detailsScroll.scrollEnabled = true
        detailsScroll.contentSize = CGSizeMake(contentRect.width, contentRect.height + containerView.frame.height + containerView.frame.height - 50)
        containerView.frame = CGRectMake(containerView.frame.minX, containerView.frame.minY, containerView.frame.width, contentRect.height + 200)
        
        
        posterImage.setImageWithURLRequest(
            NSURLRequest(URL: NSURL(string:movie!.posterUrl)),
            placeholderImage: thumbnail!,
            success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) in
                self.posterImage.alpha = 0.0
                self.posterImage.image = image
                UIView.animateWithDuration(1.0, animations: {self.posterImage.alpha = 1.0})
            },
            failure: { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) in
                println("Image failed to load")
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
