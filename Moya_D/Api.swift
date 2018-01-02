//
//  Api.swift
//  Moya_D
//
//  Created by idea on 2018/1/2.
//  Copyright © 2018年 idea. All rights reserved.
//

import Foundation
import Moya
let GfoodsUrl = "https://www.365greenlife.com/api/tiptop/v1/"
let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjEzMzYxNjM5NzIzIiwidXNlcl9pZCI6IjEwMDAxIiwicm9sZV9uYW1lIjoiXHU2NjZlXHU5MDFhXHU3NTI4XHU2MjM3IiwiZXhwIjoxNTE3NDcyMTk0LjE5MzYwMywiaWF0IjoxNTE0ODgwMTk0LjE5MzYwMywidHlwZSI6IjMifQ.PT0s9cIXBa8LVNc5q3ZLfLp9k446btDRyjkFOkjW-ew"
let kJD = "http://139.199.169.203/"
let ApiProvider = MoyaProvider<Model>()

public enum Model{
    case list
    case scores
    case JD
    case operation
}
extension Model:TargetType{
    //    服务器地址
    public var baseURL: URL {
        switch self {
        case .list, .scores, .operation:
            return URL(string: GfoodsUrl)!
        case .JD:
            return URL(string: kJD)!
            //        default:
        }
    }
    //    各个请求的具体路径
    public var path: String {
        switch self {
        case .list:
            return "app/index/list"
        case .scores:
            return "app/integral/login"
        case .operation:
            return "account/address/operation"
        case .JD:
            return "ApiSearch.php"
            //        default:
        }
    }
    //    请求类型
    public var method: Moya.Method {
        switch self {
        case .list, .scores:
            return .get
        default:
            return .post
        }
        
    }
    //    这个是做单元测试的模拟数据，只在单元测试的文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    //    请求任务事件
    public var task: Task {
        switch self {
        case .list, .scores:
            return .requestPlain
        case .operation:
            let param = ["opr":"search","data":["page":1,"limit":6,"cond":["id":" "]]] as [String : Any]
            return .requestParameters(parameters: param, encoding:JSONEncoding.default)
        case .JD:
            let param = ["ShipperCode":"JD","LogisticCode":"64587611799","OrderCode":""] as [String : Any]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            //        default:
            
        }
    }
    
    public var headers: [String : String]? {
        return ["Authorization":token]
    }
}
