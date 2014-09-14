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
    
    override func loadView() {
        super.loadView()

        titleLabel.text = movie?.title
        detailsNavigation.title = movie?.title
        synopsisLabel.text = movie?.synopsis
        synopsisLabel.sizeToFit()
        detailsScroll.scrollEnabled = true
        posterImage.setImageWithURL(NSURL(string: movie!.posterUrl))
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
