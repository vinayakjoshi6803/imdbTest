//
//  imdbServiceManager.swift
//  imbd
//
//  Created by Vinayak Bipin Joshi on 3/27/16.
//
//

import Foundation

public class imdbServiceManager : NSObject {

    //http://www.omdbapi.com/?i=tt1480055&plot=short&r=json
    
    public func pullEpisodesListingForSeason (seanson : Int, success : (episodes :[imdbEpisode])-> Void , failure : (error :NSError)-> Void)-> Void{
    
        
        let urlString = String( "http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=\(seanson)")
        
        let url = NSURL(string: urlString)
        
        var jsonObject : NSDictionary!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let response : String = (jsonObject["Response"] as? String)!
                
                if (NSString(string: response).boolValue) {
                
                    success(episodes: self.parseEpisodes(jsonObject))
                }
                
            } catch let error as NSError {

                failure(error: error)
            }

        }
        
        task.resume()
        
        
    }
    
    private func parseEpisodes(responseObject : NSDictionary) -> [imdbEpisode]{
    
        var episodes : [imdbEpisode]! = []
        
        for episode : NSDictionary in responseObject["Episodes"] as! [[String : AnyObject]] {
        
            let tempEpisode : imdbEpisode = imdbEpisode.init(responseObject: episode as! Dictionary<String, AnyObject>)
         
            episodes.append(tempEpisode)
        
        }
    
        return episodes
    }
    
    public func pullEpisodeDetails (imdbID : String, success : (episodeDetails :imdbEpisodeDetails)-> Void , failure : (error :NSError)-> Void)-> Void{
        
        
        let urlString = String( "http://www.omdbapi.com/?i=\(imdbID)&plot=short&r=json")
        
        let url = NSURL(string: urlString)
        
        var jsonObject : NSDictionary!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let response : String = (jsonObject["Response"] as? String)!
                
                if (NSString(string: response).boolValue) {
                    
                    success(episodeDetails: self.parseEpisodeDetails(jsonObject))
                }
                
            } catch let error as NSError {
                
                failure(error: error)
            }
            
        }
        
        task.resume()
        
        
    }
    
    private func parseEpisodeDetails(responseObject : NSDictionary) -> imdbEpisodeDetails{
        
        let episodeDetails : imdbEpisodeDetails = imdbEpisodeDetails.init(responseObject: responseObject as! Dictionary<String, AnyObject>)
            
        return episodeDetails
    }

}
