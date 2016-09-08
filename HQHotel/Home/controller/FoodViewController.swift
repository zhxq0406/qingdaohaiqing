//
//  FoodViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/5.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class FoodViewController: UITabBarController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    private var scrollView:UIScrollView!
    private let numOfPages=4
    var num=0
    
    let jianjieView = UIView()
    var taocanTable = UITableView()
    let bottm = UILabel()
    let yuanjia = UILabel()
    let priceOld = UILabel()
    let xiuhuijia = UILabel()
    let priceNew = UILabel()
    let shimenjia = UILabel()
    let youhuijia = UILabel()
    let priceMen = UILabel()
    let priceHui = UILabel()
    let line = UILabel()
    internal var foodid = String()
    var foodname = String()
    
    let business = UILabel()
    let busContact = UILabel()
    let reservation = UIButton()
    
    
    var caterSoutce = CaterModel()
    
    
    var count = Int()
    var goodSource = GoodListInfo()
    var muArr = NSMutableArray()
    var data = NSData()
    
    var countTwo = Int()
    var photoSource = photolistInfo()
    var phoneArr = NSMutableArray()
//    var imageView = UIImageView()
    var photo=String()
    let orderfVC = OrderFoodViewController()
    private var headerView=UIView()
    
    override func viewDidLoad() {
        
        self.scrollViewGet()
        
        
        headerView=UIView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.width*0.5+60+10+150+64+10))
        headerView.backgroundColor=bkColor
        shimenjia.frame = CGRectMake(0, self.view.bounds.width*0.5+94, WIDTH/3, 20)
        shimenjia.textColor = UIColor.grayColor()
        shimenjia.textAlignment = .Center
        shimenjia.font = UIFont.systemFontOfSize(12)
        shimenjia.text = "门市价"
        youhuijia.frame = CGRectMake(WIDTH/3, self.view.bounds.width*0.5+94, WIDTH/3, 20)
        youhuijia.textColor = UIColor.grayColor()
        youhuijia.textAlignment = .Center
        youhuijia.font = UIFont.systemFontOfSize(12)
        youhuijia.text = "优惠价"
        
        line.frame = CGRectMake(WIDTH/3, self.view.bounds.width*0.5+64, 1, 60)
        line.backgroundColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        priceMen.frame = CGRectMake(0, self.view.bounds.width*0.5+74, WIDTH/3, 20)
        priceMen.textAlignment = .Center
        priceMen.font = UIFont.systemFontOfSize(14)
        
        priceHui.frame = CGRectMake(WIDTH/3, self.view.bounds.width*0.5+74, WIDTH/3, 20)
        priceHui.textAlignment = .Center
        priceHui.font = UIFont.systemFontOfSize(15)
        priceHui.textColor = UIColor.orangeColor()
        
        
        for i in 0...1 {
            let titLab = UILabel()
            
            titLab.frame = CGRectMake(0+CGFloat(i)*self.view.bounds.width/3, self.view.bounds.width*0.5+64, self.view.bounds.width/3, 60)
            titLab.tag = i
            titLab.backgroundColor = UIColor.whiteColor()
            headerView.addSubview(titLab)
            
        }
        
        reservation.frame = CGRectMake(WIDTH/3*2, self.view.bounds.width*0.5+63, self.view.bounds.width/3, 60)
        reservation.backgroundColor = UIColor.orangeColor()
        reservation.setTitle("立即预订", forState:.Normal)
        reservation.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        reservation.titleLabel?.font = UIFont.systemFontOfSize(16)
        reservation.addTarget(self, action: #selector(FoodViewController.getYuDing), forControlEvents: .TouchUpInside)
        
        headerView.addSubview(shimenjia)
        headerView.addSubview(youhuijia)
        headerView.addSubview(line)
        headerView.addSubview(priceMen)
        headerView.addSubview(priceHui)
        headerView.addSubview(reservation)
        
        jianjieView.frame = CGRectMake(0, self.view.bounds.width*0.5+134, self.view.bounds.width, 150)
        jianjieView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(jianjieView)
        
        business.frame = CGRectMake(10, 5, 100, 20)
        business.text = "商品描述"
        business.font = UIFont.systemFontOfSize(13)
        jianjieView.addSubview(business)
        
        busContact.frame = CGRectMake(10, 25, WIDTH-20, 125)
        busContact.font = UIFont.systemFontOfSize(12)
        busContact.numberOfLines = 0
        
        jianjieView.addSubview(busContact)
        
        
        taocanTable.frame = CGRectMake(0, 0, WIDTH, self.view.bounds.height-30)
        taocanTable.delegate = self
        taocanTable.dataSource = self
        taocanTable.registerClass(BreakTableViewCell.self, forCellReuseIdentifier: "cell")
        
        taocanTable.scrollEnabled=true
        self.view.addSubview(taocanTable)
        
        
        
        bottm.frame = CGRectMake(0, self.view.bounds.height-50, WIDTH, 50)
        bottm.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bottm)
        
        yuanjia.frame = CGRectMake(WIDTH-200, self.view.bounds.height-40, 50, 30)
        yuanjia.textAlignment = .Right
        yuanjia.text = "价值："
        priceOld.frame = CGRectMake(WIDTH-150, self.view.bounds.height-40, 45, 30)
        xiuhuijia.frame = CGRectMake(WIDTH-110, self.view.bounds.height-40, 60, 30)
        xiuhuijia.textAlignment = .Right
        xiuhuijia.text = "优惠价："
        priceNew.frame = CGRectMake(WIDTH-50, self.view.bounds.height-40, 50, 30)
        priceNew.textColor = UIColor.orangeColor()
        
        yuanjia.font = UIFont.systemFontOfSize(14)
        priceOld.font = UIFont.systemFontOfSize(14)
        xiuhuijia.font = UIFont.systemFontOfSize(14)
        priceNew.font = UIFont.systemFontOfSize(15)
        
        self.view.addSubview(yuanjia)
        self.view.addSubview(priceOld)
        self.view.addSubview(xiuhuijia)
        self.view.addSubview(priceNew)
        //将滚动式图添加到view上
        headerView.addSubview(scrollView)
        self.view.addSubview(headerView)
        taocanTable.tableHeaderView=headerView
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count+1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)as!BreakTableViewCell
        cell.selectionStyle = .None
        
        if indexPath.row == 0 {
            cell.content.textColor = UIColor.grayColor()
            cell.danjia.textColor = UIColor.grayColor()
            cell.guige.textColor = UIColor.grayColor()
            cell.content.text = "套餐内容"
            cell.guige.text = "规格"
            cell.danjia.text = "单价"
        }else{
            let data = muArr[indexPath.row-1]as!GoodListInfo
            
            cell.content.text=data.name
            cell.guige.text=data.unit
            cell.danjia.text=data.price
        }
        
        return cell
    }
    
    //    滚动视图
    //餐饮界面
    func GetDate(){
        
        let url = apiUrl+"showcateringinfo"

        let param = [
            "id":foodid
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
                
            }
            else{
                
                let status = CaterModel(JSONDecoder(json!))
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
                    
                    self.priceMen.text = status.data?.foodOprice
                    self.priceHui.text = status.data?.foodPrice
                    self.busContact.text = status.data?.foodDescription
                    self.priceOld.text = "¥"+(status.data?.foodOprice)!
                    self.priceNew.text = "¥"+(status.data?.foodPrice)!
                    self.orderfVC.name=(status.data?.foodName)!
                    self.orderfVC.price=(status.data?.foodPrice)!
                    self.count = (status.data?.count)!
                    for i in 0..<self.count {
                        self.goodSource = (status.data?.goodlist[i])!
                        
                        self.muArr.addObject(self.goodSource)
                    }
                    
                    self.countTwo = (status.data?.countTwo)!
                    for i in 0..<self.countTwo {
                        self.photoSource = (status.data?.photolist[i])!
                        
                        self.phoneArr.addObject(self.photoSource)
                        print(self.photoSource.photo)

                        
                    }
                    self.taocanTable.reloadData()
                    
                }
                
//                self.photo=imageUrl+(self.photoSource.photo)!
//                
//                print(self.photo)

            }
        }
    }
    func scrollViewGet() {
        self.automaticallyAdjustsScrollViewInsets=false
        let frame = self.view.bounds
        //滚动式图
        let scrollview_h = frame.width*0.50
        
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
            
            let imageView = UIImageView(image: UIImage(named: "food1.png"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: scrollview_h)
//            imageView.sd_setImageWithURL(NSURL(string: self.photo), placeholderImage: UIImage(named: "food1.png"))

            
            scrollView.addSubview(imageView)
            
        }
        
        //滚动视图添加小白点
        let pageC = UIPageControl()
        pageC.frame=CGRectMake(frame.size.width-60, scrollview_h-30, 40, 20)
        
        pageC.tag=102
        pageC.numberOfPages=4
        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
        
      
        
        //将小白点添加到滚动视图
        scrollView.addSubview(pageC)
        //定时器
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector (doTime), userInfo: nil, repeats: true)
        
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
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        
        self.GetDate()
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""
        self.navigationItem.title=foodname
    }
    
    
    func getYuDing() {
        orderfVC.roomid=foodid
        self.navigationController?.pushViewController(orderfVC, animated: true)
    }
    
    //    override func viewWillDisappear(animated: Bool) {
    //        self.tabBarController?.tabBar.hidden=false
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
