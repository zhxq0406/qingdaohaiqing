//
//  MallOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class MallOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var tableview2=UITableView()
    var MallSource = MallModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetmallorderDate()

        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.navigationItem.title="商城订单"
        tableview2=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-64))
        tableview2.delegate=self
        tableview2.dataSource=self
        tableview2.rowHeight=95
        tableview2.registerNib((UINib(nibName: "Foodordercell",bundle: nil)) ,forCellReuseIdentifier: "cell2")
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.addSubview(tableview2)

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return MallSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = Foodordercell()
        cell=tableview2.dequeueReusableCellWithIdentifier("cell2") as! Foodordercell
        let mallInfo = MallSource.orderlist[indexPath.row]
        cell.nameL?.text=mallInfo.mallname
        
        let image = mallInfo.mallpicture
        let IVurl = imageUrl+image!
        print(IVurl)
        
        
        // 时间戳转时间
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"//获得日期
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(mallInfo.malltime!)!)
        let str:String = dateformate.stringFromDate(date)
        
        
        cell.timeL?.text=str
        cell.numL?.text=mallInfo.mallnumber
        cell.priceL?.text=mallInfo.mallmoney
        cell.icon.sd_setImageWithURL(NSURL(string: IVurl ),placeholderImage: UIImage(named: "kb3.png"))
        return cell

        
    }
    func GetmallorderDate(){
        let url = apiUrl+"getshoppingorderlist"
        
                let userid = NSUserDefaults.standardUserDefaults()
                let uid = userid.stringForKey("userid")
        if uid==nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Login")
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
        let param = [
            "userid":uid!
        ]
        
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
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
                    self.MallSource = MallModel(status.data!)
                    self.tableview2.reloadData()
                }
            }}
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailsVC = OrderDetailsViewController()
        let mallInfo = MallSource.orderlist[indexPath.row]
        
        detailsVC.orderid=mallInfo.mallordernum!
        detailsVC.ordername=mallInfo.mallname!
        detailsVC.orderpeople=mallInfo.mallpeoplename!
        detailsVC.ordernum=mallInfo.mallnumber!
        detailsVC.orderohone=mallInfo.mallmobile!
        detailsVC.orderroomnum=mallInfo.mallroomname!
        if mallInfo.mallremarks==nil {
            detailsVC.ordermark="无"
        }else {
            detailsVC.ordermark=mallInfo.mallremarks!
        }
        detailsVC.type=2
    
    
    self.navigationController?.pushViewController(detailsVC, animated: true)
    
}
    override func viewWillAppear(animated: Bool) {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
