//
//  CollectModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/19.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class CollectModel: JSONJoy {
    var objectlist: [CollectInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<CollectInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<CollectInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(CollectInfo(childs))
        }
    }
    
    func append(list: [CollectInfo]){
        self.objectlist = list + self.objectlist
    }
}
class CollectInfo: JSONJoy{
    
    var userid:String?
    var collectid:String?
    var collecttitle: String?
    var collectdescription:String?
    var collecttype:String?
    var collectobjectid:String?
    var collecttime:String?
    var collectprice:String?
    var collectphoto:String?
    
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        
        userid=decoder["userid"].string
        collectid = decoder["id"].string
        collecttitle = decoder["title"].string
        collectdescription = decoder["description"].string
        collecttype = decoder["type"].string
        collectobjectid = decoder["object_id"].string
        collecttime=decoder["createtime"].string
        collectprice=decoder["price"].string
        collectphoto=decoder["photo"].string
    
    }
    
}
