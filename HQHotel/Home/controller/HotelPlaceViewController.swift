//
//  HotelPlaceViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/20.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class HotelPlaceViewController: UIViewController {

    internal var str:String=String()
     private var mainmapView=MKMapView()
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.navigationItem.title="位置"

        self.navigationItem
        self.view.backgroundColor=UIColor.blackColor()
        mainmapView=MKMapView(frame: self.view.frame)
        self.view.addSubview(mainmapView)
        mainmapView.mapType=MKMapType.Standard
        let latdelta = 0.01
        let longdelta = 0.01
        var currentLocationSpan = MKCoordinateSpan()
        currentLocationSpan=MKCoordinateSpanMake(latdelta, longdelta)
        //使用自定义位置
        let center:CLLocation = CLLocation(latitude: 36.058175, longitude: 120.407200)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
                                                span: currentLocationSpan)
        
        //设置显示区域
        mainmapView.setRegion(currentRegion, animated: true)
        
        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation.coordinate = CLLocation(latitude: 36.058175,
                                                 longitude: 120.407200).coordinate
        //设置点击大头针之后显示的标题
        objectAnnotation.title = "海情大酒店"
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = "四星级大酒店"
        
        //添加大头针
        mainmapView.addAnnotation(objectAnnotation)
        
          }
//view将要出现的时候显示导航栏，隐藏tabbar
       override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.tabBarController?.tabBar.hidden=true
        
        
    }
    //视图将要消失的时候显示导航栏
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }

    
}
