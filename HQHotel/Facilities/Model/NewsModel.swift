//
//  NewsModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/21.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class NewsModel: JSONJoy {
    var objectlist: [NewsInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<NewsInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<NewsInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(NewsInfo(childs))
        }
    }
    
    func append(list: [NewsInfo]){
        self.objectlist = list + self.objectlist
    }
}
class NewsInfo: JSONJoy{
    var Newsid:String?
    var Newstitle: String?
    var Newscreat_time:String?
    var Newsphoto:String?
    var Newscontent:String?
    var Newsexcerpt:String?
    var Newsstatus:String?
    var Newstype:String?
    
    
    
    
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        Newsid = decoder["id"].string
        Newstitle = decoder["title"].string
        Newscreat_time = decoder["create_time"].string
        Newsphoto = decoder["photo"].string
        Newscontent = decoder["content"].string
        Newsexcerpt=decoder["excerpt"].string
        Newsstatus=decoder["status"].string
        Newstype=decoder["type"].string
        
    }
    
}
