//
//  FYHomeViewController.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

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
        
    }
    @objc func changeAppIcon() {
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      let vc = FYHomeDetailViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
