//
//  LoginViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class LoginViewController: UIViewController ,UITextFieldDelegate{

  

    @IBOutlet weak var AccountText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    
    @IBOutlet weak var LoginButton: UIButton!

    @IBOutlet weak var bbbbT: UIButton!
    

    @IBOutlet weak var changePassword: UIButton!
    

    @IBOutlet weak var remenberBT: UIButton!
    
    var str = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)

        self.navigationController?.navigationBar.backItem?.title=""
        AccountText.delegate = self
        AccountText.placeholder="请输入账号"
        PasswordText.delegate = self
        PasswordText.secureTextEntry=true
        PasswordText.placeholder="请输入密码"
        let aaa = NSUserDefaults.standardUserDefaults()
        let aa = aaa.integerForKey("aa")
        LoginButton.layer.cornerRadius=4
        if aa == 1  {
            let phonenum = NSUserDefaults.standardUserDefaults()
            AccountText.text = phonenum.stringForKey("phone")
            let passwordnum = NSUserDefaults.standardUserDefaults()
            PasswordText.text = passwordnum.stringForKey("password")
            remenberBT.setImage(UIImage(named: "ic_xuanzhong"), forState: .Normal)
        }
        
        bbbbT.layer.cornerRadius=4
        LoginButton.addTarget(self, action: #selector(LoginViewController.Login), forControlEvents: UIControlEvents.TouchUpInside)
        changePassword.addTarget(self, action: #selector(changePass), forControlEvents: .TouchUpInside)
        
    }
    func changePass(){
        let vc = ChangePasswordViewController()
     
        let nav = UINavigationController(rootViewController: vc)
        
        
        self.presentViewController(nav, animated: true, completion: nil)

    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title="登录"
        self.navigationController?.navigationBar.hidden=false
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        AccountText.resignFirstResponder()
        PasswordText.resignFirstResponder()
        return true
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func Login(){
        if(AccountText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入账号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
        if(PasswordText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入密码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
        let url = apiUrl+"applogin"
        let param = [
            "phone":self.AccountText.text!,
            "password":self.PasswordText.text!
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                let status = Httpresult(JSONDecoder(json!))
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
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.labelText = "登录成功"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                    let userid = NSUserDefaults.standardUserDefaults()
                    userid.setValue(status.data?.id, forKey: "userid")
                    if (self.remenberBT.imageView?.image==UIImage(named: "ic_xuanzhong")) {
                    
                        let phonenum = NSUserDefaults.standardUserDefaults()
                        phonenum.setValue(self.AccountText.text, forKey: "phone")
                        let passwordnum = NSUserDefaults.standardUserDefaults()
                        passwordnum.setValue(self.PasswordText.text, forKey: "password")
                        let aaa = NSUserDefaults.standardUserDefaults()
                        aaa.setValue(1, forKey: "aa")
                  
                    }else{
                        let aaa = NSUserDefaults.standardUserDefaults()
                        aaa.setValue(2, forKey: "aa")
                    }
                    self.GetPersonDate()
      
                        self.dismissViewControllerAnimated(true, completion: nil)

                    
                }
            }
        }
    }
    func GetPersonDate(){
        let url = apiUrl+"getuserinfo"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
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
                    let username = NSUserDefaults.standardUserDefaults()
                    username.setValue(status.data?.personalname, forKey: "username")
                    let userphone = NSUserDefaults.standardUserDefaults()
                    userphone.setValue(status.data?.personalphone, forKey: "userphone")
                   
                }
                
            }
        }
    }
    

    @IBAction func zhuce(sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("register")

        let nav = UINavigationController(rootViewController: vc)
        
        
        self.presentViewController(nav, animated: true, completion: nil)

        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    @IBAction func quxiaoBT(sender: AnyObject) {
        if str=="1" {
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabbar")
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
 
    }
    
    @IBAction func bt(sender: UIButton) {
        if (sender.imageView?.image==UIImage(named: "ic_xuanzhong")) {
            sender.setImage(UIImage(named: "ic_xuznze"), forState: .Normal)
        }else{
        sender.setImage(UIImage(named: "ic_xuanzhong"), forState: .Normal)
        }
        
    }
    

    
    
}