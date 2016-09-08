//
//  HotelOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class HotelOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    private var tableview1:UITableView!
    private var tableview2:UITableView!
    private var segment:UISegmentedControl!
    

    var hotelSource = HotelOrderModel()
    var FoodSource = FoodOrderModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""
        
         let appsArray:[String] = ["酒店订单","餐饮订单"]
         segment = UISegmentedControl(items: appsArray)
         segment.frame = CGRectMake(0, 0, self.view.bounds.width/2, 30)
        segment.selectedSegmentIndex=0
         segmentChange(segment)
         self.view.addSubview(segment)
        segment.addTarget(self, action:#selector(segmentChange), forControlEvents: UIControlEvents.ValueChanged)
        self.automaticallyAdjustsScrollViewInsets=false

        
        self.navigationItem.titleView=segment
        
        
    }
   
    
        func GetroomorderDate(){
        let url = apiUrl+"getbookingorderlist"
        
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let param = [
            "userid":uid
        ]
            if uid==nil {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(vc, animated: true, completion: nil)
                
            }else{
      print(uid)
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.hotelSource = HotelOrderModel(status.data!)
                    self.tableview1.reloadData()
                }
            }
                }  }
    }
    func GetfoodorderDate(){
        let url = apiUrl+"getcateringorderlist"
        
                let userid = NSUserDefaults.standardUserDefaults()
                let uid = userid.stringForKey("userid")
        if uid==nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(vc, animated: true, completion: nil)
            
        }else{
            
        
        let param = [
            "userid":uid
        ]
        
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.FoodSource = FoodOrderModel(status.data!)
                    self.tableview2.reloadData()
                }
            }
        }
    }
    }
    func segmentChange(sender:AnyObject?){
        let segment:UISegmentedControl = sender as! UISegmentedControl
       
        switch segment.selectedSegmentIndex {
        case 0 :
            tableView1()
        case 1 :
            
            tableView2()
            
        default:
            break
        }
    }
    func tableView1(){
        GetroomorderDate()
        tableview1=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-64))
        tableview1.delegate=self
        tableview1.dataSource=self
        tableview1.rowHeight=95
        tableview1.registerNib((UINib(nibName: "HotelOrderCell",bundle: nil)) ,forCellReuseIdentifier: "cell1")
        
        self.view.addSubview(tableview1)
        

    }
    func tableView2(){
        GetfoodorderDate()
        tableview2=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-64))
        tableview2.delegate=self
        tableview2.dataSource=self
        tableview2.rowHeight=95
        tableview2.registerNib((UINib(nibName: "Foodordercell",bundle: nil)) ,forCellReuseIdentifier: "cell2")
        
        self.view.addSubview(tableview2)
        

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView==tableview1 {
            return hotelSource.count
        }else{
            return FoodSource.count
        }
    }
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if tableView==tableview1 {
            
            
            var cell = HotelOrderCell()
            cell=tableview1.dequeueReusableCellWithIdentifier("cell1") as! HotelOrderCell
            let hotelInfo = hotelSource.orderlist[indexPath.row]
            cell.fangxingL?.text=hotelInfo.ordername
            
            
            // 时间戳转时间
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"//获得日期
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(hotelInfo.ordertime!)!)
            let str:String = dateformate.stringFromDate(date)
            cell.selectionStyle = .None
            
            cell.timeL?.text=str
            cell.shuliangL?.text=hotelInfo.ordernumber
            cell.zongjiaL?.text=hotelInfo.orderprice
            let image = hotelInfo.orderpicture
            let IVurl = imageUrl+image!
            print(IVurl)
            cell.imageview!.sd_setImageWithURL(NSURL(string: IVurl ),placeholderImage: UIImage(named: "默认.png"))
            return cell
        }else {
            
            
            var cell = Foodordercell()
            cell=tableview2.dequeueReusableCellWithIdentifier("cell2") as! Foodordercell
            let foodInfo = FoodSource.orderlist[indexPath.row]
            cell.nameL?.text=foodInfo.foodordername
            cell.selectionStyle = .None
            
            // 时间戳转时间
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"//获得日期
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(foodInfo.foodordertime!)!)
            let str:String = dateformate.stringFromDate(date)
            
            
            cell.timeL?.text=str
            cell.numL?.text=foodInfo.foodordernumber
            cell.priceL?.text=foodInfo.foodorderprice
            let image = foodInfo.foodorderpicture
            let IVurl = imageUrl+image!
            print(IVurl)
            cell.icon.sd_setImageWithURL(NSURL(string: IVurl ),placeholderImage: UIImage(named: "默认.png"))
            return cell
            
            
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailsVC = OrderDetailsViewController()
        if tableView==tableview1 {
            detailsVC.type=1
            let hotelInfo = hotelSource.orderlist[indexPath.row]
            
            detailsVC.orderid=hotelInfo.order_num!
            detailsVC.ordername=hotelInfo.ordername!
            detailsVC.orderpeople=hotelInfo.orderpeoplename!
            detailsVC.ordernum=hotelInfo.ordernumber!
            detailsVC.orderohone=hotelInfo.ordermobile!
            if hotelInfo.orderremarks==nil {
                detailsVC.ordermark="无"
            }else{
            detailsVC.ordermark=hotelInfo.orderremarks!

            }
        }else
        {
            
            
        let foodInfo = FoodSource.orderlist[indexPath.row]
            
            detailsVC.orderid=foodInfo.foodordernum!
            detailsVC.ordername=foodInfo.foodordername!
            detailsVC.orderpeople=foodInfo.foodpeoplename!
            detailsVC.ordernum=foodInfo.foodordernumber!
            detailsVC.orderohone=foodInfo.foodordermobile!
            detailsVC.orderroomnum=foodInfo.foodroomname!
            if foodInfo.foodorderremarks==nil {
                detailsVC.ordermark="无"
            }else {
            detailsVC.ordermark=foodInfo.foodorderremarks!
            }
            detailsVC.type=2
        }
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
      
        
        
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)

        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
        let item = UIBarButtonItem(title: "我的订单", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
