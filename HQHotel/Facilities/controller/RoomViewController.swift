//
//  RoomViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class RoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private var tableView=UITableView()
    internal var type=String()
    private var FacilitesSource=FacilitesModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetFacilitesDate()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        tableView=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        tableView.dataSource=self
        tableView.delegate=self
        tableView.rowHeight=90
        
        self.view.addSubview(tableView)
    }
    func GetFacilitesDate(){
        let url = apiUrl+"getFacilitylist"
        let param = [
            "type":type
            
        ]

        print(url)
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("设施状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.FacilitesSource = FacilitesModel(status.data!)
                    self.tableView.reloadData()
                }
            }
        }
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return FacilitesSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = FacilitiesTableViewCell.cellWithTableView(tableView)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        let facilitesinfo = FacilitesSource.objectlist[indexPath.row]
        cell.titleL.text=facilitesinfo.facilitestitle
        cell.jieshaoL.text=facilitesinfo.facilitesexcerpt
        let photo = facilitesinfo.facilitesphoto
        let url = imageUrl+photo!
        
        cell.iconIV.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "青岛海情-002.JPG"))
        
        
        
        
        
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let facilitesinfo = FacilitesSource.objectlist[indexPath.row]
        let roomVC = RoomDetailsViewController()
        roomVC.content=facilitesinfo.facilitescontent!
        roomVC.name=facilitesinfo.facilitestitle!
        self.navigationController?.pushViewController(roomVC, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        switch type {
        case "12":
            self.navigationItem.title="房间设施"
        case "14":
            self.navigationItem.title="海情婚宴"
        case "15":
            self.navigationItem.title="会议设施"
        default:
             self.navigationItem.title="餐饮美食"
        }
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
}
