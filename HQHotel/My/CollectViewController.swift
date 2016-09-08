//
//  CollectViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/19.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class CollectViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var collTableview=UITableView()
    private var CollectSource=CollectModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetcollectDate()
        
        
        collTableview=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        collTableview.delegate=self
        collTableview.dataSource=self
        collTableview.rowHeight=100
        self.view.addSubview(collTableview)
        
        
    }
    func GetcollectDate(){
        let url = apiUrl+"getfavoritelist"
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
                    self.CollectSource = CollectModel(status.data!)
                    self.collTableview.reloadData()
                }
            }
        }
    }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return CollectSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let collcell = CollectionCell.cellWithTableView(tableView)

        let collectInfo = CollectSource.objectlist[indexPath.row]
        
        collcell.nameL.text=collectInfo.collecttitle
        collcell.jianjieL.text=collectInfo.collectdescription
        let photo = collectInfo.collectphoto
        let url = imageUrl+photo!
        collcell.iconView.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "默认.jpg"))
        
        collcell.priceL.text=collectInfo.collectprice
        collcell.yudingBT.tag=indexPath.row
        collcell.yudingBT.addTarget(self, action: #selector(CollectViewController.Order(_:)), forControlEvents: .TouchUpInside)
        
        
       return collcell
    }
    func Order(sender:UIButton){
        let mall = mallOrderViewController()
        let collectInfo = CollectSource.objectlist[sender.tag]
        mall.price=Int(collectInfo.collectprice!)!
        mall.mallname=collectInfo.collecttitle!
        mall.malldesc=collectInfo.collectdescription!
        mall.goodsid=collectInfo.collectid!
        mall.photo=collectInfo.collectphoto!
        self.navigationController?.pushViewController(mall, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title=""
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.tabBarController?.tabBar.hidden=true
        GetcollectDate()
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
        let item = UIBarButtonItem(title: "收藏", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
