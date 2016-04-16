//
//  IMDBServiceManager.swift
//  imbd
//
//  Created by Vinayak Bipin Joshi on 3/27/16.
//
//

import Foundation

public class IMDBServiceManager : NSObject {
    
    public func pullEpisodesListingForSeason (seanson : Int, success : (episodes :[IMDBEpisode])-> Void , failure : (error :NSError)-> Void)-> Void{
        
        let urlString = String( "\(URL.baseURL.rawValue)?t=Game%20of%20Thrones&Season=\(seanson)")
        
        let url = NSURL(string: urlString)
        
        request(url!, success: { (jsonObject) in

            success(episodes: self.parseEpisodes(jsonObject))
            
        }) { (error) in
                failure(error: error)
 
        }
    }
    
    // network call, success: returns json object failure: returns error object
    
    private func request(url :NSURL, success: (jsonObject: NSDictionary)->Void, failure: (error: NSError)->Void){
    
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
        
            var jsonObject : NSDictionary!
   
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let response : String = (jsonObject["Response"] as? String)!
                
                if (NSString(string: response).boolValue) {
                    
                    success(jsonObject: jsonObject)
                }
                
            } catch let error as NSError {
                
                failure(error: error)
            }
            
        }
        
        task.resume()
        
    }
    
    private func parseEpisodes(responseObject : NSDictionary) -> [IMDBEpisode]{
    
        var episodes : [IMDBEpisode]! = []
        
        for episode : NSDictionary in responseObject["Episodes"] as! [[String : AnyObject]] {
        
            let tempEpisode : IMDBEpisode = IMDBEpisode.init(responseObject: episode as! Dictionary<String, AnyObject>)
         
            episodes.append(tempEpisode)
        
        }
    
        return episodes
    }
    
    public func pullEpisodeDetails (IMDBID : String, success : (episodeDetails :IMDBEpisodeDetails)-> Void , failure : (error :NSError)-> Void)-> Void{
        
        
        let urlString = String( "\(URL.baseURL.rawValue)?i=\(IMDBID)&plot=short&r=json")
        
        let url = NSURL(string: urlString)
        
        request(url!, success: { (jsonObject) in
            
            success(episodeDetails: self.parseEpisodeDetails(jsonObject))
            
        }) { (error) in
            failure(error: error)
            
        }
        
    }
    
    private func parseEpisodeDetails(responseObject : NSDictionary) -> IMDBEpisodeDetails{
        
        let episodeDetails : IMDBEpisodeDetails = IMDBEpisodeDetails.init(responseObject: responseObject as! Dictionary<String, AnyObject>)
            
        return episodeDetails
    }

}
