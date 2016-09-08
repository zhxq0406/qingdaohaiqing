//
//  HotelDetailsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/20.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class HotelDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = UIScreen.mainScreen().bounds
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        let topview = UIView(frame: CGRectMake(0,44,self.view.bounds.width,self.view.bounds.width*0.59+40))
        topview.backgroundColor=UIColor.whiteColor()
        let imageV = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.width*0.59))
        imageV.image=UIImage(named: "酒店详情.jpg")
        topview.addSubview(imageV)
        let starL = UILabel(frame: CGRectMake(10,self.view.bounds.width*0.59+10,80,20))
        starL.text="酒店星级"
        starL.font=UIFont.systemFontOfSize(15)
        starL.textColor=UIColor.init(colorLiteralRed: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        topview.addSubview(starL)
        
        let starimageV = UIImageView(frame: CGRectMake((self.view.bounds.width-120), self.view.bounds.width*0.59+10, 110, 18))
        starimageV.image=UIImage(named: "ic_star")
        topview.addSubview(starimageV)
        
        self.view.addSubview(topview)
        let textView = UITextView(frame: CGRectMake(0, frame.size.width*0.59+90, frame.size.width, frame.size.height-(frame.size.width*0.59+90)))
        
        let str = "  青岛海情大酒店座落于青岛著名的海滨大道东海路，是一座汇聚欧陆风情酒店。其占地面积7万平方米，花园绿地面积2.6万平方米，建筑面积5.9万平方米。北 依市中心，南临大海，位置优越，交通便利，距火车站11.5公里，飞机场32公里，码头15公里。由A座、B座和C座三座不同风格的酒店所组成。\r  B座为酒店一期，1998年3月18日正式营业，2001年8月14日被省旅游局正式批准为四星级旅游涉外饭店，建筑格局新颖别致，品字式的住宿环境 别具一格，茶苑、欧州廊等特色项目更让人耳目一新；C座开业于2006年6月10日，是集住宿、商务于一体的海情公寓式酒店，配套完善，简约大方， 为商旅客人的旅游出行带来便捷；A座为酒店二期，于2007年6月28日试营业，7月正式投入运营，拥有标准五道游泳池，新增设六声道同声传译国际会议中心，规模宏大，设施先进，受到国内外客人尤其是高端客人的青睐。\r传统珍馐美馔，西式饕餮大餐，各地美食精粹，青岛地方名吃齐聚海情，中餐厅宴会厅可接待900人同时用餐，菜品涵盖鲁、川、粤等中餐八大菜系，是高档宴会的理想选择；另外还配有日、韩、意等多国籍特色风味餐厅，一站式满足您的美食需求，让您一饱口福。\r  集休闲、娱乐于一身的海情康体中心，汇聚了彰显国威的乒乓、出身贵族的壁球、绅士意味的桌球、休闲随意的沙壶、畅游一池碧水、放松一天奔波。\r  青岛海情大酒店秉承 “亲情、友情、真情”的服务理念，诚信经营，赢得中外宾客广泛赞誉，“温馨家园”的服务品牌闻名遐迩，多次荣获山东省优秀星级饭 店、06年度省“诚信旅游示范单位”及“2006年和2007年青岛国际帆船赛旅游接待突出贡献单位”等荣誉称号。为“北京2008奥林匹克运动会指定官方接待饭店”。"

        textView.text=str
        textView.editable=false
        textView.textColor=textColor
        self.view.addSubview(textView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.tabBarController?.tabBar.hidden=true
        self.title="酒店详情"
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
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
