//
//  RoomOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/16.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class RoomOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var chuangxing = String()

    private var roomtableview=UITableView()
    var OrderRoomSource = OrderRoomModel()
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    internal var roomStartTime=String()
    internal var roomEndTime=String()
    internal var roomTimeNum=Int()
    internal var searchname=String()
    var idArray = NSMutableArray()
    var Rname = String()
    
    var image = String()
    
    var count = Int()
    var photoSource = roomphotolistInfo()
    var photoAry = NSMutableArray()

    var SaleSource = SaleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDate()
        roomtableview=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: .Plain)
        roomtableview.delegate=self
        roomtableview.dataSource=self
        roomtableview.rowHeight=85
        roomtableview.registerNib((UINib(nibName: "RoomOrdercell",bundle: nil)) ,forCellReuseIdentifier: "cell1")

        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(RoomOrderViewController.headerRefresh))
        // 现在的版本要用mj_header
        roomtableview.mj_header = header
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(RoomOrderViewController.footerRefresh))
        roomtableview.mj_footer = footer

        self.view.addSubview(roomtableview)
    }
    //酒店预订接口
    func GetDate(){
       
            let url = apiUrl+"getbedroomlist"
//            let userid = NSUserDefaults.standardUserDefaults()
//            let uid = userid.stringForKey("userid")
            let param = [
                "searchname":searchname,
//                "userid":uid,
//                "begindate":roomStartTime,
//                "enddate":roomEndTime
                
            ]

            Alamofire.request(.GET, url, parameters: param as?[String:String]).response { request, response, json, error in
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
                            self.OrderRoomSource = OrderRoomModel(status.data!)
                            self.roomtableview.reloadData()
                        }
                        
                    })
                    
                }
            }
    
        }
            
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return OrderRoomSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = RoomOrdercell()
        cell=roomtableview.dequeueReusableCellWithIdentifier("cell1") as! RoomOrdercell
        let orderroomInfo = OrderRoomSource.objectlist[indexPath.row]
        cell.selectionStyle = .None
        cell.chuangxingL.text=chuangxing
        cell.nameL.text=orderroomInfo.name!
        cell.nameL.textColor=textColor
        cell.foodL.textColor=orangeColor
        if orderroomInfo.repast!=="1" {
            cell.foodL.text="含早餐"
            cell.foodIV.image=UIImage(named: "ic_zaocan-1")
        }else{
            cell.foodL.text="不含早餐"
            cell.foodIV.image=UIImage(named: "ic_zaocan")
        }
        cell.mianjiL.text=orderroomInfo.acreage
        cell.chicunL.text=orderroomInfo.size
        cell.chuangxingL.text=orderroomInfo.bed
        cell.youhuijiaL.text="¥"+orderroomInfo.price!
        cell.youhuijiaL.textColor=orangeColor
        cell.menshijiaL.text="¥"+orderroomInfo.oprice!
        cell.loucengL.text=orderroomInfo.floor
        
        self.image=imageUrl+orderroomInfo.picture!
        cell.iconIV.sd_setImageWithURL(NSURL(string: self.image), placeholderImage: UIImage(named: "默认.jpg"))
        cell.yudingBT.backgroundColor=orangeColor
        cell.yudingBT.layer.cornerRadius=3
        cell.yudingBT.tag=indexPath.row
        cell.yudingBT.addTarget(self, action: #selector(RoomOrderViewController.yuding(_:)), forControlEvents: .TouchUpInside)
        
        
        return cell
    }
   
    func yuding(sender:UIButton){
        print(sender.tag)
        let orderroomInfo = OrderRoomSource.objectlist[sender.tag]
        let orderVC = ReserveViewController()
        orderVC.startTime=roomStartTime
        orderVC.endTime=roomEndTime
        orderVC.roomnum=roomTimeNum
        orderVC.roomid=orderroomInfo.idLab!
        orderVC.name=orderroomInfo.name!
        orderVC.bedsize1=orderroomInfo.bed!
        orderVC.network1=orderroomInfo.network!
        orderVC.repast=orderroomInfo.repast!
        var ppp = Int()
        ppp=Int(orderroomInfo.price!)!*roomTimeNum
        
        orderVC.price = String(ppp)

        orderVC.image=orderroomInfo.picture!

        self.navigationController?.pushViewController(orderVC, animated: true)
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderroomInfo = OrderRoomSource.objectlist[indexPath.row]
        let orderVC = ReserveViewController()
        orderVC.startTime=roomStartTime
        orderVC.endTime=roomEndTime
        orderVC.roomnum=roomTimeNum
        orderVC.roomid=orderroomInfo.idLab!
        orderVC.name=orderroomInfo.name!
        orderVC.bedsize1=orderroomInfo.bed!
        orderVC.network1=orderroomInfo.network!
        orderVC.repast=orderroomInfo.repast!
        var ppp = Int()
        ppp=Int(orderroomInfo.price!)!*roomTimeNum
        
        orderVC.price = String(ppp)
     

        orderVC.image=orderroomInfo.picture!
        
        self.navigationController?.pushViewController(orderVC, animated: true)

    }
    // 顶部刷新
    func headerRefresh(){
        print("下拉刷新")
        GetDate()
        // 结束刷新
        roomtableview.mj_header.endRefreshing()
    }
    
    // 底部刷新
    var index = 0
    func footerRefresh(){
        print("上拉刷新")
        GetDate()
        roomtableview.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        index = index + 1
        if index > 2 {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationItem.title="立即预订"
        self.navigationController?.navigationBar.backItem?.title=""
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   }
