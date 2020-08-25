
//
//  FYVoteView.swift
//  FYSwift
//
//  Created by wang on 2020/8/24.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit
import SnapKit

class FYVoteView: UIStackView {
    var voteBtnClickClouse : ((_ voteView:FYVoteView)->())?
    var countNum : NSInteger = 0
    {
        didSet {
            countNum = max(0, countNum)
            if countNum > 0 {
                titleLabel.text = "\(title)\(countNum)"
            } else {
                titleLabel.text = "\(title)"
            }
           
        }
    }
    
    var btnImage:String = "" {
        didSet {
            btn.image = UIImage.init(named: btnImage)
        }
    }
    var title:String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var selectColor:UIColor = .white
    var normalColor : UIColor = .white {
        didSet {
           titleLabel.textColor = normalColor
        }
    }
    
    var isSelected : Bool = false {
        didSet {
            if isSelected == true {
                btn.isSelected = true
                titleLabel.textColor = selectColor
//                countNum += 1
            } else {
                btn.isSelected = false
                titleLabel.textColor = normalColor
//                countNum -= 1
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapAction(action:))))
        axis = .horizontal
        spacing = 5
        addArrangedSubview(btn)
        addArrangedSubview(titleLabel)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(btn.snp.right).offset(-3)
        }
       
    }
    
    lazy var btn:FYFavoriteButton = {
        let btn = FYFavoriteButton.init()
        btn.imageColorOn = .red
        btn.circleColor = .red
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize:13)
        return titleLabel
    }()
    
    @objc func tapAction(action:UIGestureRecognizer)  {
       
        self.isSelected = btn.isSelected
        if btn.isSelected {
            btn.deselect()
            titleLabel.textColor = normalColor
            btn.isSelected = false
            countNum -= 1
        } else {
            btn.select()

            titleLabel.textColor = selectColor
             btn.isSelected = true
            countNum += 1
        }
        if let block = voteBtnClickClouse {
            block(self)
        }
    }
    
  

    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
