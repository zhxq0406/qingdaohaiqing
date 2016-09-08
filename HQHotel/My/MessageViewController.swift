//
//  MessageViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class MessageViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var tableView=UITableView()
    private var messageTableview=UITableView()
    var MassageSource = MassageModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GetMassageDate()
       tableView.frame=CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.rowHeight=80
        self.view.addSubview(tableView)
    }
    func GetMassageDate(){
        let url = apiUrl+"getsystemmessage"
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
        print(url)
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.MassageSource = MassageModel(status.data!)
                    self.tableView.reloadData()
                }
            }
        }
    }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return MassageSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = MassageCell.cellWithTableView(tableView)
        let massageinfo = MassageSource.objectlist[indexPath.row]
        cell.selectionStyle = .None
        
        cell.titleL.text=massageinfo.title
        cell.contentL.text=massageinfo.content
        cell.timeL.text=massageinfo.create_time
        let photo = massageinfo.photo!
        let url = imageUrl+photo
        cell.iconIV.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "青岛海情-002.JPG"))
        
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let massageinfo = MassageSource.objectlist[indexPath.row]
        let alertController=UIAlertController(title: massageinfo.title, message: massageinfo.content, preferredStyle: .Alert)
   
        let cancelAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
    
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func viewWillDisappear(animated: Bool) {
        let item = UIBarButtonItem(title: "消息中心", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }

}
