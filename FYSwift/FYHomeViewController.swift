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
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      let vc = FYHomeDetailViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
