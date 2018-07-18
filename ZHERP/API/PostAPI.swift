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

enum PostAPI {
    case post(postId: Int)
    case channels //获取频道列表
    case playlist(String) //获取歌曲
}

extension PostAPI: TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var baseURL: URL {
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
    
    var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .post(let postId):
            return "posts/\(postId)"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
}

