//
//  FYCategory.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

public extension UIColor {
    // MARK: - extension 适配深色模式 浅色模式 非layer
      ///lightHex  浅色模式的颜色（十六进制）
      ///darkHex   深色模式的颜色（十六进制）
      ///return    返回一个颜色（UIColor）
      static func color(lightHex: String,
                        darkHex: String,
                        alpha: CGFloat = 1.0)
          -> UIColor {
          let light = UIColor(hex: lightHex, alpha) ?? UIColor.black
          let dark =  UIColor(hex: darkHex, alpha) ?? UIColor.white
              
          return color(lightColor: light, darkColor: dark)
      }

      // MARK: - extension 适配深色模式 浅色模式 非layer
      ///lightColor  浅色模式的颜色（UIColor）
      ///darkColor   深色模式的颜色（UIColor）
      ///return    返回一个颜色（UIColor）
     static func color(lightColor: UIColor,
                       darkColor: UIColor)
         -> UIColor {
         if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                 if traitCollection.userInterfaceStyle == .dark {
                     return darkColor
                 }else {
                     return lightColor
                 }
             }
         } else {
            return lightColor
         }
     }
    static func color(hex:String) -> UIColor {
         return UIColor.color(lightHex: hex, darkHex: hex)
     }
     
     // MARK: - 构造函数（十六进制）
      ///hex  颜色（十六进制）
      ///alpha   透明度
     convenience init?(hex : String,
                       _ alpha : CGFloat = 1.0) {
         var cHex = hex.trimmingCharacters(in: CharacterSet.whitespaces).uppercased()
         guard cHex.count >= 6 else {
             return nil
         }
         if cHex.hasPrefix("0X") {
             cHex = String(cHex[cHex.index(cHex.startIndex, offsetBy: 2)..<cHex.endIndex])
         }
         if cHex.hasPrefix("#") {
             cHex = String(cHex[cHex.index(cHex.startIndex, offsetBy: 1)..<cHex.endIndex])
         }

         var r : UInt64 = 0
         var g : UInt64  = 0
         var b : UInt64  = 0

         let rHex = cHex[cHex.startIndex..<cHex.index(cHex.startIndex, offsetBy: 2)]
         let gHex = cHex[cHex.index(cHex.startIndex, offsetBy: 2)..<cHex.index(cHex.startIndex, offsetBy: 4)]
         let bHex = cHex[cHex.index(cHex.startIndex, offsetBy: 4)..<cHex.index(cHex.startIndex, offsetBy: 6)]

         Scanner(string: String(rHex)).scanHexInt64(&r)
         Scanner(string: String(gHex)).scanHexInt64(&g)
         Scanner(string: String(bHex)).scanHexInt64(&b)

         self.init(red:CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
     }
}

//字符串
extension String {
    //MARK:是否是有效的电话号码
    func isValidMobileNumber() -> Bool {
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9]|9[8])\\d{8}$"
        let CM = "^1(3[4-9]|4[7]|5[0-27-9]|6[6]|7[08]|8[2-478])\\d{8}$";
        let CU = "^1(3[0-2]|4[5]|5[56]|7[0156]|8[56]|9[9])\\d{8}$"
        let CT = "^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$"
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        
        let regextestMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestCM = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestCT = NSPredicate(format: "SELF MATCHES %@", CT)
        let regextestPHS = NSPredicate(format: "SELF MATCHES %@", PHS)
        let regextestCU = NSPredicate(format: "SELF MATCHES %@", CU)
        if (regextestMobile.evaluate(with: self) == true) ||
            regextestCM.evaluate(with: self) == true ||
            regextestCT.evaluate(with:self) == true ||
            regextestCU.evaluate(with: self) == true ||
            regextestPHS.evaluate(with: self) == true {
            return true
        }
        return false
    }
    //MARK:是否是有效的银行卡
    func isValidBankCardNumber() -> Bool {
        let BANKCARD = "^(\\d{16}|\\d{19})$";
        let predicate = NSPredicate(format: "SELF MATCHES %@", BANKCARD)
        return predicate.evaluate(with: self)
    }
    
    //MARK:是否是有效的邮箱
    func isValidEmail() -> Bool {
        let emailRegex = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}

extension UIView {
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    ///y
    var y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
            
        }
    }
    
    ///height
    var height : CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    ///width
    var width : CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    //size
    var size : CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    //centerx
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    ///centery
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    ///origin
    var origin : CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
    
    ///maxX
    var maxX : CGFloat {
        get {
            return frame.origin.x + frame.size.width;
        }
    }
    
    ///maxY
    var maxY : CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
    }
    
    ///minX
    var minX : CGFloat {
        get{
            return frame.minX
        }
    }
    
    ///minY
    var minY : CGFloat {
        get{
            return frame.minY
        }
    }
}


extension UIButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
      
        print(self.titleLabel?.text as Any) 
    }
}

extension UITableViewCell {
    
    func addSectionCornerWithTableView(tableView:UITableView,cell:UITableViewCell,indexPath:IndexPath,cornerRadius:CGFloat,fillColor:String) {
        let pathRef = CGMutablePath()
        let bounds = cell.bounds
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            /** 每组只有一行的时候 */
            pathRef.move(to: CGPoint(x: bounds.midX, y: bounds.maxY), transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.minX, y: bounds.midY), radius: cornerRadius, transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius, transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius, transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius, transform: .identity)
        } else if indexPath.row == 0 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY), transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius, transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius, transform: .identity)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY), transform: .identity)
        } else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1) {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY), transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius, transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius, transform: .identity)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY), transform: .identity)
        } else if (indexPath.row != 0 && indexPath.row != tableView.numberOfRows(inSection: indexPath.section) - 1) {
            pathRef.addRect(bounds, transform: .identity)
        }
        
        let layer = CAShapeLayer()
        layer.path = pathRef
        layer.fillColor = UIColor.color(hex: fillColor).cgColor

        let backView = UIView(frame: bounds)
        backView.layer.addSublayer(layer)
        backView.backgroundColor = UIColor.clear
        cell.backgroundView = backView
    }
}
