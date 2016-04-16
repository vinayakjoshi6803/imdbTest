//
//  Utils.swift
//  imbd
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/15/16.
//
//

import Foundation
import UIKit

// this is recomended by apple to update ui on main thread
public func reloadTableData(tableView: UITableView){
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        tableView.reloadData()
    })
}


// MARK: apply application default colors for navbar,toolbar etc
func applyAppTheme(){
    
    UINavigationBar.appearance().barTintColor = UIColor(hexString: HEXCOLORS.navbarColor.rawValue)
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    
    UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Normal)
    
    UIToolbar.appearance().tintColor = UIColor.whiteColor()
    UIToolbar.appearance().barTintColor = UIColor(hexString: HEXCOLORS.navbarColor.rawValue)
    
}
