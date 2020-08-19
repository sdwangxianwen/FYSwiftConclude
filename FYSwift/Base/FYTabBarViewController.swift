//
//  FYTabBarViewController.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

class FYTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundImage = UIImage.init()
        self.delegate = self
        self.tabBar.tintColor = UIColor.color(hex: "#e90000")
        self.tabBar.isTranslucent = false
        setupChild()

    }
    
    func setupChild() {
        let homeVC = FYHomeViewController.init()
        addChild(homeVC, title: "首页", imageName:"", imageSelectName: "")
      
    }
    func addChild(_ childController: UIViewController,title:String,imageName:String,imageSelectName:String) {
        
        childController.tabBarItem = UITabBarItem.init(title: title, image:UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: imageSelectName)?.withRenderingMode(.alwaysOriginal))
        addChild(childController)
    }
    
    lazy var hideTabbarLine: Bool = {
        // 隐藏 tabbar 上部的线
        for view in self.tabBar.subviews {
            if view.width == kScreenWidth/*屏幕看度*/ {
                for image in view.subviews {
                    //   print("height:   \(image.height)")
                    if image.height < 2 {
                        image.alpha = 0.3
                        return true
                    }
                }
            }
        }
        return true
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard self.hideTabbarLine else { // 隐藏 tabbar 上部的线
            return
        }
    }
    
    func animationWithIndex(index:NSInteger) {
        let tabbarbuttonArray : NSMutableArray = NSMutableArray.init()
        
        for tabBarButton : UIView in self.tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabbarbuttonArray.add(tabBarButton)
            }
        }
        tabbarButtonClick(tabbarButton: tabbarbuttonArray[index] as! UIControl)
        
    }
    
    func tabbarButtonClick(tabbarButton : UIControl)  {
        for imageView : UIView in tabbarButton.subviews {
            if imageView.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                let animation : CAKeyframeAnimation  = CAKeyframeAnimation.init()
                animation.keyPath = "transform.scale"
                animation.values = [1.0,1.1,0.9,1.0]
                animation.duration = 0.25
                animation.calculationMode = .cubic
                imageView.layer.add(animation, forKey: nil)
                
            }
        }
    }

}

extension FYTabBarViewController : UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           feedbackGenerator()
           animationWithIndex(index: (self.tabBar.items?.firstIndex(of: item))!)
       }
}
