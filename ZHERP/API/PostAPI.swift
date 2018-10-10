//
//  PostAPI.swift
//  RxMoyaRxSwiftCopy
//
//  Created by MrParker on 2018/7/14.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation
//import RxFlow
import Moya

/** 下面定义豆瓣FM请求的endpoints（供provider使用）**/
//请求分类
enum PostAPI {
    case post(postId: Int)
    case channels //获取频道列表
    case playlist(String) //获取歌曲
}

//请求配置
extension PostAPI: TargetType {
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    var headers: [String : String]? {
        return [:]
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .post(_):
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else { fatalError("baseURL could not be configured") }
            return url
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        }
        
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .post(let postId):
            return "posts/\(postId)"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
}

