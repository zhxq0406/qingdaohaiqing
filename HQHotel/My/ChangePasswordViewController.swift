//
//  ChangePasswordViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ChangePasswordViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var passTableview=UITableView()
    private var phoneTF=UITextField()
    private var codeTF=UITextField()
    private var textFiled1=UITextField()
    private var textFiled2=UITextField()
    private var timeL=UILabel()
    var str = String()
    
    var timeNow:NSTimer!
    
    var count:Int = 60
    override func viewDidLoad() {
        super.viewDidLoad()

        passTableview=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, 200), style: .Plain)
        self.view.backgroundColor=bkColor
        passTableview.scrollEnabled=false
        passTableview.delegate=self
        passTableview.dataSource=self
        self.automaticallyAdjustsScrollViewInsets=false
        passTableview.layer.borderWidth=1
        passTableview.rowHeight=50
        
        passTableview.layer.borderColor=UIColor.init(red: 229/255, green: 230/255, blue: 231/255, alpha: 1).CGColor
        self.view.addSubview(passTableview)

        let confirmBt = UIButton(frame: CGRectMake(self.view.bounds.width/2+10,self.view.bounds.width-50,self.view.bounds.width/2-20,50))
        confirmBt.backgroundColor=orangeColor
        confirmBt.layer.cornerRadius=3
        confirmBt.setTitle("确认修改", forState: .Normal)
        confirmBt.titleLabel?.font=UIFont.systemFontOfSize(15)
        confirmBt.addTarget(self, action: #selector(changePassword), forControlEvents: .TouchUpInside)
        self.view.addSubview(confirmBt)
        let quxiaoBt = UIButton(frame: CGRectMake(10,self.view.bounds.width-50,self.view.bounds.width/2-20,50))
        quxiaoBt.backgroundColor=orangeColor
        quxiaoBt.layer.cornerRadius=3
        quxiaoBt.setTitle("取消修改", forState: .Normal)
        quxiaoBt.titleLabel?.font=UIFont.systemFontOfSize(15)
        quxiaoBt.addTarget(self, action: #selector(quxiao), forControlEvents: .TouchUpInside)
        self.view.addSubview(quxiaoBt)
        
    }
    func quxiao(){
        if str=="1" {
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identif = "cell"
        let cell = UITableViewCell(style: .Default, reuseIdentifier: identif)
        cell.textLabel?.textColor=textColor
        cell.textLabel?.font=UIFont.systemFontOfSize(15)
        cell.selectionStyle = .None
        
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text="手机号"
            phoneTF = UITextField(frame: CGRectMake(80,15,self.view.bounds.width-200,20))
            phoneTF.textColor=textColor
            phoneTF.font=UIFont.systemFontOfSize(15)
            phoneTF.placeholder="请输入手机号"
            phoneTF.clearButtonMode = .Always
            let codeBT = UIButton(frame: CGRectMake(self.view.bounds.width-90,10,80,30))
            codeBT.backgroundColor=orangeColor
            codeBT.setTitle("获取验证码", forState: .Normal)
            codeBT.titleLabel?.font=UIFont.systemFontOfSize(14)
            codeBT.layer.cornerRadius=3
            codeBT.addTarget(self, action: #selector(GetCode), forControlEvents: .TouchUpInside)
            cell.addSubview(codeBT)
            cell.addSubview(phoneTF)

        case 1:
            cell.textLabel?.text="验证码"
            codeTF = UITextField(frame: CGRectMake(80,10,self.view.bounds.width-200,30))
            codeTF.textColor=textColor
            codeTF.font=UIFont.systemFontOfSize(15)
            codeTF.placeholder="请输入验证码"
            codeTF.clearButtonMode = .Always
            timeL = UILabel(frame: CGRectMake(self.view.bounds.width-50,15,40,20))
            timeL.hidden=true
            cell.addSubview(timeL)
            
            cell.addSubview(codeTF)
        case 2:
            cell.textLabel?.text="新密码"
            textFiled1 = UITextField(frame: CGRectMake(80,10,self.view.bounds.width-100,30))
            textFiled1.textColor=textColor
            textFiled1.font=UIFont.systemFontOfSize(15)
            textFiled1.placeholder="请输入新密码"
            textFiled1.secureTextEntry=true
            textFiled1.clearButtonMode = .Always
            cell.addSubview(textFiled1)
        default:
            textFiled2 = UITextField(frame: CGRectMake(80,10,self.view.bounds.width-100,30))
            textFiled2.textColor=textColor
            textFiled2.font=UIFont.systemFontOfSize(15)
            textFiled2.placeholder="请再次输入新密码"
            textFiled2.secureTextEntry=true
            textFiled2.clearButtonMode = .Always
            cell.textLabel?.text="新密码"
            cell.addSubview(textFiled2)
            
           
        }
        
        return cell
    }
    func GetCode(){
        if (phoneTF.text!.isEmpty||phoneTF.text?.characters.count != 11)
        {
            let alerView:UIAlertView = UIAlertView()
            alerView.title = "手机号输入错误"
            alerView.message = "请重新输入"
            alerView.addButtonWithTitle("确定")
            alerView.cancelButtonIndex = 0
            alerView.delegate = self
            alerView.tag = 1
            alerView.show()
            
        }
        else
        {
            let alerView:UIAlertView = UIAlertView()
            alerView.title = "发送验证码到"
            alerView.message = "\(phoneTF.text!)"
            alerView.addButtonWithTitle("取消")
            alerView.addButtonWithTitle("确定")
            alerView.cancelButtonIndex = 0
            alerView.delegate = self
            alerView.tag = 0
            alerView.show()
        }
        
    }

    func changePassword(){
        if PandKong()==true{
            RegisterYanZheng()
        }
    }
    
    func RegisterYanZheng(){
        let url = apiUrl+"forgetpwd"
        let param = [
            "phone":self.phoneTF.text!,
            "code":self.codeTF.text!,
            "password":self.textFiled1.text!
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
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
                    hud.labelText = "密码修改成功"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                    if self.str=="1" {
                        self.navigationController?.popViewControllerAnimated(true)
                    }else{
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }

                }
            }
        }
    }
    func PandKong()->Bool{
        if(phoneTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入手机号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(codeTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入验证码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if (textFiled1.text!.isEmpty) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入密码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
            
        }
        if (textFiled2.text!.isEmpty) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请再次输入密码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
            
        }
        if (textFiled2.text! != textFiled1.text!) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入相同密码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
            
        }

        return true
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 0
        {
            if buttonIndex == 1
            {
                self.senderMessage()
                timeL.hidden = false
                self.timeDow()
            }
        }
        if alertView.tag == 1
        {}
        if alertView.tag == 2
        {}
    }
    func timeDow()
    {
        let time1 = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        timeNow = time1
    }
    func updateTime()
    {
        count -= 1
        if (count <= 0)
        {
            count = 60
            self.showRepeatButton()
            timeNow.invalidate()
        }
        timeL.text = "\(count)S"
        
    }

    func showRepeatButton()
    {
        timeL.hidden=true
      
    }

    
    func senderMessage()
    {
        let url = apiUrl+"SendMobileCode"
        let param = [
            "phone":self.phoneTF.text!,
            ]
        
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
                
            }
            else{
                print(url)
            }
        }
    }


    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationController?.navigationBar.backItem?.title=""
        self.navigationItem.title="登录密码修改"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
