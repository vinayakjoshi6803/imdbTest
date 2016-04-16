//
//  DetailViewController.swift
//  imbd
//
//  Created by Vinayak Bipin Joshi on 3/27/16.
//
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var tableView: UITableView! = UITableView()

    var isdetailsLoaded : Bool = false
   
    enum FIELDS: String {
        case Title, Rated, Released, Season, Episode, Runtime
    }
    
    var episode: IMDBEpisodeDetails? {
        didSet {
    
            if  episode != nil {
                // Update the view.
                self.configureView()

            }
            
        }
    }
    
    var imdbID : String? {
    
        didSet {

            pullEpisodeDetails(imdbID)
            
        }
    }
    
    
    func pullEpisodeDetails(imdbID : String?){
    
        let IMDBService : IMDBServiceManager = IMDBServiceManager()
        IMDBService.pullEpisodeDetails(imdbID!, success: { (episodeDetails) in
            self.isdetailsLoaded = true
            self.episode = episodeDetails
        }) { (error) in
            print(error)
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        reloadTableData(self.tableView)
        self.title = self.episode?.title

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table View
    
      func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.isdetailsLoaded {
            return 6
        }
        return 0
        
    }
    
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var cell : UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("Cell")

        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        switch indexPath.row {
                case FIELDS.Title.hashValue:
                    cell!.textLabel!.text = FIELDS.Title.rawValue
                    cell!.detailTextLabel?.text = self.episode!.title
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left
                    break
                    
                case FIELDS.Rated.hashValue:
                    cell!.textLabel!.text = FIELDS.Rated.rawValue
                    cell!.detailTextLabel?.text = self.episode!.rated
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case FIELDS.Released.hashValue:
                    cell!.textLabel!.text = FIELDS.Released.rawValue
                    cell!.detailTextLabel?.text = self.episode!.released
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case FIELDS.Season.hashValue:
                    cell!.textLabel!.text = FIELDS.Season.rawValue
                    cell!.detailTextLabel?.text =  self.episode!.season
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case FIELDS.Episode.hashValue:
                    cell!.textLabel!.text = FIELDS.Episode.rawValue
                    cell!.detailTextLabel?.text = self.episode!.episode
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case FIELDS.Runtime.hashValue:
                    cell!.textLabel!.text = FIELDS.Runtime.rawValue
                    cell!.detailTextLabel?.text = self.episode!.runtime
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                    
                default:
                    
                    break
    
            }
        
        
        return cell!
    }


}

