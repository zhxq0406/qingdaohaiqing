//
//  ShopListModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/23.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class ShopListModel: JSONJoy{
    var status:String?
    var data:ShopListInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = ShopListInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class ShopListInfo: JSONJoy{
    
    var shopname: String?
    var shopprice:String?
    var shoppicture:String?
    var shopdescription:String?

    
        init(){
        
    }
    
    required init(_ decoder: JSONDecoder){
        shopname = decoder["name"].string
        shopprice = decoder["price"].string
        shopdescription = decoder["description"].string
        shoppicture = decoder["picture"].string
    }
    
}
