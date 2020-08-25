
//
//  FYConfig.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

let IS_DEBUG = false //是否为debu模式，一个用来标记是否为测试模式的值，方便做维护处理，不用来回切换debug

//MARK:打印日志
func FYLog<T>(_ message: T, file:String = #file, method:String = #function, line: Int = #line) {
    let msg = "\((file as NSString).lastPathComponent)[\(line)], \(method): \(message) T:\(Thread.current.name ?? "")"
    print(msg)
}

//获取版本号
func getApp_version() -> String {
    let infoDict = Bundle.main.infoDictionary!
    let minorVersion = infoDict["CFBundleShortVersionString"]
    return minorVersion as! String
    
}
//这种判断只有在竖屏的时候有效
let isPhoneX : Bool = (
    //有SceneDelegate的时候
   (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 375, height:812), UIScreen.main.bounds.size) : false) ||
    (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 812, height:375), UIScreen.main.bounds.size) : false) ||
    (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 414, height:896), UIScreen.main.bounds.size) : false) ||
    (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 896, height:414), UIScreen.main.bounds.size) : false))
//    //没有 SceneDelegate的时候
//    if #available(iOS 11.0, *) {
//        if (UIApplication.shared.delegate as? AppDelegate )?.window?.safeAreaInsets.bottom != 0 {
//            return true
//        }
//    }
//    return false
//}

//状态栏高度，iOS13以上这样获取
let kStatusBarHeight =  UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
//let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height //ios13以下这样获取
//屏幕宽度
var kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高度
var kScreenHeight = UIScreen.main.bounds.size.height
/// tabBar高度
let kTabBarHeight:CGFloat = isPhoneX ? 83 : 49
/// nav高度
let kNavBarHeight:CGFloat = isPhoneX ? 88 : 64
/// 底部手势框的高度
let kBottomLineHeight : CGFloat = isPhoneX ? 34 : 0

// 获取当前页面的控制器
/// - Returns: 当前页面的控制器
func getCurrentController() -> UIViewController {
    
    if #available(iOS 13.0, *) {
        var currentVC = UIApplication.shared.windows.first?.rootViewController
        while (currentVC?.presentedViewController != nil) {
            currentVC = currentVC?.presentedViewController
        }
        if (currentVC?.isKind(of: UITabBarController.self))! {
            currentVC = (currentVC as! UITabBarController).selectedViewController
        }
        if (currentVC?.isKind(of: UINavigationController.self))! {
            currentVC = (currentVC as! UINavigationController).visibleViewController
        }
        return currentVC!
    } else {
        var currentVC = UIApplication.shared.keyWindow?.rootViewController
        while (currentVC?.presentedViewController != nil) {
            currentVC = currentVC?.presentedViewController
        }
        if (currentVC?.isKind(of: UITabBarController.self))! {
            currentVC = (currentVC as! UITabBarController).selectedViewController
        }
        if (currentVC?.isKind(of: UINavigationController.self))! {
            currentVC = (currentVC as! UINavigationController).visibleViewController
        }
        return currentVC!
    }
    
}

//获取APP缓存
func getCacheSize()-> String {
    
    // 取出cache文件夹目录
    let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    
    // 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath!)
    
    //快速枚举出所有文件名 计算文件大小
    var size = 0
    for file in fileArr! {
        
        // 把文件名拼接到路径中
        let path = cachePath! + ("/\(file)")
        // 取出文件属性
        let floder = try! FileManager.default.attributesOfItem(atPath: path)
        // 用元组取出文件大小属性
        for (key, fileSize) in floder {
            // 累加文件大小
            if key == FileAttributeKey.size {
                size += (fileSize as AnyObject).integerValue
            }
        }
    }
    
    let totalCache = Double(size) / 1024.00 / 1024.00
    return String(format: "%.2fM", totalCache)
}

func removeCache (){
    // 取出cache文件夹路径.如果清除其他位子的可以将cachesDirectory换成对应的文件夹
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    
    // 打印路径,需要测试的可以往这个路径下放东西
    //print(cachePath)
    // 取出文件夹下所有文件数组
    let files = FileManager.default.subpaths(atPath: cachePath!)
    
    // 点击确定时开始删除
    for p in files!{
        // 拼接路径
        let path = cachePath!.appendingFormat("/\(p)")
        // 判断是否可以删除
        if FileManager.default.fileExists(atPath: path){
            // 删除
            //                try! FileManager.default.removeItem(atPath: path)
            /*******/
            //避免崩溃
            do {
                try FileManager.default.removeItem(atPath: path as String)
            } catch {
                print("removeItemAtPath err"+path)
            }
        }
        
    }
    
}

/// 设置随机颜色
func UIColorRandom() -> UIColor {
    let color: UIColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
    return color;
}
//根据颜色设置一张图片
func imageWithColor(color:UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
    
}
//按钮点击反馈
func feedbackGenerator() {
    let generator = UIImpactFeedbackGenerator.init(style: .light)
    generator.prepare()
    generator.impactOccurred()
    
}
