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
    
    var movie : Movie?
    var thumbnail : UIImage?
    
    override func loadView() {
        super.loadView()

        titleLabel.text = movie?.title
        detailsNavigation.title = movie?.title
        synopsisLabel.text = movie?.synopsis
        synopsisLabel.sizeToFit()
        detailsScroll.scrollEnabled = true
        posterImage.setImageWithURLRequest(
            NSURLRequest(URL: NSURL(string:movie!.posterUrl)),
            placeholderImage: thumbnail!,
            success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) in
                println("Image loaded")
                self.posterImage.alpha = 0.0
                self.posterImage.image = image
                UIView.animateWithDuration(1.0, animations: {self.posterImage.alpha = 1.0})
            },
            failure: { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) in
                println("Image failed to load")
        })
        
        let yellow = UIColor(red: 235/255, green: 185/255, blue: 0.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = yellow
        navigationController?.navigationBar.titleTextAttributes = NSDictionary(object: yellow, forKey: NSForegroundColorAttributeName)
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
