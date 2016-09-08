//
//  HomeViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/14.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class HomeViewController: UIViewController,UIScrollViewDelegate ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    private var scrollView:UIScrollView!
    private var tableView:UITableView!
    private var searchbar:UISearchBar!
    internal var starttime:String=String()
    internal var endtime:String=String()
    internal var tianshu:Int=Int()
    private var timeleftBT = UIButton()
    private var endtimeBT = UIButton()
    private var  daysL = UILabel()
    var strNowTime=String()
    var strNowTime1=String()
    var str = String()
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var resrvationSource = ReservationsModel()
    
    private let numOfPages=4
    
    var num=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.tintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        let frame = self.view.bounds
        
        tableView=UITableView(frame: CGRectMake(0, -20, frame.width, frame.height-24), style: UITableViewStyle.Plain)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.rowHeight=250
        tableView.showsVerticalScrollIndicator=false
        tableView.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        tableView.separatorStyle = .None
        
        self.GetDate()
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.headerRefresh))
        // 现在的版本要用mj_header
        tableView.mj_header = header
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.footerRefresh))
        tableView.mj_footer = footer
        //searchbar
        searchbar=UISearchBar(frame: CGRectMake(20, 20, frame.width-40, 30))
        searchbar.searchBarStyle=UISearchBarStyle.Minimal
        searchbar.layer.cornerRadius=5
        searchbar.layer.masksToBounds=true
        searchbar.placeholder="搜索"
        searchbar.tintColor=UIColor.whiteColor()
        let textFieldInsideSearchBar=searchbar.valueForKey("searchField")as?UITextField
        
        textFieldInsideSearchBar?.textColor=UIColor.whiteColor()
        textFieldInsideSearchBar?.backgroundColor=UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        let textFieldInsideSearchBarLabel=textFieldInsideSearchBar!.valueForKey("placeholderLabel")as?UILabel
        
        textFieldInsideSearchBarLabel?.textColor=UIColor.whiteColor()
 
        searchbar.keyboardType=UIKeyboardType.Default
        
        searchbar.delegate=self
    
        //创建一个view作为表示图的头视图
        let headerview = UIView(frame: CGRectMake(0, 0, frame.width, frame.width*0.55+frame.width*0.4+40+30))
       headerview.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        //滚动式图
        let scrollview_h = frame.width*0.55
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, frame.width, scrollview_h))
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: scrollview_h)
        scrollView.delegate = self
        
        //滚动式图添加图片
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "青岛海情-\(index).jpg"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: scrollview_h)
            scrollView.addSubview(imageView)
        }
        
        //滚动视图添加小白点
        let pageC = UIPageControl()
        pageC.frame=CGRectMake(frame.size.width/2-20, 200, 40, 20)
        
        pageC.tag=102
        pageC.numberOfPages=4
        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
        //添加手势，点击空白处收回键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewtap))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        

        //时间预定view
        let timeV_h = frame.width*0.4
        let timeV_w = frame.width-20
        
        
        let timeV = UIView(frame: CGRectMake(10, scrollview_h-20, frame.width-20, timeV_h))
        timeV.backgroundColor=UIColor.whiteColor()
        
        let ruzhuL = UILabel(frame: CGRectMake(60, 10, 40, 20))
        ruzhuL.text="入住"
        ruzhuL.font=UIFont.boldSystemFontOfSize(16)
        ruzhuL.textColor=UIColor.grayColor()
        let lidianL = UILabel(frame: CGRectMake(frame.width-100, 10, 40, 20))
        lidianL.text="离店"
        lidianL.textAlignment = .Right
        lidianL.font=UIFont.boldSystemFontOfSize(16)
        lidianL.textColor=UIColor.grayColor()
        daysL = UILabel(frame: CGRectMake(frame.width/2-20, 10, 40, 20))
        daysL.textColor=UIColor.init(colorLiteralRed: 250/255, green: 140/255, blue: 60/255, alpha: 1)
        daysL.font=UIFont.boldSystemFontOfSize(15)
        timeleftBT = UIButton(frame: CGRectMake(20, 50, 150, 20))
        timeleftBT.setTitleColor(UIColor.init(colorLiteralRed: 0/255, green: 166/255, blue: 251/255, alpha: 1), forState: UIControlState.Normal)

        timeleftBT.titleLabel?.textAlignment = .Left
        timeleftBT.addTarget(self, action: #selector(timeStart), forControlEvents: UIControlEvents.TouchUpInside)
        endtimeBT = UIButton(frame: CGRectMake((self.view.bounds.width-190),50,150,20))
        
        endtimeBT.setTitleColor(UIColor.init(colorLiteralRed: 0/255, green: 166/255, blue: 251/255, alpha: 1), forState: UIControlState.Normal)

        endtimeBT.titleLabel?.textAlignment = .Right
        endtimeBT.addTarget(self, action: #selector(timeStart), forControlEvents: UIControlEvents.TouchUpInside)
        
        let reserveBT = UIButton(frame: CGRectMake(10,timeV_h-50,timeV_w-20,40))
        reserveBT.setTitle("立即预订", forState: UIControlState.Normal)
        reserveBT.backgroundColor=UIColor.init(colorLiteralRed: 0/255, green: 166/255, blue: 251/255, alpha: 1)
        reserveBT.addTarget(self, action: #selector(lijiyuding), forControlEvents: .TouchUpInside)
        reserveBT.layer.cornerRadius=5
        
        
        
        timeV.addSubview(reserveBT)
        timeV.addSubview(timeleftBT)
        timeV.addSubview(daysL)
        timeV.addSubview(lidianL)
        timeV.addSubview(ruzhuL)
        timeV.addSubview(endtimeBT)
        //传值赋值
        timeleftBT.setTitle(starttime, forState: UIControlState.Normal)
        endtimeBT.setTitle(endtime, forState: UIControlState.Normal)
        daysL.text="\(String(tianshu))天"
        daysL.textAlignment = .Center
        daysL.layer.borderWidth=1.0
        daysL.layer.borderColor=UIColor.init(colorLiteralRed: 250/255, green: 140/255, blue: 60/255, alpha: 1).CGColor
        daysL.layer.cornerRadius=3
        
        
        
        //将小白点添加到滚动视图
        scrollView.addSubview(pageC)
        //将滚动式图添加到view上
        headerview.addSubview(scrollView)
        //将日期预订视图添加到头视图上
        headerview.addSubview(timeV)
         //将view设置为tableView的HeaderView
        tableView.tableHeaderView=headerview
        // 酒店详情页面,循环创建三个按钮
        
        for item in 0...2 {
            
            
            let button_w = frame.width/3
            
            let button = UIButton(frame: CGRectMake(0+CGFloat(item)*button_w,scrollview_h+timeV_h-10,button_w-1,40))
            let bgView = UIView(frame: button.frame)
            bgView.backgroundColor=UIColor.whiteColor()
            
            
            let xiangqingL = UILabel(frame: CGRectMake(35+button_w*CGFloat(item),scrollview_h+timeV_h-10,button_w-40,40))
            xiangqingL.font=UIFont.systemFontOfSize(15)
            xiangqingL.textColor=UIColor.grayColor()
            button.tag=item
            switch button.tag {
            case 0:
                let imageV = UIImageView(frame: CGRectMake(15, 10, 11, 20))
                imageV.image=UIImage(named: "phone-3")
                xiangqingL.text="酒店位置"
                button.addTarget(self, action: #selector(hotelPlace), forControlEvents: UIControlEvents.TouchUpInside)
                button.addSubview(imageV)
                
            case 1:
                let imageV = UIImageView(frame: CGRectMake(10, 10, 18, 20))
                imageV.image=UIImage(named: "phone-1")
                xiangqingL.text="联系我们"
                button.addTarget(self, action: #selector(callMe), forControlEvents: UIControlEvents.TouchUpInside)
                button.addSubview(imageV)
                
            case 2:
                let imageV = UIImageView(frame: CGRectMake(10, 10, 18, 18))
                imageV.image=UIImage(named: "phone-4")
                xiangqingL.text="酒店详情"
                button.addTarget(self, action: #selector(hotelDetails), forControlEvents: UIControlEvents.TouchUpInside)
                button.addSubview(imageV)
            default:
                break
            }
            headerview.addSubview(bgView)
            headerview.addSubview(xiangqingL)
            headerview.addSubview(button)
            
        }
        //当前促销
        let cuxiaoIV = UIImageView(frame: CGRectMake(10, scrollview_h+timeV_h+40, self.view.bounds.width-20, 18))
        cuxiaoIV.image=UIImage(named: "ic_cuxiao")
        headerview.addSubview(cuxiaoIV)
        self.view.addSubview(tableView)
        headerview.addSubview(searchbar)
        //定时器
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector (doTime), userInfo: nil, repeats: true)
    }
    func lijiyuding(){
        let room = RoomOrderViewController()
        switch tianshu {
        case 0:
            room.roomTimeNum=1
        default:
            room.roomTimeNum=tianshu
        }
        if starttime=="" {
            let date = NSDate()
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd"
            strNowTime = timeFormatter.stringFromDate(date) as String
            
            let date1 = NSDate(timeIntervalSinceNow: 24*60*60)
            let timeFormatter1 = NSDateFormatter()
            timeFormatter1.dateFormat = "yyyy-MM-dd"
            strNowTime1 = timeFormatter.stringFromDate(date1) as String
            timeleftBT.setTitle(strNowTime, forState: UIControlState.Normal)
            endtimeBT.setTitle(strNowTime1, forState: UIControlState.Normal)
            room.roomStartTime=strNowTime
            room.roomEndTime=strNowTime1
    
        }else{

        room.roomStartTime=starttime
        room.roomEndTime=endtime
        }
        self.navigationController?.pushViewController(room, animated: true)
        
    }
    //酒店预订接口
    func GetDate(){
        let url = apiUrl+"getpromotionlist"
        Alamofire.request(.GET, url, parameters: nil).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if(status.status == "error"){
                        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        hud.mode = MBProgressHUDMode.Text;
                        hud.margin = 10.0
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(true, afterDelay: 1)
                    }
                    if(status.status == "success"){
                        self.resrvationSource = ReservationsModel(status.data!)
                        self.tableView.reloadData()
                    }
  
                    
                    
                })
                            }
        }
    }

    //执行定时器方法
    func doTime(){
        
        
        let pageC = self.view.viewWithTag(102) as! UIPageControl
        pageC.currentPage=num
        self.dopageC(pageC)
        num += 1
        if num==4 {
            num=0
        }
    }
    //点击小白点，图片移动
    func dopageC(sender:UIPageControl){
        var x = CGFloat()
        x=CGFloat(sender.currentPage)*self.view.bounds.width
        var rect = CGRect()
        rect=CGRectMake(x,64 , self.view.bounds.width, self.view.bounds.height-400)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    //小白点移动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        
        let frame = self.view.bounds
        
        let pageC = self.view.viewWithTag(102) as! UIPageControl
        
        pageC.currentPage = Int(scrollView.contentOffset.x/frame.width)
    }
    
    //tableView代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.resrvationSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let hotelcell = HotelmallTableViewCell.cellWithTableView(tableView)
        hotelcell.selectionStyle = .None
        let reservationInfo = resrvationSource.objectlist[indexPath.row]
        
        
        hotelcell.titName.text = reservationInfo.name
        hotelcell.size.text = reservationInfo.adtitle
        hotelcell.priceLab.text = reservationInfo.price
        
        if reservationInfo.type == 1 {
            hotelcell.prie.text = "起/晚"
        }else{
            hotelcell.prie.text = "/位"
        }
        let photo = reservationInfo.picture
        let url = imageUrl+photo!
        
        
        hotelcell.imageV.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "默认.jpg"))
        return hotelcell
        
    }
    //点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let reservationInfo = resrvationSource.objectlist[indexPath.row]
        if  reservationInfo.type == 1{
            let cuxiaoV = SaleViewController(nibName: "SaleViewController", bundle: nil)
            
            switch tianshu {
            case 0:
                cuxiaoV.roomnum=1
                
            default:
                cuxiaoV.roomnum=tianshu

            }
            
          cuxiaoV.roomid=reservationInfo.idLab!
            self.navigationController?.pushViewController(cuxiaoV, animated: true)

        }
        else{
            
            let reservationInfo = resrvationSource.objectlist[indexPath.row]
            
            
            let foodVC = FoodViewController(nibName: "FoodViewController", bundle: nil)
            foodVC.foodid=reservationInfo.idLab!
            foodVC.foodname=reservationInfo.name!
            self.navigationController?.pushViewController(foodVC, animated: true)
            
        }
  
    }

   
   //点击serch时调用
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        
     print("开始搜索")
        print(searchBar.text)
        let room = RoomOrderViewController()
        switch tianshu {
        case 0:
            room.roomTimeNum=1
        default:
            room.roomTimeNum=tianshu
        }
        if starttime=="" {
            let date = NSDate()
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd"
            strNowTime = timeFormatter.stringFromDate(date) as String
            
            let date1 = NSDate(timeIntervalSinceNow: 24*60*60)
            let timeFormatter1 = NSDateFormatter()
            timeFormatter1.dateFormat = "yyyy-MM-dd"
            strNowTime1 = timeFormatter.stringFromDate(date1) as String
            timeleftBT.setTitle(strNowTime, forState: UIControlState.Normal)
            endtimeBT.setTitle(strNowTime1, forState: UIControlState.Normal)
            room.roomStartTime=strNowTime
            room.roomEndTime=strNowTime1
            
        }else{
            
            room.roomStartTime=starttime
            room.roomEndTime=endtime
        }
        room.searchname=searchBar.text!
        self.navigationController?.pushViewController(room, animated: true)
        
        
    
}
    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)       
    }


    //响应酒店详情三个按钮的方法
    func hotelPlace(){
        let placeVC = HotelPlaceViewController()
        self.navigationController?.pushViewController(placeVC, animated: true)
        
        
    }
    func callMe(){
        let callVC = CallMeViewController()
        self.navigationController?.pushViewController(callVC, animated: true)
        
    }
    func hotelDetails(){
        let detailsVC = HotelDetailsViewController()
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    //选择入住时间，调用第三方日历
    func timeStart(){
        
        let vvv = CalendarFirstViewController()
        self.navigationController?.pushViewController(vvv, animated: true)
     
        
    }
    //隐藏导航栏
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=true
        self.tabBarController?.tabBar.hidden=false
        if starttime=="" {
            let date = NSDate()
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd"
            strNowTime = timeFormatter.stringFromDate(date) as String
            
            let date1 = NSDate(timeIntervalSinceNow: 24*60*60)
            let timeFormatter1 = NSDateFormatter()
            timeFormatter1.dateFormat = "yyyy-MM-dd"
            strNowTime1 = timeFormatter.stringFromDate(date1) as String
        timeleftBT.setTitle(strNowTime, forState: UIControlState.Normal)
        endtimeBT.setTitle(strNowTime1, forState: UIControlState.Normal)
            
         daysL.text="1天"
        }
        
    }
    // 顶部刷新
    func headerRefresh(){
        print("下拉刷新")
        GetDate()
        // 结束刷新
        tableView.mj_header.endRefreshing()
    }
    
    // 底部刷新
    var index = 0
    func footerRefresh(){
        print("上拉刷新")
        tableView.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        index = index + 1
        if index > 2 {
            footer.endRefreshingWithNoMoreData()
        }
    }
    

    //显示导航栏
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        
    }

}
