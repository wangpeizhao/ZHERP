//
//  PostProvider.swift
//  RxMoyaRxSwiftCopy
//
//  Created by MrParker on 2018/7/14.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper
import ObjectMapper

struct PostProvider {
    
    let provider = MoyaProvider<PostAPI>()
    
    func getPost(numbered number: Int) -> Single<Post> {
        let data = provider.rx.request(.post(postId: number))
            .mapJSON()
            .map{ data -> [[String: Any]] in
                if let json = data as? [String: Any],
                    let channels = json["channels"] as? [[String: Any]]{
                    return channels
                }else {
                    return []
                }
                
            }.asObservable()
//        provider.request(.post(postId: number))
        return provider.rx.request(.post(postId: number)) // PostAPI.post
//            .mapArray()
            .filter(statusCode: 200)
            .map(Post.self)
    }
    
    //获取频道数据
    func loadChannels() -> Observable<[Channel]> {
        return provider.rx.request(.channels)
            .mapObject(Douban.self)
            .map{ $0.channels ?? [] }
            .asObservable()
    }
    
    //获取歌曲列表数据
    func loadPlaylist(channelId:String) -> Observable<Playlist> {
        return provider.rx.request(.playlist(channelId))
            .mapObject(Playlist.self)
            .asObservable()
    }
    
    //获取频道下第一首歌曲
    func loadFirstSong(channelId:String) -> Observable<Song> {
        return loadPlaylist(channelId: channelId)
            .filter{ $0.song.count > 0}
            .map{ $0.song[0] }
    }
    
    //获取歌曲列表数据
//    func loadPlaylist(channelId: String) -> Observable<Channel> {
//        return provider.rx.request(.channels)
//            .mapObject(Douban.self)
//            .map{ $0.channels ?? [] }
//            .asObservable()
//    }
}
