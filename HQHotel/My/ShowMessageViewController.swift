//
//  ShowMessageViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/21.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ShowMessageViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView = UITableView()
    var nameTF = UITextField()
    var phoneTF = UITextField()
    var sexTF = UITextField()
    var ageTF = UITextField()
    var cityTF = UITextField()
    var youxiangTF = UITextField()
   
    var username = String()
    var userphone = String()
    var userphoto = String()
    var usersex = String()
    var userage = String()
    var usercity = String()
    var useryouxiang = String()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.view.backgroundColor=bkColor
        tableView=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-64), style: .Grouped)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.layer.borderWidth=1
        tableView.layer.borderColor=UIColor.grayColor().CGColor
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.addSubview(tableView)

        let button1 = UIButton(frame:CGRectMake(0, 0, 40, 20))
       button1.setTitle("编辑", forState: .Normal)
        button1.addTarget(self,action:#selector(ShowMessageViewController.bianji(_:)),forControlEvents:.TouchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        
        self.navigationItem.rightBarButtonItem=barButton1
    }
    func bianji(sender:UIButton){
       if sender.titleLabel?.text=="编辑"{
        self.nameTF.enabled=true
        self.nameTF.clearButtonMode = .Always
        self.sexTF.enabled=true
        self.sexTF.clearButtonMode = .Always
        self.phoneTF.enabled=true
        self.phoneTF.clearButtonMode = .Always
        self.ageTF.enabled=true
        self.ageTF.clearButtonMode = .Always
        self.cityTF.enabled=true
        self.cityTF.clearButtonMode = .Always
        sender.setTitle("保存", forState: .Normal)
        
       }else{
        changeMessage()
        sender.setTitle("编辑", forState: .Normal)
        }
        
        
    }
    func GetPersonDate(){
        let url = apiUrl+"getuserinfo"
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
        print(uid)
        Alamofire.request(.GET, url, parameters: param as! [String:String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = PersonalModel(JSONDecoder(json!))
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
                    
                    self.username=(status.data?.personalname!)!
                    self.userphone=(status.data?.personalphone!)!
                    self.userphoto=(status.data?.personalphoto!)!
                    self.usercity=(status.data?.personalcity!)!
                    self.tableView.reloadData()
                    }
            }
                }
            }
        }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section==0 {
            return 1
        }else{
            return 5
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .None
        
        if indexPath.section==0 {
            let iconIV = UIImageView(frame: CGRectMake(self.view.bounds.width-90, 5, 55, 55))
            iconIV.image=UIImage(named: "默认.jpg")
            cell.addSubview(iconIV)
            cell.textLabel?.text="头像"
            tableView.rowHeight=65
            
        }else{
            if indexPath.row==0 {
                cell.textLabel?.text="姓 名"
                tableView.rowHeight=44
                nameTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,165,30))
                nameTF.text=self.username
                nameTF.enabled=false
                nameTF.textAlignment = .Right
                cell.addSubview(nameTF)
                tableView.rowHeight=40
                
            
            }else if indexPath.row==1{
                cell.textLabel?.text="性别"
                tableView.rowHeight=44
                sexTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,165,30))
                sexTF.text=self.usersex
                sexTF.enabled=false
                sexTF.textAlignment = .Right
                cell.addSubview(sexTF)
                tableView.rowHeight=40
            }
            else if indexPath.row==2{
                cell.textLabel?.text="年龄"
                tableView.rowHeight=44
                ageTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,165,30))
                ageTF.text=self.userage
                ageTF.enabled=false
                ageTF.textAlignment = .Right
                cell.addSubview(ageTF)
                tableView.rowHeight=40
            }
            else if indexPath.row==3{
                cell.textLabel?.text="城市"
                tableView.rowHeight=44
                cityTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,165,30))
                cityTF.text=self.usercity
                cityTF.enabled=false
                cityTF.textAlignment = .Right
                cell.addSubview(cityTF)
                tableView.rowHeight=40
            }
            else {
                cell.textLabel?.text="邮箱"
                tableView.rowHeight=44
                youxiangTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,165,30))
                youxiangTF.text=self.useryouxiang
                youxiangTF.enabled=false
                youxiangTF.textAlignment = .Right
                cell.addSubview(youxiangTF)
                tableView.rowHeight=40
            }

        }
        return cell
    }
    func changeMessage(){
        let url = apiUrl+"savepersonalinfo"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let param = [
            "userid":uid,
            "nicename":self.nameTF.text,
            "sex":self.sexTF.text!,
            "age":self.ageTF.text!,
            "city":self.cityTF.text!
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param as?[String:String]).response { request, response, json, error in
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
                    hud.labelText = "修改成功"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                    self.GetPersonDate()
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        GetPersonDate()
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
        let item = UIBarButtonItem(title: "我的", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
