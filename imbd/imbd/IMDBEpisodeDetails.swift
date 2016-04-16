//
//  IMDBEpisodeDetails.swift
//  imbd
//
//  Created by Vinayak Bipin Joshi on 3/27/16.
//
//

import Foundation

public class IMDBEpisodeDetails : NSObject{
    public var title : String?

    public var year : String?
    public var rated : String?
    public var released : String?
    public var season: String?
    public var episode : String?
    public var runtime : String?

    // init with custom params
    convenience init(responseObject : Dictionary < String, AnyObject> ) {
      
        self.init()
        self.title = responseObject["Title"] as! String?  //PLEASE NOTE: NOT FORMATTING ANY FIELD HENCE ALL KEPT AS A STRING
        self.year = responseObject["Year"] as! String?
        self.rated = responseObject["Rated"] as! String?
        self.released = responseObject["Released"] as! String?
        self.season = responseObject["Season"] as! String?
        self.episode = responseObject["Episode"] as! String?
        self.runtime = responseObject["Runtime"] as! String?

    }
    
}