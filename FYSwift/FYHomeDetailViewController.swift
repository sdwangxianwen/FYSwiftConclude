
//
//  FYHomeDetailViewController.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

class FYHomeDetailViewController: FYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        tableView.tableHeaderView = searchController.searchBar
        gk_navTitleView = searchController.searchBar
       
        self.definesPresentationContext = true
        
        let btn1 = UIButton.init(frame: CGRect(x: 0, y: kNavBarHeight, width: 44, height: 44))
        view.addSubview(btn1)
        btn1.setTitle("第一个按钮", for: .normal)
        btn1.backgroundColor = UIColorRandom()
        btn1.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
        let btn2 = UIButton.init(frame: CGRect(x: 0, y: kNavBarHeight + 60, width: 44, height: 44))
        view.addSubview(btn2)
        btn2.setTitle("第2个按钮", for: .normal)
        btn2.backgroundColor = UIColorRandom()
        btn2.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
    }

    lazy var searchController : UISearchController = {
        let resultVC = FYSearchResultViewController()
        let searchVC = UISearchController.init(searchResultsController:resultVC)
        searchVC.searchResultsUpdater = resultVC
        
        return searchVC
    }()
    
    @objc func btnClick(sender:UIButton)  {
        
    }
    
    func setupUI()  {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight - kNavBarHeight)

    }

}

