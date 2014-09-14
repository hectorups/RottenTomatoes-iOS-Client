//
//  Client.swift
//  Rotten Tomatoes
//
//  Created by Hector Monserrate on 14/09/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import Foundation

class RTClient {

    let PrimaryKeyParam = ["apiKey": "fg5hr3dnejswzb6ybv9v9nxb"]
    let BaseURL = "http://api.rottentomatoes.com/api/public/v1.0"
    let TopRentalsURL = "/lists/dvds/top_rentals.json"
    let SearchURL = "/movies.json"
    let manager = AFHTTPRequestOperationManager()
    
    func topRentals(success: (operation: AFHTTPRequestOperation!,
        responseObject: AnyObject!) -> Void, failure: (operation: AFHTTPRequestOperation!,
        error: NSError!) -> Void) {

            manager.GET(
                "\(BaseURL)\(TopRentalsURL)",
                parameters: PrimaryKeyParam,
                success: success,
                failure: failure)
    }
    
    func search(query: String, success: (operation: AFHTTPRequestOperation!,
        responseObject: AnyObject!) -> Void, failure: (operation: AFHTTPRequestOperation!,
        error: NSError!) -> Void) {
            
            manager.GET(
                "\(BaseURL)\(SearchURL)",
                parameters: PrimaryKeyParam + ["q": query],
                success: success,
                failure: failure)
    }
    
}

func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>)
    -> Dictionary<K,V>
{
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}