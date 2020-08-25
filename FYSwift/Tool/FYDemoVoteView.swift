//
//  FYDemoVoteView.swift
//  FYSwift
//
//  Created by wang on 2020/8/24.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

class FYDemoVoteView: UIStackView {
    var countArr = [30,40,50]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        axis = .horizontal
        spacing = 10
        addArrangedSubview(vote1)
        addArrangedSubview(vote2)
        addArrangedSubview(vote3)
        vote1.countNum = 30
        vote2.countNum = 40
        vote3.countNum = 50
        
        vote1.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(self)
        }
        
        vote2.snp.makeConstraints { (make) in
            make.left.equalTo(vote1.snp.right).offset(10)
            make.centerY.equalTo(self)
        }
        vote3.snp.makeConstraints { (make) in
            make.left.equalTo(vote2.snp.right).offset(10)
            make.centerY.equalTo(self)
        }
    }
    
    lazy var vote1 : FYVoteView = {
        let vote = FYVoteView.init()
        vote.btnImage = "smile"
        vote.title = "有趣"
    
        vote.normalColor = UIColor.color(hex: "#666666")
        vote.selectColor = .red
        vote.countNum = 30
        vote.isSelected = true
        vote.voteBtnClickClouse = {[weak self] (voteview : FYVoteView) in
            guard let sself = self  else {return}
            sself.voteIteamClick(vote: voteview)
        }
        return vote
    }()
    
    lazy var vote2 : FYVoteView = {
        let vote = FYVoteView.init()
        vote.btnImage = "tuijian2"
        vote.title = "推荐"
        vote.normalColor = UIColor.color(hex: "#666666")
        vote.selectColor = .red
        vote.countNum = 40
       vote.voteBtnClickClouse = {[weak self] (voteview : FYVoteView) in
           guard let sself = self  else {return}
           sself.voteIteamClick(vote: voteview)
       }
        return vote
    }()
    
    lazy var vote3 : FYVoteView = {
        let vote = FYVoteView.init()
        vote.btnImage = "butuijian1"
        vote.title = "不推荐"
        vote.normalColor = UIColor.color(hex: "#666666")
        vote.selectColor = .red
        vote.countNum = 50
        vote.voteBtnClickClouse = {[weak self] (voteview : FYVoteView) in
            guard let sself = self  else {return}
            sself.voteIteamClick(vote: voteview)
        }
        return vote
    }()
    
    func voteIteamClick(vote:FYVoteView)  {
        FYLog(vote)

        for index:NSInteger  in 0..<self.arrangedSubviews.count {
            let subVoteView : FYVoteView = self.arrangedSubviews[index] as! FYVoteView
            
            if subVoteView == vote {
                subVoteView.isSelected = !vote.isSelected
                subVoteView.countNum = vote.countNum
//                if subVoteView.isSelected {
//                    subVoteView.countNum = subVoteView.countNum + 1
//                } else {
//                     subVoteView.countNum = subVoteView.countNum - 1
////                   subVoteView.countNum = countNum - 1
//                }
         
            }else {
                subVoteView.isSelected = false
//                subVoteView.countNum = subVoteView.countNum
                
            }
        }
       
       
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
