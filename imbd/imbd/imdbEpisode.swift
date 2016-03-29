//
//  imdbEpisode.swift
//  imbd
//
//  Created by Vinayak Bipin Joshi on 3/27/16.
//
//

import Foundation


public class imdbEpisode : NSObject{
    
    public var title : String?
    public var released : String?
    public var episode : String?
    public var imdbRating : String?
    public var imdbID : String?
    
    convenience init(responseObject : Dictionary < String, AnyObject> ) {
        self.init()
        self.title = responseObject["Title"] as! String?
        self.released = responseObject["Released"] as! String?
        self.episode = responseObject["Episode"] as! String?
        self.imdbRating = responseObject["imdbRating"] as! String?
        self.imdbID = responseObject["imdbID"] as! String?

    }
    
}