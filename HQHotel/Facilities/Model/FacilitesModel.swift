//
//  FacilitesModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/21.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class FacilitesModel: JSONJoy {
    var objectlist: [FacilitesInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<FacilitesInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<FacilitesInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(FacilitesInfo(childs))
        }
    }
    
    func append(list: [FacilitesInfo]){
        self.objectlist = list + self.objectlist
    }
}
class FacilitesInfo: JSONJoy{
    var facilitesid:String?
    var facilitestitle: String?
    var facilitescreat_time:String?
    var facilitesphoto:String?
    var facilitescontent:String?
    var facilitesexcerpt:String?
    var facilitesstatus:String?
    var facilitestype:String?
    var facilitesshowid:String?
    
    
    
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        facilitesid = decoder["id"].string
        facilitestitle = decoder["title"].string
        facilitescreat_time = decoder["creat_time"].string
        facilitesphoto = decoder["photo"].string
        facilitescontent = decoder["content"].string
        facilitesexcerpt=decoder["excerpt"].string
        facilitesstatus=decoder["status"].string
        facilitestype=decoder["type"].string
        facilitesshowid=decoder["showid"].string
    }
    
}
