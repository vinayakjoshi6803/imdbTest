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
    
    var episode: imdbEpisodeDetails? {
        didSet {
            
            print(episode)
            
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
    
        let imdbService : imdbServiceManager = imdbServiceManager()
        imdbService.pullEpisodeDetails(imdbID!, success: { (episodeDetails) in
            self.isdetailsLoaded = true
            self.episode = episodeDetails
        }) { (error) in
            print(error)
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        self.tableView.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: self.tableView, waitUntilDone: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.episode?.title
        
        // Do any additional setup after loading the view, typically from a nib.
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
                case 0:
                    cell!.textLabel!.text = "Title"
                    cell!.detailTextLabel?.text = self.episode!.title
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left
                    break
                    
                case 1:
                    cell!.textLabel!.text = "Rated"
                    cell!.detailTextLabel?.text = self.episode!.rated
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case 2:
                    cell!.textLabel!.text = "Released"
                    cell!.detailTextLabel?.text = self.episode!.released
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case 3:
                    cell!.textLabel!.text = "Season"
                    cell!.detailTextLabel?.text =  self.episode!.season
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case 4:
                    cell!.textLabel!.text = "Episode"
                    cell!.detailTextLabel?.text = self.episode!.episode
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                case 5:
                    cell!.textLabel!.text = "Runtime"
                    cell!.detailTextLabel?.text = self.episode!.runtime
                    cell!.detailTextLabel?.textAlignment = NSTextAlignment.Left


                    break
                    
                default:
                    
                    break
    
            }
        
        
        return cell!
    }


}

