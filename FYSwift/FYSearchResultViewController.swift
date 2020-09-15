//
//  FYSearchResultViewController.swift
//  FYSwift
//
//  Created by wang on 2020/8/28.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

class FYSearchResultViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
     tableView.contentInsetAdjustmentBehavior = .never
       
    }
    

   
}

extension FYSearchResultViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
