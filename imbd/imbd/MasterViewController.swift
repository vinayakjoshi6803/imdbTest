//
//  MasterViewController.swift
//  imbd
//
//  Created by Vinayak Bipin Joshi on 3/27/16.
//
//

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet var tableView: UITableView!

    @IBOutlet var toolBar: UIToolbar!
    lazy var detailViewController: DetailViewController? = nil
    let seasonsToList = 5
   
    var season : Int = 1 {
        didSet {
        
            pullEpisodesForSeason()

        }
    }
   lazy var episodes = [IMDBEpisode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullEpisodesForSeason()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

    }

    @IBAction func btnActionPressed(sender: AnyObject) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Season", preferredStyle: .ActionSheet)
        
        for i in 1...seasonsToList {
            
            let action = UIAlertAction(title: "Season \(i)", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.season = i
            })
            
            optionMenu.addAction(action)
        }
        
        let cancelAction  = UIAlertAction(title: "Cancel", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cancelAction)

        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    @IBAction func btnRefreshPressed(sender: AnyObject) {
        pullEpisodesForSeason()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Game of Thrones"

    }
    
    func pullEpisodesForSeason (){
        
        let IMDBService : IMDBServiceManager = IMDBServiceManager()
        
            IMDBService.pullEpisodesListingForSeason(self.season, success: { (episodes) in
                
                self.episodes = episodes
                reloadTableData(self.tableView)
            }) { (error) in
                print(error)
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                guard let controller = (segue.destinationViewController as! UINavigationController).topViewController as? DetailViewController else {return}
                navigationItem.title = nil
                controller.imdbID = episodes[indexPath.row].imdbID
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - TableView delegates

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func setEditing(editing: Bool, animated: Bool) {
        // Toggles the edit button state
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tableView.setEditing(editing, animated: true)
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let episode = self.episodes[indexPath.row] 
        cell.textLabel!.text = episode.title
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return self.tableView.editing
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.episodes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } 
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Season \(season)"
    }

}
