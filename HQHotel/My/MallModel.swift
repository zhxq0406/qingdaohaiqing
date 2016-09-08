//
//  MallModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class MallModel: JSONJoy {
    var orderlist: [MallInfo]
    var count: Int{
        return self.orderlist.count
    }
    
    init(){
        orderlist = Array<MallInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        orderlist = Array<MallInfo>()
        for childs: JSONDecoder in decoder.array!{
            orderlist.append(MallInfo(childs))
        }
    }
    
    func append(list: [MallInfo]){
        self.orderlist = list + self.orderlist
    }
}
class MallInfo: JSONJoy{
    
    var mallordernum:String?
    var mallgid: String?
    var mallname:String?
    var mallpicture:String?
    var mallid:String?
    var malltime:String?
    var mallstate : String?
    var malltype:String?
    var mallpeoplename:String?
    var mallmobile:String?
    var mallprice:String?
    var mallroomname:String?
    var mallnumber:String?
    var mallmoney : String?
    var mallremarks:String?
    var  username : String?
    
    
    
    
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        
        mallgid = decoder["gid"].string
        mallordernum = decoder["order_num"].string
        mallname = decoder["name"].string
        mallpicture = decoder["picture"].string
        mallid = decoder["id"].string
        malltime = decoder["time"].string
        mallstate = decoder["state"].string
        malltype = decoder["type"].string
        mallpeoplename = decoder["peoplename"].string
        mallmobile = decoder["mobile"].string
        mallprice = decoder["price"].string
        mallroomname = decoder["roomname"].string
        mallnumber = decoder["number"].string
        mallmoney=decoder["money"].string
        mallremarks=decoder["remark"].string
        username=decoder["username"].string
       
    }
    
}
