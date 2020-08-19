//
//  FYBaseViewController.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

class FYBaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MCToast.mc_remove()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let nav = navigationController {
            self.gk_interactivePopDisabled = nav.children.count <= 1
            self.gk_fullScreenPopDisabled = nav.children.count <= 1
        } else {
            self.gk_interactivePopDisabled = true
            self.gk_fullScreenPopDisabled = true
        }
        self.gk_navLineHidden = true
//         gk_backImage = UIImage.init(named: "customback") //自定义返回按钮的图标

    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return self.gk_statusBarHidden
    }
    //设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.gk_statusBarStyle
    }
    
    lazy var tableView:UITableView = {
        let mainTableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        mainTableView.frame = CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight - kNavBarHeight)
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.backgroundColor = UIColor.color(lightHex: "#ffffff", darkHex: "#ffffff")
        if #available(iOS 11.0, *) {
            mainTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 200
        mainTableView.tableFooterView = UIView.init()
        return mainTableView
    }()
    
    lazy var groupTableView : UITableView = {
        let mainTableView = UITableView.init(frame: CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight - kNavBarHeight - kBottomLineHeight), style: .grouped)
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.backgroundColor = .white
        if #available(iOS 11.0, *) {
            mainTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 200
        return mainTableView
    }()

  
}
