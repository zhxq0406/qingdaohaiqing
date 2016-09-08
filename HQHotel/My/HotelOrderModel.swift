//
//  HotelOrderModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/6.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation


class HotelOrderModel: JSONJoy {
    var orderlist: [HotelOrderInfo]
    var count: Int{
        return self.orderlist.count
    }
    
    init(){
        orderlist = Array<HotelOrderInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        orderlist = Array<HotelOrderInfo>()
        for childs: JSONDecoder in decoder.array!{
            orderlist.append(HotelOrderInfo(childs))
        }
    }
    
    func append(list: [HotelOrderInfo]){
        self.orderlist = list + self.orderlist
    }
}
class HotelOrderInfo: JSONJoy{
    
    var order_num : String?
    
    var ordergid:String?
    var ordername: String?
    var orderid:String?
    var ordertime:String?
    var orderstate:String?
    var ordertype:String?
    var ordermobile:String?
    var orderprice:String?
    var orderpicture:String?
    var ordernumber:String?
    var ordermoney:String?
    var orderbegintime:String?
    var orderendtime:String?
    var orderarrivetime:String?
    var orderremarks:String?
    var orderpeoplenumber:String?
    var orderpeoplename : String?
    
    

    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
       
        order_num=decoder["order_num"].string
        ordergid = decoder["gid"].string
        ordername = decoder["name"].string
        orderid = decoder["rid"].string
        ordertime = decoder["time"].string
        orderstate = decoder["state"].string
        ordertype = decoder["type"].string
        ordermobile = decoder["mobile"].string
        orderprice = decoder["price"].string
        orderpicture = decoder["picture"].string
        ordernumber = decoder["number"].string
        ordermoney = decoder["money"].string
        orderbegintime = decoder["begintime"].string
        orderendtime = decoder["endtime"].string
        orderarrivetime = decoder["arrivetime"].string
        orderremarks = decoder["remarks"].string
        orderpeoplenumber = decoder["peoplenumber"].string
        orderpeoplename=decoder["peoplename"].string

    }
    
}
