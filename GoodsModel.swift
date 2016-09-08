//
//  GoodsModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/13.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class GoodsModel: JSONJoy{
    var status:String?
    var data:GoodsInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = GoodsInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class GoodsInfo: JSONJoy{
    var goodid:String?
    var goodname: String?
    var goodprice:String?
    var goodoprice:String?
    var gooddescription:String?
    var goodunit:String?
    var goodshowid:String?
    var goodtime:String?
    var goodpicture:String?
    
    
    
    var goodphotolist: [goodphotolistInfo]
    
    var count: Int{
        return self.goodphotolist.count
    }
    
    init(){
        
        goodphotolist = Array<goodphotolistInfo>()
    }
    
    required init(_ decoder: JSONDecoder){
        goodid = decoder["id"].string
        goodname = decoder["name"].string
        goodprice = decoder["price"].string
        goodoprice = decoder["oprice"].string
        gooddescription=decoder["description"].string
        goodunit=decoder["unit"].string
        goodshowid=decoder["showid"].string
        goodtime=decoder["time"].string
        goodpicture=decoder["picture"].string
        goodphotolist = Array<goodphotolistInfo>()
        for childs: JSONDecoder in decoder["photolist"].array!{
            goodphotolist.append(goodphotolistInfo(childs))
        }
    }
    func addpend(list: [goodphotolistInfo]){
        self.goodphotolist = list + self.goodphotolist
    }
    
}
class goodphotolistInfo: JSONJoy{
    var id:String?
    var photo:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        photo = decoder["photo"].string
        id = decoder["id"].string
        
    }
    
}
