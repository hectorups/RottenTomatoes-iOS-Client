//
//  Movie.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 13/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import Foundation

struct Movie {
    var title : String
    var synopsis : String
    var thumbnailUrl : String
    var posterUrl : String
    
    init(fromDictionary movieDictionary: NSDictionary){
        title = movieDictionary["title"] as String
        synopsis = movieDictionary["synopsis"] as String
        let posters = movieDictionary["posters"] as NSDictionary
        thumbnailUrl = posters["thumbnail"] as String
        posterUrl = thumbnailUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}