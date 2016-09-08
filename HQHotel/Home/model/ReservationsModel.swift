//
//  ReservationsModel.swift
//  HQHotel
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation


class ReservationsModel: JSONJoy {
    var objectlist: [ReservationsInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<ReservationsInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<ReservationsInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ReservationsInfo(childs))
        }
    }
    
    func append(list: [ReservationsInfo]){
        self.objectlist = list + self.objectlist
    }
}
class ReservationsInfo: JSONJoy{
    var idLab:String?
    var name: String?
    var price:String?
    var picture:String?
    var adtitle:String?
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        idLab = decoder["id"].string
        name = decoder["name"].string
        price = decoder["price"].string
        picture = decoder["picture"].string
        type = decoder["type"].integer
        adtitle=decoder["adtitle"].string
    }
    
}
