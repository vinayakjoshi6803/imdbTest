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
