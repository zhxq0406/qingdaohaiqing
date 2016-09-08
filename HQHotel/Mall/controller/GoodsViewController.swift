//
//  GoodsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/19.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class GoodsViewController: UIViewController ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{

    private var scrollView=UIScrollView()
    private var tableview=UITableView()
    private let numOfPages=4
    var num=0
    var count = Int()
    var shopgoodSource = GoodsInfo()
    var muArr = NSMutableArray()
    var loveBT = UIButton()

    
    var countTwo = Int()
    var photoSource = goodphotolistInfo()
    var phoneArr = NSMutableArray()

    var imageView = UIImageView()
    
    var dic:Dictionary<String,String> = [:]

 
    internal var price=String()
    internal var goodname=String()
    internal var goodid=String()
    internal var gooddescription=String()
    internal var goodphoto=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let frame = self.view.bounds
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.view.backgroundColor=bkColor
        let scrollview_h = frame.width*0.60
        
        imageView = UIImageView(frame: CGRectMake(0, 0, frame.width, scrollview_h))
        var imageurl=String()
        imageurl = imageUrl+self.goodphoto
        imageView.sd_setImageWithURL(NSURL(string: imageurl), placeholderImage: UIImage(named: "默认.jpg"))
        

        tableview=UITableView(frame: CGRectMake(0, 64, frame.width, frame.height-64), style: .Grouped)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.tableHeaderView=scrollView
        tableview.tableHeaderView=imageView
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.addSubview(tableview)
        let gouwucheBT = UIButton(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        gouwucheBT.backgroundColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        gouwucheBT.setTitle("加入购物车", forState: UIControlState.Normal)
        gouwucheBT.addTarget(self, action: #selector(gouwuche), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(gouwucheBT)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("立即预订", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(yuding), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(yudingBT)
        
    }
     func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identifier:String = "cell"
        let cell:UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        cell.selectionStyle = .None
        if indexPath.section==0 {
            
            let lable : UILabel!
            lable=UILabel(frame: CGRectMake(5,5,self.view.bounds.width-10,50))
            lable.text=goodname
            lable.numberOfLines=0
            cell.addSubview(lable)
            let priceL = UILabel(frame: CGRectMake(5,60,self.view.bounds.width/2,25))
            priceL.textColor=textColor
            priceL.text="¥"+price
            priceL.textColor=blueColor
            
            cell.addSubview(priceL)
            loveBT = UIButton(frame: CGRectMake(self.view.bounds.width-40,50,40,20))
            let collecttt = NSUserDefaults.standardUserDefaults()
            let collect = collecttt.stringForKey("collectid")
            if collect=="1" {
                loveBT.setImage(UIImage(named: "爱心"), forState: UIControlState.Normal)
                loveBT.userInteractionEnabled=false
            }else{
                loveBT.setImage(UIImage(named: "灰心"), forState: UIControlState.Normal)

            }
            
            loveBT.addTarget(self, action: #selector(love), forControlEvents: .TouchUpInside)
            cell.addSubview(loveBT)
            let loveL = UILabel(frame: CGRectMake(self.view.bounds.width-35,75,40,10))
            loveL.font=UIFont.systemFontOfSize(12)
            loveL.text="喜欢"
            cell.addSubview(loveL)

            tableview.rowHeight=90
        }else if indexPath.section==1 {
            let infoTV = UITextView(frame: CGRectMake(10, 5, self.view.bounds.width-20, self.view.bounds.width/5))
            infoTV.text=gooddescription
            infoTV.editable=false
            cell.addSubview(infoTV)
            tableview.rowHeight=self.view.bounds.width/5+10
            
            
        }else{
            
            let imageV = UIImageView(frame: CGRectMake(5, 5, self.view.bounds.width-10, self.view.bounds.width))
            var imageurl=String()
            imageurl = imageUrl+self.goodphoto
            imageV.sd_setImageWithURL(NSURL(string: imageurl), placeholderImage: UIImage(named: "默认.jpg"))

            tableView.rowHeight=110
            cell.addSubview(imageV)
            tableview.rowHeight=self.view.bounds.width+10
            
        }
        
        
        return cell
    }
    //收藏
    func love(){
      
        let url = apiUrl+"addfavorite"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        if uid==nil {
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                        let vc  = mainStoryboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
                        vc.str="1"
            
                        self.navigationController?.pushViewController(vc, animated: true)
                        
        }else{
       
        let param = [
            "userid":uid,
            "goodsid":goodid,
            "type":"3",
            "title":goodname,
            "description":gooddescription
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Httpresult(JSONDecoder(json!))
                print(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                }
                if(status.status == "success"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = "已为您加入收藏"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                    let collecttt = NSUserDefaults.standardUserDefaults()
                    collecttt.setValue("1", forKey: "collectid")
                    self.loveBT.userInteractionEnabled=false
                    self.loveBT.setImage(UIImage(named: "爱心"), forState: UIControlState.Normal)
                }
                }
            }
        }
    }
//立即预订
    func yuding(){
        let mallVC = mallOrderViewController()
        mallVC.price=Int(price)!
        mallVC.goodsid=goodid
        mallVC.mallname=goodname
        mallVC.malldesc=gooddescription
        mallVC.photo=goodphoto
        self.navigationController?.pushViewController(mallVC, animated: true)
        
    }
//购物车
    func gouwuche(){
        
         dic=["id":goodid,"name":goodname,"price":price,"dec":gooddescription,"photo":goodphoto]
        var shopListidArray:Array<Dictionary<String,String>>? = NSUserDefaults.standardUserDefaults().valueForKey("arr") as? Array
        if shopListidArray==nil {
            shopListidArray = [dic]
        }else{
            shopListidArray?.append(dic)
        }
        
        let idarray = NSUserDefaults.standardUserDefaults()
        idarray.setValue(shopListidArray, forKey: "arr")

        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text;
        hud.labelText = "已为您加入购物车"
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 3)
        
    }

//    滚动视图
//    func scrollViewGet() {
//        self.automaticallyAdjustsScrollViewInsets=false
//        let frame = self.view.bounds
//        //滚动式图
//        let scrollview_h = frame.width*0.50
//        
//        scrollView = UIScrollView(frame: CGRectMake(0, 64, frame.width, scrollview_h))
//        
//        scrollView.pagingEnabled = true
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.scrollsToTop = false
//        scrollView.bounces = false
//        scrollView.contentOffset = CGPointZero
//        
//        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
//        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: scrollview_h)
//        scrollView.delegate = self
//        
//        //滚动式图添加图片
//        for index  in 0..<numOfPages {
//            let imageView = UIImageView()
//            let imageurl=String()
////                        imageurl = imageUrl+self.photoSource.photo!
//            imageView.sd_setImageWithURL(NSURL(string: imageurl), placeholderImage: UIImage(named: "food1.png"))
//            print(imageurl)
//            
//            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: scrollview_h)
//            scrollView.addSubview(imageView)
//        }
//        
//        //滚动视图添加小白点
//        let pageC = UIPageControl()
//        pageC.frame=CGRectMake(frame.size.width-60, 66+scrollview_h-30, 40, 20)
//        
//        pageC.tag=102
//        pageC.numberOfPages=4
//        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
//        
//        //将滚动式图添加到view上
//        self.view.addSubview(scrollView)
//        
//        //将小白点添加到滚动视图
//        scrollView.addSubview(pageC)
//        //定时器
//        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector (doTime), userInfo: nil, repeats: true)
//        
//    }
//    //执行定时器方法
//    func doTime(){
//        
//        
//        let pageC = self.view.viewWithTag(102) as! UIPageControl
//        pageC.currentPage=num
//        self.dopageC(pageC)
//        num += 1
//        if num==4 {
//            num=0
//        }
//    }
//    //点击小白点，图片移动
//    func dopageC(sender:UIPageControl){
//        var x = CGFloat()
//        x=CGFloat(sender.currentPage)*self.view.bounds.width
//        var rect = CGRect()
//        rect=CGRectMake(x,64 , self.view.bounds.width, self.view.bounds.height-400)
//        scrollView.scrollRectToVisible(rect, animated: true)
//    }
//    //小白点移动
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
//        
//        let frame = self.view.bounds
//        
//        let pageC = self.view.viewWithTag(102) as! UIPageControl
//        
//        pageC.currentPage = Int(scrollView.contentOffset.x/frame.width)
//    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationItem.title=goodname

    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
        let item = UIBarButtonItem(title: "商品详情", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
}
