//
//  ShopListViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/19.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ShopListViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var shopListTableview=UITableView()
        private var CollectSource=CollectModel()
    var shoparray = NSMutableArray()
    var count = Int()
    
  
    
    var name = String()
    var price = String()
    var picture = String()
    var jianjie = String()
    var nameAry=NSMutableArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        let fream = UIScreen.mainScreen().bounds.size
        
        shopListTableview.frame=CGRectMake(0, 64, fream.width, fream.height-64)
        shopListTableview.delegate=self
        shopListTableview.dataSource=self
        shopListTableview.rowHeight=100
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.addSubview(shopListTableview)
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        if uid==nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(vc, animated: true, completion: nil)
            
        }else{
            
        
        let idarray = NSUserDefaults.standardUserDefaults()
        let arr = idarray.valueForKey("arr")
        if arr != nil {
            shoparray = arr as! NSMutableArray
        }
        count = (shoparray.count)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let collcell = CollectionCell.cellWithTableView(tableView)
        
        var dict:Dictionary<String,String> = shoparray.objectAtIndex(indexPath.row) as! Dictionary
        
        let id1 = dict["id"]
        let name1 = dict["name"]
        let price1 = dict["price"]
        let dec1 = dict["dec"]
        let photo1 = dict["photo"]
        collcell.selectionStyle = .None
    
        collcell.nameL.text=name1
        collcell.jianjieL.text=dec1
        if photo1==nil {
            collcell.iconView.image=UIImage(named: "默认.jpg")
        }else{
        let url = imageUrl+(photo1)!
        collcell.iconView.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "默认.jpg"))
        }
        collcell.priceL.text=price1
        
        collcell.yudingBT.addTarget(self, action: #selector(ShopListViewController.Order(_:)), forControlEvents: .TouchUpInside)
        collcell.yudingBT.tag=indexPath.row
        
        return collcell

    }
    func Order(sender:UIButton){
        let mall = mallOrderViewController()
        var dict:Dictionary<String,String> = shoparray.objectAtIndex(sender.tag) as! Dictionary
        
        let id1 = dict["id"]
        let name1 = dict["name"]
        let price1 = dict["price"]
        let dec1 = dict["dec"]
        let photo1 = dict["photo"]
        mall.goodsid=id1!
        mall.price=Int(price1!)!
        mall.mallname=name1!
        mall.malldesc=dec1!
        mall.photo=photo1!
        self.navigationController?.pushViewController(mall, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        let item = UIBarButtonItem(title: "购物车", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
