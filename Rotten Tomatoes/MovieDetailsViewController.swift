//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 11/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie : Movie?
    
    override func loadView() {
        println(movie)
        self.view = UIView(frame: CGRectZero)
        self.view.backgroundColor = UIColor.redColor()
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
