//
//  HomeApi.swift
//  FYSwift
//
//  Created by wang on 2021/10/27.
//  Copyright © 2021 wang. All rights reserved.
//大文件请求地址的拆分，防止moya一堆case,以此为例。例如首页的接口

import UIKit
import Moya

enum HomeAPI{
    case home
    case banner
    case list
    case demo
}

extension HomeAPI {
    var path:String{
        switch self {
        case .home:
            return "/mapi/auth/token/getToken"
        case .banner:
            return "/module/home.do"
        case .list:
            return ""
        case .demo:
            return ""
        }
    }
    
    var methond : Moya.Method {
        switch self {
        case .home:
            return .get
        case .banner:
            return .get
        case .list:
            return .get
        case .demo:
            return .get
        }
    }
    
    var parma:[String:Any] {
        let time = SSDateHelper.init().stringFromDate(date: Date(), formmtter: "yyyy-MM-dd HH:mm:ss")
        let pkey = ("0" + "1.3.0" + time + "Nyjh5AEeMw" + "37b7a9fb-f84c-43d0-a5f7-6a28e35dca4f").md5
        let parm = ["version":"1.3.0",
                    "time":time,
                    "pkey":pkey,
                    "platformSource":"0",
                    "appkey":"37b7a9fb-f84c-43d0-a5f7-6a28e35dca4f"]
        return parm
    }
    
}

class HomeApi: NSObject {

}
