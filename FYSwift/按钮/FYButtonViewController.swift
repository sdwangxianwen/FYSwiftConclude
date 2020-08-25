//
//  FYButtonViewController.swift
//  FYSwift
//
//  Created by wang on 2020/8/21.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

class FYButtonViewController: FYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let btn = FYFavoriteButton.init(frame: CGRect(x: 0, y: 100, width: 30, height: 30), image: UIImage.init(named: "tuijian2"))
//        btn.image = UIImage.init(named: "smile")
//        btn.titleLabel?.text = "喜欢"
//
//        btn.imageColorOn = .red
//        btn.circleColor = .red
//        btn.setTitleColor(.red, for: .normal)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize:13)
        
        let btn = FYVoteView.init()
        btn.title = "喜欢"
        btn.btnImage = "smile"
        btn.selectColor = .red
        btn.normalColor = .black
        btn.isSelected = true
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(100)
        }
        
        
        let btn1 = FYFavoriteButton.init(frame: CGRect(x: 40, y: 140, width: 30, height: 30), image: UIImage.init(named: "butuijian1"))
        btn1.imageColorOn = .black
        btn1.circleColor = .black
        btn1.lineColor = .black
        btn1.addTarget(self, action: #selector(starbtnClick(sender:)), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = FYFavoriteButton.init(frame: CGRect(x: 70, y: 140, width: 30, height: 30), image: UIImage.init(named: "smile"))
        btn2.imageColorOn = .red
        btn2.circleColor = .red
        btn2.lineColor = .red
        btn2.imageColorOff = .gray
        btn2.addTarget(self, action: #selector(starbtnClick(sender:)), for: .touchUpInside)
        view.addSubview(btn2)
        
        let voteView : FYDemoVoteView = FYDemoVoteView.init()
        view.addSubview(voteView)
    
        voteView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(200)
            make.height.equalTo(30)
        }
        
       
    }
    
   @objc func starbtnClick(sender:FYFavoriteButton)  {
        if sender.isSelected {
            sender.deselect()
        } else {
            sender.select()
        }
    }


}
