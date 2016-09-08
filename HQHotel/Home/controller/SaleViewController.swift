//
//  SaleViewController.swift
//  
//
//  Created by xiaocool on 16/4/27.
//
//

import UIKit
import Alamofire
import MBProgressHUD
class SaleViewController: UIViewController ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var menshijiaL: UILabel!
    
    @IBOutlet weak var youhuijiaL: UILabel!
    
    @IBOutlet weak var zaocanIV: UIImageView!
    
    @IBOutlet weak var shangwangL: UILabel!
    
    @IBOutlet weak var kezhuL: UILabel!
    
    @IBOutlet weak var loucengL: UILabel!
    
    @IBOutlet weak var chuangxingL: UILabel!
 
    @IBOutlet weak var chuanghuL: UILabel!

    @IBOutlet weak var weiyuL: UILabel!
   
    @IBOutlet weak var mianjiL: UILabel!

    @IBOutlet weak var tableview: UITableView!


    var saleSource = SaleModel()
    var count = Int()
    var photoSource = roomphotolistInfo()
    var photoAry = NSMutableArray()
    internal var roomid = String()
    internal var startTime=String()
    internal var endTime=String()
    internal var roomnum=Int()
    var name=String()
    var bedsize=String()
    var repast=String()
    var network=String()
    var price=String()
    var zongjiaL=UILabel()
    var image = String()
    
    var chuanzhi = NSUserDefaults.standardUserDefaults()
    private var scrollView:UIScrollView!
    private let numOfPages=4
    private var str=String()
    private var str1=String()
    private var aa=Int()
    private var nume=Int()
    var num=0
    var zongjia = Int()
    
    
    override func viewDidLoad() {
        

        
       menshijiaL.textAlignment = .Center
        youhuijiaL.textAlignment = .Center
        shangwangL.textColor=textColor
        kezhuL.textColor=textColor
        loucengL.textColor=textColor
        chuangxingL.textColor=textColor
        chuanghuL.textColor=textColor
        weiyuL.textColor=textColor
        mianjiL.textColor=textColor
        
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.automaticallyAdjustsScrollViewInsets=false
        let frame = UIScreen.mainScreen().bounds
        //滚动式图
        let scrollview_h = frame.width*0.45
        
        scrollView = UIScrollView(frame: CGRectMake(0, 64, frame.width, scrollview_h))
        
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
            let imageView = UIImageView(image: UIImage(named: "青岛海情-00\(index+1).JPG"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: scrollview_h)
            scrollView.addSubview(imageView)
        }
        
        //滚动视图添加小白点
        let pageC = UIPageControl()
        pageC.frame=CGRectMake(frame.size.width-60, 66+scrollview_h-30, 40, 20)
        
        pageC.tag=102
        pageC.numberOfPages=4
        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
        
        //将滚动式图添加到view上
        self.view.addSubview(scrollView)
        
        //将小白点添加到滚动视图
        self.view.addSubview(pageC)
        //定时器
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector (doTime), userInfo: nil, repeats: true)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.scrollEnabled=false
        
        let priceL = UILabel(frame: CGRectMake(0,frame.height-40,frame.width/2,40))
        priceL.backgroundColor=UIColor.whiteColor()
        priceL.text="  总价："
        self.view.addSubview(priceL)
        zongjiaL = UILabel(frame: CGRectMake(70,frame.height-40,frame.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.textColor=UIColor.init(red: 39/255, green: 178/255, blue: 252/255, alpha: 1)
        
        self.view.addSubview(zongjiaL)
        let yudingBT = UIButton(frame: CGRectMake(frame.width/2,frame.height-40,frame.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("立即预订", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(yuding), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yudingBT)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SaleViewController.chuanzhi(_:)), name: "backchuanzhi", object: nil)
    }
    //酒店房间接口
    func GetDate(){
        let url = apiUrl+"showbedroominfo"

        let param = [
            "id":roomid
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = SaleModel(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    print("Success")

                    
                    self.chuangxingL.text = status.data?.roombedsize
                    self.youhuijiaL.text = status.data?.roomprice
                    self.menshijiaL.text = status.data?.roomoprice
                    self.shangwangL.text = status.data?.roomnetwork
                    self.kezhuL.text = status.data?.roompeoplenumber
                    self.loucengL.text = status.data?.roomfloor
                    self.chuanghuL.text = status.data?.roomwindow
                    self.weiyuL.text = status.data?.roombathroom
                    self.mianjiL.text = status.data?.roomacreage
                    self.price=(status.data?.roomprice)!
                    self.zongjia=Int(self.price)!*self.roomnum
                    self.repast=(status.data?.roomrepast!)!
                    self.zongjiaL.text="¥"+String(self.zongjia)
                    self.name=(status.data?.roomname)!
                    self.image=(status.data?.roompicture!)!

                    self.title=status.data?.roomname!
                    self.bedsize=(status.data?.roombedsize)!
                    self.network=(status.data?.roomnetwork)!
                    self.count = (status.data?.count)!
                    for item in 0..<self.count{
                        self.photoSource = (status.data?.roomphotolist[item])!
                        self.photoAry.addObject(self.photoSource)
                        print(self.photoSource.photo)
                    }
                    if self.repast=="1" {
                        self.zaocanIV.image=UIImage(named: "ic_zaocan-1")
                    }else{
                        self.zaocanIV.image=UIImage(named: "ic_zaocan")
                    }
 
                }
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
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.imageView?.image=UIImage(named: "ic_rili")
        cell.textLabel?.text=startTime+"入住，"+endTime+"退房，共"+String(self.roomnum)+"晚"
        cell.selectionStyle = .None
        
        cell.textLabel?.font=UIFont.systemFontOfSize(14)
        return cell
        
        
    }
    //预订按钮
    func yuding(){
        
        let reserve = ReserveViewController()
        reserve.name=name
        reserve.bedsize1=bedsize
        reserve.network1=network
        reserve.repast=repast
        reserve.startTime=startTime
        reserve.endTime=endTime
        reserve.price = String(zongjia)
        reserve.roomnum = self.roomnum
        reserve.roomid=self.roomid
        reserve.image=self.image
        self.navigationController?.pushViewController(reserve, animated: true)
        
        
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let riliVC = CalendarFirstViewController()
        riliVC.str="1"
        nume=2
        self.navigationController?.pushViewController(riliVC, animated: true)
        
    }
    func chuanzhi(title:NSNotification){
       
        str = title.object as! String
        aa=2
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.tabBarController?.tabBar.hidden=true

        chuanzhi = NSUserDefaults.standardUserDefaults()
       
        
        if startTime=="" {
            let date = NSDate()
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd"
            startTime = timeFormatter.stringFromDate(date) as String
            
            let date1 = NSDate(timeIntervalSinceNow: 24*60*60)
            let timeFormatter1 = NSDateFormatter()
            timeFormatter1.dateFormat = "yyyy-MM-dd"
            endTime = timeFormatter.stringFromDate(date1) as String
        }else if nume==2{
        startTime = chuanzhi.stringForKey("startTime")!
        endTime = chuanzhi.stringForKey("endTime")!
        roomnum = chuanzhi.integerForKey("num")
            
        }
        
        tableview.reloadData()
        self.GetDate()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

     
}
    override func viewWillDisappear(animated: Bool) {
//        let item = UIBarButtonItem(title: "房间详情", style: .Plain, target: self, action: nil)
//        self.navigationItem.backBarButtonItem = item
    }
  
}
