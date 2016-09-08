//
//  OrderFoodViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/10.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class OrderFoodViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    private var tableView=UITableView()
    private var imageView=UIImageView()
    private var num = Int()
    internal var price=String()
    internal var name=String()
    internal var roomid=String()
    private var numL = UILabel()
    private var delBT=UIButton()
    private var addBT=UIButton()
    private var pricenum=Int()
    private var priceZ=UILabel()
    private var nameTF=UITextField()
    private var phoneTF=UITextField()
    private var numTF=UITextField()
    private var peoplenumTF=UITextField()
    private var timeTF=UITextField()
    private var textView=UITextView()
    private var zongjiaL=UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
        self.navigationItem.title="立即预订"
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        
//tableView
        
        tableView=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Grouped)
        tableView.delegate=self
        tableView.dataSource=self

//UIimageView
        imageView=UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.width*0.5))
        imageView.image=UIImage(named: "food1.png")
        
        tableView.tableHeaderView=imageView
        self.view.addSubview(tableView)
        
        let priceL = UILabel(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        priceL.backgroundColor=UIColor.whiteColor()
        priceL.text="  总价："
        priceL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
        self.view.addSubview(priceL)
        zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
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
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
    
            return 4
        
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellidentifier:String = "cell"
        let cell:UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: cellidentifier)
        
        
        cell.selectionStyle = .None
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text=name
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-90,5,80,44-10))
                priceL.text="¥\(price)/份"
                priceL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                priceL.textAlignment = .Right
                cell.addSubview(priceL)
                tableView.rowHeight=44
                
            }else if indexPath.row==1{
                cell.textLabel?.text="数量"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                delBT = UIButton(frame: CGRectMake(self.view.bounds.width-80,10,20,24))
                delBT.backgroundColor=bkColor
                delBT.layer.borderWidth=1.0
                delBT.layer.borderColor=UIColor.grayColor().CGColor
                delBT.layer.masksToBounds=true
                delBT.setTitleColor(UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1), forState: UIControlState.Normal)
                delBT.setTitle("-", forState: UIControlState.Normal)
                delBT.setTitle("", forState: .Highlighted)
                delBT.addTarget(self, action: #selector(delNum), forControlEvents: UIControlEvents.TouchUpInside)
                numL = UILabel(frame: CGRectMake(self.view.bounds.width-60,10,30,24))
                
                num=1
                
                numL.text = String(num)
                numL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                numL.textAlignment = .Center
                numL.layer.borderWidth=1.0
                numL.layer.borderColor=UIColor.grayColor().CGColor
                addBT = UIButton(frame: CGRectMake(self.view.bounds.width-30,10,20,24))
                addBT.layer.borderColor=UIColor.grayColor().CGColor
                addBT.setTitleColor(UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1), forState: UIControlState.Normal)
                addBT.setTitle("+", forState: UIControlState.Normal)
                addBT.setTitle("", forState: .Highlighted)
                addBT.addTarget(self, action: #selector(addNum), forControlEvents: UIControlEvents.TouchUpInside)
                addBT.layer.borderWidth=1.0
                addBT.layer.backgroundColor=bkColor.CGColor
                
                cell.addSubview(delBT)
                cell.addSubview(addBT)
                cell.addSubview(numL)
                tableView.rowHeight=44
                
            }
            else if indexPath.row==2{
                cell.textLabel?.text="小计"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-90,5,80,44-10))
                priceL.text="¥\(price)"
                priceL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                priceL.textAlignment = .Right
                cell.addSubview(priceL)
                tableView.rowHeight=44
            }
            else if indexPath.row==3{
                cell.textLabel?.text="总价"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                pricenum = Int(price)!*num
                zongjiaL.text=String(pricenum)
                priceZ = UILabel(frame: CGRectMake(self.view.bounds.width-90,5,80,44-10))
                priceZ.text=String(pricenum)
                priceZ.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                priceZ.textAlignment = .Right
                cell.addSubview(priceZ)
                tableView.rowHeight=44
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text="联系人"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                nameTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                nameTF.clearButtonMode=UITextFieldViewMode.Always
                nameTF.textAlignment = .Right
                nameTF.placeholder="请输入联系人"
                let username = NSUserDefaults.standardUserDefaults()
                let Uname = username.stringForKey("username")
                nameTF.text=Uname
                nameTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(nameTF)
                tableView.rowHeight=44
            }else if indexPath.row==1{
                cell.textLabel?.text="手机号"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                phoneTF.clearButtonMode=UITextFieldViewMode.Always
                phoneTF.textAlignment = .Right
                phoneTF.keyboardType = .NumberPad
                phoneTF.placeholder="请输入手机号"
                let userphone = NSUserDefaults.standardUserDefaults()
                let Uphone = userphone.stringForKey("userphone")
                phoneTF.text=Uphone
                phoneTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(phoneTF)
                tableView.rowHeight=44
            }

            else if indexPath.row==2{
                cell.textLabel?.text="就餐时间"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                timeTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                timeTF.clearButtonMode=UITextFieldViewMode.Always
                timeTF.textAlignment = .Right
                timeTF.placeholder="请输入就餐时间"
                timeTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(timeTF)
                tableView.rowHeight=44
                
            }

            else if  indexPath.row==3{
                cell.textLabel?.text="备注"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                textView = UITextView(frame: CGRectMake(60, 10, self.view.bounds.width-70, 50))
                textView.layer.borderColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1).CGColor
                textView.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                textView.layer.borderWidth=1
                textView.layer.cornerRadius=6
                textView.layer.masksToBounds=true
                cell.addSubview(textView)
                tableView.rowHeight=80
            }

        }

        
        return cell
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var titlestr=String()
        if section==0 {
            titlestr = "美食信息"
            
        }else if section==1
        {
            titlestr = "就餐信息"
            
        }
        return titlestr
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
    }
    func delNum(){
        print("减")
        num -= 1
        if num == 0 {
            delBT.userInteractionEnabled=false
        }else{
            delBT.userInteractionEnabled=true
        }
        numL.text = String(num)
        pricenum = Int(price)!*num
        priceZ.text=String(pricenum)
        zongjiaL.text=String(pricenum)

    }
    func addNum(){
        print("加")
        num+=1
        numL.text = String(num)
        pricenum = Int(price)!*num
        priceZ.text=String(pricenum)
        zongjiaL.text=String(pricenum)

    }
    func PandKong()->Bool{
        if(nameTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入联系人"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(phoneTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入手机号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }

     
        if(timeTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入就餐时间"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }

        
        return true
    }

    
    func nowYuding(){
        
        if PandKong()==true{
            
            let url = apiUrl+"bookingcatering"
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
                "goodsid":roomid,
                "repasttime":timeTF.text!,
                "peoplename":nameTF.text!,
                "goodnum":numL.text!,
                "mobile":phoneTF.text!,
                "remark":textView.text!,
                "money":zongjiaL.text!
                
                
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
    //         键盘消失的通知方法
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.tableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
            self.view.layoutIfNeeded()
        }
        
    }
    //     键盘出现的通知方法
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.tableView.frame = CGRectMake(0, -200, self.view.bounds.width, self.view.bounds.height)
            self.view.layoutIfNeeded()
        }
    }
    override func  viewWillDisappear(animated: Bool) {
        
        self.tabBarController?.tabBar.hidden=false
   
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
    }

    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)


        
    }

    
}
