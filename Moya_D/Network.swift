//
//  Network.swift
//  Moya_D
//
//  Created by idea on 2018/1/2.
//  Copyright © 2018年 idea. All rights reserved.
//

import Moya
import SwiftyJSON

struct Network {
    static let provider = MoyaProvider<Model>()
    
    static func request(
        _ target: Model,
        success successCallback: @escaping (JSON) -> Void,
        error errorCallback: @escaping (Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    //如果数据返回成功则直接将结果转为JSON
//                    filterSuccessfulStatusCodes()：返回状态码为 200 - 299 的响应
//                    filterSuccessfulStatusAndRedirectCodes()：返回状态码为 200 - 399 的响应
                    try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    successCallback(json)
                }
                catch let error {
                    //如果数据获取失败，则返回错误状态码
                    errorCallback((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                //如果连接异常，则返沪错误信息（必要时还可以将尝试重新发起请求）
                //if target.shouldRetry {
                //    retryWhenReachable(target, successCallback, errorCallback,
                //      failureCallback)
                //}
                //else {
                failureCallback(error)
                //}
            }
        }
    }
}
