//
//  PersonalModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/22.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class PersonalModel: JSONJoy{
    var status:String?
    var data:PersonalInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = PersonalInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class PersonalInfo: JSONJoy{
    var personaltime:String?
    var personalname: String?
    var personalphone:String?
    var personalcity:String?
    var personalqq:String?
    var personalweixin:String?
    var personalphoto:String?
    init(){
    }
    required init(_ decoder: JSONDecoder){
        personaltime = decoder["time"].string
        personalname = decoder["name"].string
        personalphone = decoder["phone"].string
        personalcity = decoder["city"].string
        personalqq = decoder["qq"].string
        personalweixin = decoder["weixin"].string
        personalphoto = decoder["photo"].string
        
    }}
