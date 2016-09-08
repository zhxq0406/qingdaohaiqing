//
//  ReserveViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/28.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ReserveViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate{

    internal var name=String()
    internal var bedsize1=String()
    internal var repast=String()
    internal var network1=String()
    internal var startTime=String()
    internal var endTime=String()
    internal var price=String()
    internal var roomnum=Int()
    internal var roomid=String()
    internal var image=String()
    private var tableView0=UITableView()
    private var tableView1=UITableView()
    private var tableView2=UITableView()
    private var numArray=NSArray()
    private var timeArray=NSArray()
    private var button=UIButton()
    private var zongjiaL=UILabel()
    private var peoplenameTF=UITextField()
    private var peoplenumTF=UITextField()
    private var phoneTF=UITextField()
    private var remarkTV=UITextView()
    private var roomnumL=UILabel()
    private var arrivetimeL=UILabel()
    private var Zprice=Int()
    var startzheng=Int()
    var endzheng=Int()
    var roomImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
        let roomImageView_h = self.view.bounds.width*0.40
        
        roomImageView=UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, roomImageView_h))
        

        let url = imageUrl+image

        roomImageView.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "默认.jpg"))
        let view = UIView(frame: CGRectMake(0,64,self.view.bounds.width,60+roomImageView_h))
        view.backgroundColor=bkColor
        let nameL = UILabel(frame: CGRectMake(10,10+roomImageView_h,self.view.bounds.width-20,20))
        nameL.text=name
        nameL.textColor=textColor
        view.addSubview(nameL)
        let bedL = UILabel(frame: CGRectMake(10,30+roomImageView_h,self.view.bounds.width/6-10,20))
        bedL.textColor=UIColor.grayColor()
        bedL.font=UIFont.systemFontOfSize(14)
        bedL.text=bedsize1
        
        bedL.textAlignment = .Left
        view.addSubview(bedL)
        let wifiL = UILabel(frame: CGRectMake(self.view.bounds.width/6,30+roomImageView_h,self.view.bounds.width/5+10,20))
        wifiL.text=network1
        wifiL.font=UIFont.systemFontOfSize(14)
        wifiL.textAlignment = .Center
        
        wifiL.textColor=UIColor.grayColor()
        view.addSubview(wifiL)
        let foodL = UILabel(frame: CGRectMake(10+self.view.bounds.width/6*2,30+roomImageView_h,self.view.bounds.width/4-20,20))
        foodL.textColor=UIColor.grayColor()
        foodL.font=UIFont.systemFontOfSize(14)
        
        foodL.textAlignment = .Center
        view.addSubview(foodL)
        view.addSubview(roomImageView)
        let foodIV = UIImageView(frame: CGRectMake(15+(self.view.bounds.width/6*3),32+roomImageView_h,15,15))
        view.addSubview(foodIV)
        if repast=="1" {
            foodL.text="含早餐"
            foodIV.image=UIImage(named: "ic_zaocan-1")
        }else{
            foodL.text="不含早餐"
            foodIV.image=UIImage(named: "ic_zaocan")
        }

        tableView0=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-64), style: .Grouped)
        tableView0.delegate=self
        tableView0.dataSource=self
        tableView0.scrollEnabled=true
        tableView0.backgroundColor=bkColor

        tableView0.tableHeaderView=view

        self.view.addSubview(tableView0)
        
        numArray=["1间","2间","3间","4间","5间","6间"]
        timeArray=["18:00之前","20:00之前","23:59之前","次日凌晨六点之前"]
        self.automaticallyAdjustsScrollViewInsets=false
        let priceL = UILabel(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        priceL.backgroundColor=UIColor.whiteColor()
        priceL.text="  总价："
        self.view.addSubview(priceL)
        zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.text="¥"+price
        zongjiaL.textColor=blueColor
        self.view.addSubview(zongjiaL)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("提交订单", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(nowYuding), forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(yudingBT)

        //添加手势，点击空白处收回键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewtap))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
       // 时间转时间戳
         let dateformate = NSDateFormatter()
         dateformate.dateFormat = "yyyy-MM-dd"
         let date = dateformate.dateFromString(startTime)
         let time:NSTimeInterval = (date?.timeIntervalSince1970)!
         startzheng = Int(time)
         print(startzheng)
        let dateformate1 = NSDateFormatter()
        dateformate1.dateFormat = "yyyy-MM-dd"
        let date1 = dateformate1.dateFromString(endTime)
        let time1:NSTimeInterval = (date1?.timeIntervalSince1970)!
        endzheng = Int(time1)
        print(endzheng)
   
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        if tableView==tableView0 {
            return 2
        }else{
            return 1
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView==tableView1 {
            return numArray.count
        }
        else if tableView==tableView2{
            return timeArray.count
        }
        else{
            
            if section==0{
                return 3
            }else{
                return 4
            }
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if tableView==tableView1 {
            let cell = UITableViewCell()
            cell.textLabel?.text=numArray.objectAtIndex(indexPath.row) as? String
            cell.selectionStyle = .None
            return cell
            
        }
        else if tableView==tableView2{
            let cell = UITableViewCell()
            cell.textLabel?.text=timeArray.objectAtIndex(indexPath.row) as? String
            cell.selectionStyle = .None
            return cell
            
        }
        else{
            if indexPath.section==0 {
                
                let identi = "cell0"
                
        let cell = UITableViewCell(style: .Default, reuseIdentifier: identi)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.font=UIFont.systemFontOfSize(14)
                cell.textLabel?.textColor=UIColor.grayColor()
                cell.selectionStyle = .None
               switch indexPath.row {
              
        case 0:
            
            cell.textLabel?.text=startTime+"入住"+endTime+"离店,共"+String(self.roomnum)+"晚"
            cell.textLabel?.textColor=textColor
                tableView0.rowHeight=44
                
                
        case 1:
            cell.textLabel?.text="房间数"
            cell.textLabel?.textColor=textColor
            tableView0.rowHeight=44
            roomnumL.frame =  CGRectMake(self.view.bounds.width/2,10,self.view.bounds.width/2-30,24)
            roomnumL.text="1间"
                cell.addSubview(roomnumL)
        default:
            
            cell.textLabel?.text="预计到达"
            cell.textLabel?.textColor=textColor
                tableView0.rowHeight=44
                arrivetimeL = UILabel(frame: CGRectMake(self.view.bounds.width/2,10,self.view.bounds.width/2-30,24))
            arrivetimeL.text="18:00之前"
                cell.addSubview(arrivetimeL)
            }
                return cell
            }else
            {
                let identifier = "cell"
                let cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
                cell.textLabel?.font=UIFont.systemFontOfSize(14)
                cell.selectionStyle = .None
                if indexPath.row==0 {
                    cell.textLabel?.text="预定人姓名"
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=44
                    peoplenameTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                    peoplenameTF.clearButtonMode=UITextFieldViewMode.Always
                    peoplenameTF.textAlignment = .Right
                    peoplenameTF.placeholder="请输入预订人姓名"
                    let username = NSUserDefaults.standardUserDefaults()
                    let Uname = username.stringForKey("username")
                    peoplenameTF.text=Uname
                    peoplenumTF.delegate=self
                    cell.addSubview(peoplenameTF)
                }else if indexPath.row==1 {
                    cell.textLabel?.text="入住人数"
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=44
                    peoplenumTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                    peoplenumTF.clearButtonMode=UITextFieldViewMode.Always
                    peoplenumTF.textAlignment = .Right
                    peoplenumTF.text="1"
                    peoplenumTF.keyboardType = .NumberPad
                    peoplenumTF.placeholder="请输入入住人数"
                    cell.addSubview(peoplenumTF)

                }else if indexPath.row==2 {
                    cell.textLabel?.text="预定人手机号"
                    let userphone = NSUserDefaults.standardUserDefaults()
                    let Uphone = userphone.stringForKey("userphone")
                    
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=44
                    phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                    phoneTF.clearButtonMode=UITextFieldViewMode.Always
                    phoneTF.textAlignment = .Right
                    phoneTF.text=Uphone
                    phoneTF.keyboardType = .NumberPad
                    phoneTF.placeholder="请输入预订人手机号"
                    cell.addSubview(phoneTF)

                }else if indexPath.row==3 {
                    cell.textLabel?.text="备注"
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=80
                    remarkTV = UITextView(frame: CGRectMake(60, 10, self.view.bounds.width-70, 60))
                    remarkTV.layer.borderColor=textColor.CGColor
                    remarkTV.layer.borderWidth=1
                    remarkTV.layer.cornerRadius=6
                    remarkTV.layer.masksToBounds=true
                    cell.addSubview(remarkTV)

                }

                return cell
            }

        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView==tableView1 {
            
            roomnumL.text = numArray.objectAtIndex(indexPath.row)as? String
            
            
            if roomnumL.text=="1间" {
                 Zprice=Int(price)!
            }else if roomnumL.text=="2间"{
                Zprice=Int(price)!*2
            }else if roomnumL.text=="3间"{
                Zprice=Int(price)!*3
            }else if roomnumL.text=="4间"{
                Zprice=Int(price)!*4
            }else if roomnumL.text=="5间"{
                Zprice=Int(price)!*5
            }else if roomnumL.text=="6间"{
                Zprice=Int(price)!*6
            }
            
            zongjiaL.text=String(Zprice)

            button.frame=CGRectMake(0, 0, 0, 0)
            tableView.frame=CGRectMake(0, 0, 0, 0)
        }
        else if tableView==tableView2{
            arrivetimeL.text=timeArray.objectAtIndex(indexPath.row) as? String
            
            button.frame=CGRectMake(0, 0, 0, 0)
            tableView.frame=CGRectMake(0, 0, 0, 0)
        }
        else{
            if indexPath.section==0 {
                
        
        switch indexPath.row {
        case 0:
            break
        case 1:
            tableView1=UITableView(frame: CGRectMake(0, self.view.bounds.height/4*3, self.view.bounds.width, self.view.bounds.height/4))
            tableView1.delegate=self
            tableView1.dataSource=self
            button=UIButton(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height/4*3))
            button.backgroundColor=UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5)
            button.addTarget(self, action: #selector(ReserveViewController.aaa(_:)), forControlEvents: .TouchUpInside)
            self.view.addSubview(button)
            self.view.addSubview(tableView1)
            
        default:
            tableView2=UITableView(frame: CGRectMake(0, self.view.bounds.height/4*3, self.view.bounds.width, self.view.bounds.height/4))
            tableView2.delegate=self
            tableView2.dataSource=self
            button=UIButton(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height/4*3))
            button.backgroundColor=UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5)
            button.addTarget(self, action: #selector(ReserveViewController.aaa(_:)), forControlEvents: .TouchUpInside)
            self.view.addSubview(button)
            self.view.addSubview(tableView2)
                }}}
    }
    func aaa(sender:UIButton){
        sender.frame=CGRectMake(0, 0, 0, 0)
        tableView1.frame=CGRectMake(0, 0, 0, 0)
        tableView2.frame=CGRectMake(0, 0, 0, 0)
        
    }
    func PandKong()->Bool{
        if(roomnumL.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择房间数量"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(arrivetimeL.text==nil){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择到达时间"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(peoplenameTF.text==""){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入联系人"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(peoplenumTF.text==""){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入入住人数"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }

        if(phoneTF.text==""){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入联系人手机号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        
        return true
    }
    

    func nowYuding(){
        
        if PandKong()==true{
      
        let url = apiUrl+"bookingroom"
            let userid = NSUserDefaults.standardUserDefaults()
            let uid = userid.stringForKey("userid")
            if uid==nil {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let vc  = mainStoryboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
                vc.str="1"

                self.presentViewController(vc, animated: true, completion: nil)

            }else{
            let roomidd=roomid
            let startzhengg = startzheng
            let endzhengg = endzheng
            let arrivetimee = arrivetimeL.text!
            let roomnumm = roomnumL.text!
            let peoplenumm = peoplenumTF.text!
            let phonee = self.phoneTF.text!
            let remarkk = self.remarkTV.text!
            let moneyy = zongjiaL.text!
            let peoplenamee = peoplenameTF.text!
 
            let param = [
            "userid":uid!,
            "goodsid":roomidd,
            "begintime":String(startzhengg),
            "endtime":String(endzhengg),
            "arrivetime":String(arrivetimee),
            "goodnum":roomnumm,
            "peoplenum":peoplenumm,
            "mobile":phonee,
            "remark":remarkk,
            "money":moneyy,
            "peoplename":peoplenamee
        ]
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

                        print("预定成功")
                    let alertController=UIAlertController(title: "提示", message: "您已预定成功", preferredStyle: .ActionSheet)
                    let cancelAction = UIAlertAction(title: "拨打酒店电话", style: .Cancel, handler: {
                        action in

                        UIApplication.sharedApplication().openURL(NSURL(string :"tel://0532-85969888-6002")!)
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabbar")
                        self.presentViewController(vc, animated: true, completion: nil)
                    
                    })
                    let okAction = UIAlertAction(title: "返回首页", style: .Default,
                        handler: {
                            action in
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabbar")
                            self.presentViewController(vc, animated: true, completion: nil)

                    })
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    }
                }
            }
        }
        }
    }
        override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.tabBarController?.tabBar.hidden=true
            self.title="立即预订"
            self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backItem?.title=""

        
    }
    //        键盘消失的通知方法
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.tableView0.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
            self.view.layoutIfNeeded()
        }
        
    }
    //     键盘出现的通知方法
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.tableView0.frame = CGRectMake(0, -150, self.view.bounds.width, self.view.bounds.height)
            self.view.layoutIfNeeded()
        }
    }



    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)
        //
    }


}
