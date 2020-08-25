//
//  FYHomeViewController.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

fileprivate let uitableviewcellID = "uitableviewcellID"

class FYHomeViewController: FYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        gk_navTitle = "首页"
        gk_navBackgroundImage = imageWithColor(color: UIColor.color(hex: "#ef8900"))
        let rightBtn = IDButton.init(type: .custom)
        rightBtn.setTitle("更换AppIcon", for: .normal)
        rightBtn.setTitleColor(UIColor.color(hex: "#000000"), for: .normal)
        rightBtn.addTarget(self, action: #selector(changeAppIcon), for: .touchUpInside)
        gk_navRightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        setupUI()
//        gk_navBarAlpha = 0
        gk_navigationBar.alpha = 0
        
    }
    
    func setupUI()  {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: -kStatusBarHeight, width: kScreenWidth, height: kScreenHeight - kTabBarHeight + kStatusBarHeight)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: uitableviewcellID)
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    @objc func changeAppIcon() {
        //ios 10.3之后的可以使用
        let alertVC = UIAlertController.init(title: "切换图标", message: "", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "今日头条", style: .default, handler: { (action) in
            UIApplication.shared.setAlternateIconName(nil) { (error) in
                
            }
        }))
        alertVC.addAction(UIAlertAction.init(title: "网易新闻", style: .default, handler: { (action) in
            UIApplication.shared.setAlternateIconName("wangyi") { (error) in
                
            }
        }))
        
        getCurrentController().present(alertVC, animated: true) {
            
        }
    }
   

}

extension FYHomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: uitableviewcellID)!
        cell.backgroundColor = UIColorRandom()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = FYButtonViewController.init()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = FYHomeDetailViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gk_navigationBar.alpha = scrollView.contentOffset.y/kNavBarHeight
    }
    
}
