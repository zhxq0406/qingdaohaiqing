//
//  MyViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private let topView=UIView()
    private let iconImage=UIImageView()
    private let setupBT=UIButton()
    private let tableView=UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        
        let topView_h = (self.view.bounds.height)/2-80
        //顶部视图
        topView.frame=CGRectMake(0, 0, self.view.bounds.width, topView_h)
        topView.backgroundColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        //头像视图
        iconImage.frame=CGRectMake(0, 0, self.view.bounds.width/4, self.view.bounds.width/4)
        iconImage.center=topView.center
        iconImage.image=UIImage(named: "ic_touxiang")
        let messageBT = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width/4, self.view.bounds.width/4))
        messageBT.center=topView.center
        
        messageBT.addTarget(self, action: #selector(showmessage), forControlEvents: .TouchUpInside)
        let nameL = UILabel(frame: CGRectMake(0,topView_h-(topView_h/2-self.view.bounds.width/8),self.view.bounds.width,20))
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        if uid==nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc  = mainStoryboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
            
            
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        
        
        let username = NSUserDefaults.standardUserDefaults()
        let Uname = username.stringForKey("username")
        nameL.text=Uname
        nameL.textAlignment = .Center
        nameL.textColor=UIColor.whiteColor()
        topView.addSubview(nameL)
                //设置按钮
        setupBT.frame=CGRectMake(topView.bounds.width-40, 30, 30, 30)
        setupBT.setImage(UIImage(named: "ic_shezhi"), forState: UIControlState.Normal)
        setupBT.addTarget(self, action: #selector(setUp), forControlEvents: .TouchUpInside)
        // 循环创建三个按钮
        for item in 0...2 {
            let button_w = self.view.bounds.width/3

            let view = UIView(frame: CGRectMake(0+CGFloat(item)*button_w,topView_h,button_w-1,40))
            view.backgroundColor=UIColor.whiteColor()
            
            let button = UIButton(frame: CGRectMake(0+CGFloat(item)*button_w,topView_h,button_w,40))
            
            //按钮图标
            let imageV = UIImageView(frame: CGRectMake(20+button_w*CGFloat(item), topView_h+10, 20, 18))
            
            let xiangqingL = UILabel(frame: CGRectMake(45+button_w*CGFloat(item),topView_h,button_w-20,40))
            xiangqingL.font=UIFont.systemFontOfSize(15)
            xiangqingL.textColor=UIColor.grayColor()
            button.tag=item
            
            switch button.tag {
            case 0:
                imageV.image=UIImage(named: "ic_shoucang")
                xiangqingL.text="收藏"
                button.addTarget(self, action: #selector(dobutton), forControlEvents: UIControlEvents.TouchUpInside)
                
            case 1:
                imageV.image=UIImage(named: "ic_gouwuche")
                xiangqingL.text="购物车"
                button.addTarget(self, action: #selector(dobuttonOne), forControlEvents: UIControlEvents.TouchUpInside)
 
            case 2:
                imageV.image=UIImage(named: "ic_xiaoxi")
                xiangqingL.text="消息中心"
                button.addTarget(self, action: #selector(dobuttonTwo), forControlEvents: UIControlEvents.TouchUpInside)
            default:
                break
            }
            self.view.addSubview(view)
            self.view.addSubview(xiangqingL)
            self.view.addSubview(imageV)
            self.view.addSubview(button)
            self.view.addSubview(messageBT)
            
        }
                
        tableView.frame=CGRectMake(0, topView_h+40+20, self.view.bounds.width, 130)
        tableView.scrollEnabled=false
        tableView.delegate=self
        tableView.dataSource=self
        topView.addSubview(setupBT)
        self.view.addSubview(topView)
        self.view.addSubview(iconImage)
        self.view.addSubview(tableView)
        self.view.addSubview(messageBT)
        
    }
    func showmessage(){
    
        let vc = ShowMessageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //执行按钮事件
    func dobutton(){
        let collectVC = CollectViewController()
        self.navigationController?.pushViewController(collectVC, animated: true)
        
    }
    func dobuttonOne(){
        let shoplistVC = ShopListViewController()
        self.navigationController?.pushViewController(shoplistVC, animated: true)
    }
    func dobuttonTwo(){
        
        let informationVC = MessageViewController()
        self.navigationController?.pushViewController(informationVC, animated: true)
    }
    //tableview的代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .None
        switch indexPath.row {
        case 0:
            cell.imageView?.image=UIImage(named: "ic_yuding-1")
            cell.textLabel?.text="酒店预订"
        case 1:
            cell.imageView?.image=UIImage(named: "ic_dingdan-1")
            cell.textLabel?.text="商城订单"
        default:
            cell.imageView?.image=UIImage(named: "ic_huiyuan-1")
            cell.textLabel?.text="会员积分"
        }
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let hotelVC = HotelOrderViewController()
            self.navigationController?.pushViewController(hotelVC, animated: true)
            hotelVC.view.backgroundColor = UIColor.whiteColor()
        case 1:
            let mallVC = MallOrderViewController()
            self.navigationController?.pushViewController(mallVC, animated: true)
        default:
            break
        }
    }
    //设置按钮
    func setUp(){
        
        let setVC = SetUpViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden=true
        let item = UIBarButtonItem(title: "我的", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
      

        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden=false
    }
    }
