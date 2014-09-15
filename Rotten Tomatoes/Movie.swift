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
    var criticsScore : Int
    var audienceScore : Int
    var year : Int
    
    init(fromDictionary movieDictionary: NSDictionary){
        title = movieDictionary["title"] as String
        synopsis = movieDictionary["synopsis"] as String
        
        let posters = movieDictionary["posters"] as NSDictionary
        thumbnailUrl = posters["thumbnail"] as String
        posterUrl = thumbnailUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let critics = movieDictionary["ratings"] as NSDictionary
        criticsScore = critics["critics_score"] as Int
        audienceScore = critics["audience_score"] as Int
        
        year = movieDictionary["year"] as Int
    }
}