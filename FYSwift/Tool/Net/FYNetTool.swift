//
//  FYNetTool.swift
//  FYSwift
//
//  Created by wang on 2020/8/19.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit
import Moya

enum FYNetApi {
    case Home(HomeAPI)
    case homeNetWorking(parm:NSMutableDictionary) //例子
}
extension FYNetApi : TargetType {
    var baseURL: URL {
        return URL(string: "http://www.ruidaedu.com")!
       
    }
    
    var path: String {
        let result = self.getConfigure()
        return result.1
        
    }
    var method: Moya.Method {
        let result = self.getConfigure()
        return result.0
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    var task: Task {
        let result = self.getConfigure()
        return .requestParameters(parameters: result.2, encoding: URLEncoding.default)
    }
    var headers: [String : String]? {
        return  [:]
    }
    
    private func getConfigure() -> (Moya.Method,String,[String:Any]) {
        switch self {
        case .Home(let homeAPI):
            return (homeAPI.methond,homeAPI.path,homeAPI.parma)
        case .homeNetWorking(let parm):
            return (.get,"",[:])
        }
      }
}

// MARK: - 默认的网络提示请求插件
let spinerPlugin = NetworkActivityPlugin { (state,target) in
    if state == .began {
        print("我开始请求")
        MCToast.mc_loading()
       
    } else {
        print("我结束请求")
        MCToast.mc_remove()
    }
}

// MARK: - 设置请求超时时间
let requestClosure = {(endpoint: Endpoint, done: @escaping MoyaProvider<FYNetApi>.RequestResultClosure) in
    do {
        var request: URLRequest = try endpoint.urlRequest()
        request.timeoutInterval = 20    //设置请求超时时间
        done(.success(request))
    } catch  {
        print("错误了 \(error)")
        MCToast.mc_remove()
    }
}

var endpointClosure = { (target: FYNetApi) -> Endpoint in
    let sessionId =  ""
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    var endpoint: Endpoint = Endpoint(
        url: url,
        sampleResponseClosure: {.networkResponse(200, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )

    return endpoint.adding(newHTTPHeaderFields: [
        "Cookie" : "", //根据项目需求
        "Content-Type" : "application/x-www-form-urlencoded;application/json;charset=utf-8;multipart/form-data",
        "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;application/x-www-form-urlencoded;text/xml;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*"
        
    ])
}
let provider = MoyaProvider<FYNetApi>(endpointClosure: endpointClosure, requestClosure : requestClosure,plugins:[spinerPlugin])

class FYNetTool: NSObject {
    typealias SuccessJSONClosure = (_ result:NSDictionary) -> Void
    typealias failureCloseure = (_ result : NSDictionary)->Void
    static let shared = FYNetTool()
    
    func netConnect(target:FYNetApi,successClosure: @escaping SuccessJSONClosure,failure:@escaping failureCloseure){
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    let jsonString : NSDictionary = try response.mapJSON() as! NSDictionary
                    successClosure(jsonString)
                    
                } catch  {
                    failure([:])
                }
            case .failure:
                failure([:])
            }
        }
    }
}
