//
//  CaterModel.swift
//  HQHotel
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation

class CaterModel: JSONJoy {
    var status:String?
    var data:CaterInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = CaterInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}

class CaterInfo: JSONJoy{
    var foodId:String?
    var foodName: String?
    var foodPrice:String?
    var foodOprice:String?
    var foodUnit:String?
    var foodDescription : String?
    var foodPicture:String?
    var foodShowid:String?
    var foodTime:String?
    
    var goodlist: [GoodListInfo]
    var photolist: [photolistInfo]
    
    var countTwo: Int{
        return self.photolist.count
    }
    
    var count: Int{
        return self.goodlist.count
    }
    
    init(){
        goodlist = Array<GoodListInfo>()
        photolist = Array<photolistInfo>()
    }
    
    required init(_ decoder: JSONDecoder){
        foodId = decoder["id"].string
        foodName = decoder["name"].string
        foodPrice = decoder["price"].string
        foodOprice = decoder["oprice"].string
        foodUnit = decoder["unit"].string
        foodDescription = decoder["description"].string
        foodPicture = decoder["picture"].string
        foodShowid=decoder["showid"].string
        foodTime=decoder["time"].string
        
        goodlist = Array<GoodListInfo>()
        for childs: JSONDecoder in decoder["goodlist"].array!{
            goodlist.append(GoodListInfo(childs))
        }
        photolist = Array<photolistInfo>()
        for childs: JSONDecoder in decoder["photolist"].array!{
            photolist.append(photolistInfo(childs))
        }

    }
    
    func append(list: [GoodListInfo]){
        self.goodlist = list + self.goodlist
    }
    func addpend(list: [photolistInfo]){
        self.photolist = list + self.photolist
    }
    
    
}
class GoodListInfo: JSONJoy{
    var id:String?
    var name:String?
    var unit: String?
    var price: String?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        id = decoder["id"].string
        unit = decoder["unit"].string
        price = decoder["price"].string
    }
    
}
class photolistInfo: JSONJoy{
    var id:String?
    var photo:String?
   
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        photo = decoder["photo"].string
        id = decoder["id"].string
       
    }
    
}


