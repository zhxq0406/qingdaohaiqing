//
//  mallOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/13.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class mallOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var tableView=UITableView()
    private var zongjiaL=UILabel()
    private var delBT=UIButton()
    private var addBT=UIButton()
    private var numL=UILabel()
    private var num=Int()
    private var textView=UITextView()
    private var nameTF=UITextField()
    private var roomnumTF=UITextField()
    private var phoneTF=UITextField()
    internal var price=Int()
    internal var goodsid=String()
    internal var mallname=String()
    internal var malldesc=String()
    internal var photo=String()
    private var pricenum=Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView(frame: CGRectMake(0,64,self.view.bounds.width,150))
        let view1 = UIView(frame: CGRectMake(0,10,self.view.bounds.width,110))
        view1.backgroundColor=UIColor.whiteColor()
        view.addSubview(view1)
        let imageView = UIImageView(frame: CGRectMake(10, 10, 100, 90))
        let url = imageUrl+photo
        
        imageView.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "默认.png"))
        view1.addSubview(imageView)
        let nameL = UILabel(frame: CGRectMake(120,10,self.view.bounds.width-120,40))
        nameL.lineBreakMode=NSLineBreakMode.ByWordWrapping
        nameL.numberOfLines=0
        nameL.text=mallname
        
        view1.addSubview(nameL)
        let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-50,50,50,30))
        priceL.textColor=BTColor
        priceL.text="¥"+String(price)
        view1.addSubview(priceL)
        tableView=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: .Plain)
        tableView.tableHeaderView=view
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor=bkColor
        
        self.view.addSubview(tableView)
        let pricell = UILabel(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        pricell.backgroundColor=UIColor.whiteColor()
        pricell.text="  总价："
        self.view.addSubview(pricell)
        zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.textColor=UIColor.init(red: 39/255, green: 178/255, blue: 252/255, alpha: 1)
       
        
        zongjiaL.text=String(price)
        self.view.addSubview(zongjiaL)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("立即预订", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(yuding), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yudingBT)

        //添加手势，点击空白处收回键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewtap))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        

        
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
            return 5

       
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
            
        
        let identifier = "cell"
        let cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        cell.selectionStyle = .None
        if indexPath.row==0 {
            cell.textLabel?.text="数量"
            delBT = UIButton(frame: CGRectMake(self.view.bounds.width-80,10,20,24))
            delBT.backgroundColor=bkColor
            delBT.layer.borderWidth=1.0
            delBT.layer.backgroundColor=bkColor.CGColor
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
            addBT = UIButton(frame: CGRectMake(self.view.bounds.width-30,10,20,24))
            addBT.backgroundColor=bkColor
            addBT.setTitleColor(UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1), forState: UIControlState.Normal)
            addBT.setTitle("+", forState: UIControlState.Normal)
            addBT.setTitle("", forState: .Highlighted)
            addBT.addTarget(self, action: #selector(addNum), forControlEvents: UIControlEvents.TouchUpInside)
            addBT.layer.borderWidth=1.0
            addBT.layer.backgroundColor=bkColor.CGColor
            delBT.layer.borderColor=UIColor.grayColor().CGColor
            addBT.layer.borderColor=UIColor.grayColor().CGColor
            numL.layer.borderColor=UIColor.grayColor().CGColor
            cell.addSubview(delBT)
            cell.addSubview(addBT)
            cell.addSubview(numL)
            tableView.rowHeight=44

        }else if indexPath.row==1 {
            cell.textLabel?.text="联系人"
            nameTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
            nameTF.clearButtonMode=UITextFieldViewMode.Always
            nameTF.textAlignment = .Right
            nameTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
            nameTF.placeholder="请输入联系人"
            let username = NSUserDefaults.standardUserDefaults()
            let Uname = username.stringForKey("username")
            nameTF.text=Uname
            cell.addSubview(nameTF)
            tableView.rowHeight=44
        }else if indexPath.row==2{
            cell.textLabel?.text="房间号"
            roomnumTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
            roomnumTF.clearButtonMode=UITextFieldViewMode.Always
            roomnumTF.textAlignment = .Right
            roomnumTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
            roomnumTF.placeholder="请输入房间号"
            cell.addSubview(roomnumTF)
            tableView.rowHeight=44
        }else if indexPath.row==3{
            cell.textLabel?.text="手机号"
            phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
            phoneTF.clearButtonMode=UITextFieldViewMode.Always
            phoneTF.textAlignment = .Right
            phoneTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
            phoneTF.placeholder="请输入手机号"
            let userphone = NSUserDefaults.standardUserDefaults()
            let Uphone = userphone.stringForKey("userphone")
            phoneTF.text=Uphone
            cell.addSubview(phoneTF)
            tableView.rowHeight=44
        }else{
            cell.textLabel?.text="备注"
            textView = UITextView(frame: CGRectMake(60, 10, self.view.bounds.width-70, 50))
            textView.layer.borderColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1).CGColor
            textView.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
            textView.layer.borderWidth=1
            textView.layer.cornerRadius=6
            textView.layer.masksToBounds=true
            cell.addSubview(textView)
            tableView.rowHeight=80

        }
        return cell
        
        
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
        pricenum = price*num

        zongjiaL.text=String(pricenum)
        
    }
    func addNum(){
        print("加")
        num+=1
        numL.text = String(num)
        pricenum = price*num

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
        
        
        return true
    }
    
    
    func yuding(){
        
        if PandKong()==true{
            
            let url = apiUrl+"bookingshopping"
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
                "goodsid":goodsid,
                "roomname":roomnumTF.text!,
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
                        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        hud.mode = MBProgressHUDMode.Text
                        hud.labelText = "恭喜您预定成功"
                        hud.margin = 10.0
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(true, afterDelay: 3)
                        
                        
                    }
                    }
                }
            }
        }
    }
    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)
        
    }

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
        let item = UIBarButtonItem(title: "商品预订", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
