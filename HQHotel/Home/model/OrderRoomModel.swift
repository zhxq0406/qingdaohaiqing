//
//  OrderRoomModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/17.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class OrderRoomModel: JSONJoy {
    var objectlist: [OrderRoomInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<OrderRoomInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<OrderRoomInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(OrderRoomInfo(childs))
        }
    }
    
    func append(list: [OrderRoomInfo]){
        self.objectlist = list + self.objectlist
    }
}
class OrderRoomInfo: JSONJoy{
    var idLab:String?
    var name: String?
    var price:String?
    var picture:String?
    var oprice:String?
    var repast:String?
    var acreage:String?
    var bed:String?
    var size:String?
    var floor:String?
    var network:String?
    
    
    
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        idLab = decoder["id"].string
        name = decoder["name"].string
        price = decoder["price"].string
        picture = decoder["picture"].string
        oprice=decoder["oprice"].string
        repast=decoder["repast"].string
        acreage=decoder["acreage"].string
        bed=decoder["bedsize"].string
        size=decoder["adtitle"].string
        floor=decoder["floor"].string
        network=decoder["network"].string
    }
    
}
