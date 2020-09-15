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
    var iteamArr = ["搜索","点赞"]
    
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
//        self.view.backgroundColor = UIColor.color(hex: "#fff6f6f6")

        
    }
    
    func setupUI()  {

        view.addSubview(tableView)
        tableView.frame = CGRect(x: 15, y: kNavBarHeight, width: kScreenWidth - 30, height: kScreenHeight - kTabBarHeight - kNavBarHeight)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: uitableviewcellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
       
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: uitableviewcellID)!
        cell.backgroundColor = .clear
        if indexPath.row <= iteamArr.count - 1 {
            cell.textLabel?.text = iteamArr[indexPath.row]
        } else {
            cell.textLabel?.text = "第\(indexPath.row)行"
        }
//        cell.addSectionCornerWithTableView(tableView: tableView, cell: cell, indexPath: indexPath, cornerRadius: 10)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            cell.addSectionCornerWithTableView(tableView: tableView, cell: cell, indexPath: indexPath, cornerRadius: 10,fillColor: "#f0f0f0")
        } else {
            cell.addSectionCornerWithTableView(tableView: tableView, cell: cell, indexPath: indexPath, cornerRadius: 0,fillColor: "#f0f0f0")
        }
       
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init()
        label.backgroundColor = .white
        label.textColor = UIColorRandom()
        label.text = "第\(section)组"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        gk_navigationBar.alpha = scrollView.contentOffset.y/kNavBarHeight
    }
    
}
