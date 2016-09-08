//
//  ShoppingModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/13.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class ShoppingModel: JSONJoy {
    var objectlist: [ShoppingInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<ShoppingInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<ShoppingInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ShoppingInfo(childs))
        }
    }
    
    func append(list: [ShoppingInfo]){
        self.objectlist = list + self.objectlist
    }
}
class ShoppingInfo: JSONJoy{
    var shopid:String?
    var shopname: String?
    var shopprice:String?
    var shoppicture:String?
    var shopdescription:String?
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        shopid = decoder["id"].string
        shopname = decoder["name"].string
        shopprice = decoder["price"].string
        shoppicture = decoder["picture"].string
        shopdescription=decoder["description"].string
            }
    
}
