//
//  MassageModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/21.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class MassageModel: JSONJoy {
    var objectlist: [MassageInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<MassageInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<MassageInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(MassageInfo(childs))
        }
    }
    
    func append(list: [MassageInfo]){
        self.objectlist = list + self.objectlist
    }
}
class MassageInfo: JSONJoy{
    var id:String?
    var title: String?
    var content:String?
    var photo:String?
    var create_time:String?
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        title = decoder["title"].string
        content = decoder["content"].string
        photo = decoder["photo"].string
        create_time = decoder["create_time"].string
        
    }
    
}
