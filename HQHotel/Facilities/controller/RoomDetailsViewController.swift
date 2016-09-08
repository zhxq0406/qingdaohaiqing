//
//  RoomDetailsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/29.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class RoomDetailsViewController: UIViewController {

     var roomImageView=UIImageView()

    var webView = UIWebView()
    var content = String()
    var name = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        let roomImageView_h = self.view.bounds.width*0.40
        
        roomImageView=UIImageView(frame: CGRectMake(0, 64, self.view.bounds.width, roomImageView_h))
        roomImageView.image=UIImage(named: "青岛海情-1.JPG")
        self.view.addSubview(roomImageView)
        
//        let roomDetailsL_h = roomImageView_h/4
//        roomDetailsL=UILabel(frame: CGRectMake(0,66+roomImageView_h,self.view.bounds.width,roomDetailsL_h))
//        roomDetailsL.backgroundColor=UIColor.whiteColor()
//        roomDetailsL.text="  房间介绍"
//        roomDetailsL.textColor=UIColor.grayColor()
//        self.view.addSubview(roomDetailsL)
//        
//        let detailsL_h = roomImageView_h*0.7
//        detailsL=UITextView(frame: CGRectMake(0,64+roomImageView_h+40+1,self.view.bounds.width,detailsL_h))
//        detailsL.backgroundColor=UIColor.whiteColor()
//
//        
//        detailsL.text="时代感和疯狂日记的看法才能舍得离开凤凰网老人干净利索的基础饿反反复复反反复复反反复复反复发反反复复反反复复反复反复反反复复反反复复"
//
//
//        detailsL.font=UIFont.systemFontOfSize(16)
//        detailsL.textColor=UIColor.grayColor()
//        detailsL.editable=false
//        self.view.addSubview(detailsL)
//        
//        let roomFacilities_h = roomImageView_h/4
//        
//        roomFacilities=UILabel(frame: CGRectMake(0,roomImageView_h+64+roomDetailsL_h+1+detailsL_h+10,self.view.bounds.width,roomFacilities_h))
//        roomFacilities.text="  房间设施"
//        roomFacilities.textColor=UIColor.grayColor()
//        roomFacilities.backgroundColor=UIColor.whiteColor()
//        self.view.addSubview(roomFacilities)
//        
//        facilitiesL=UITextView(frame: CGRectMake(5,roomImageView_h+roomFacilities_h+64+1+10+1+roomDetailsL_h+detailsL_h,self.view.bounds.width-10,roomImageView_h))
//        facilitiesL.backgroundColor=UIColor.whiteColor()
//        facilitiesL.text="收到回复格式机顶盒时间都会放大空间感是对抗肌肤好的苦瓜 v啊就是奋斗哈的剧本客服代表 v贸发局款式简单方便 v灯具包括地方举办发动机被 v 看到解放碑 v的末班车开始觉得吧面对举办的开发局"
//        facilitiesL.font=UIFont.systemFontOfSize(16)
//        facilitiesL.textColor=UIColor.grayColor()
//        facilitiesL.editable=false
//        self.view.addSubview(facilitiesL)
//        
        webView.frame=CGRectMake(0, 64+roomImageView_h, self.view.bounds.width, self.view.bounds.height-roomImageView_h-64)
        webView.loadHTMLString(content, baseURL: nil)
        self.view.addSubview(webView)
        

       
        
    }
   

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.navigationController?.navigationBar.backItem?.title=""

        self.navigationItem.title=name
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
