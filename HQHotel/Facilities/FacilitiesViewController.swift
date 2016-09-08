//
//  FacilitiesViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class FacilitiesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var view1=UIImageView()
    private var NewsSouce=NewsModel()
    private var heardView=UIView()
    private var tableView=UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetNewsDate()

        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        tableView.frame =  CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        tableView.rowHeight=200
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        self.view.addSubview(tableView)
        let view1_h = self.view.bounds.width*0.35
        heardView = UIView()
        for item in 0...3{

            view1 = UIImageView(frame: CGRectMake(0, CGFloat(item)*(view1_h+10), self.view.bounds.width, view1_h))
            view1.image=UIImage(named: "设施\(item).png")
            
            let button = UIButton()
            button.frame=view1.frame
            
            button.tag=item
            if button.tag==0 {
                button.addTarget(self, action: #selector(FacilitiesViewController.dobuttonOne(_:)), forControlEvents:.TouchUpInside)
                button
            }
            if button.tag==1 {
                button.addTarget(self, action: #selector(FacilitiesViewController.dobuttonOne(_:)), forControlEvents: .TouchUpInside)
            }
            if button.tag==2 {
                button.addTarget(self, action: #selector(FacilitiesViewController.dobuttonOne(_:)), forControlEvents: .TouchUpInside)
            }
            if button.tag==3 {
                button.addTarget(self, action: #selector(FacilitiesViewController.dobuttonOne(_:)), forControlEvents: .TouchUpInside)
            }
            heardView.addSubview(view1)
            heardView.addSubview(button)
            
        }
        let zixunIV = UIImageView(frame: CGRectMake(0,(view1_h+10)*4+5 , self.view.bounds.width, 16))
        zixunIV.image=UIImage(named: "ss_zixun")
        self.view.addSubview(zixunIV)
        heardView.addSubview(zixunIV)
        heardView.frame=CGRectMake(0,66,self.view.bounds.width,view1_h*4+66)
        tableView.tableHeaderView=heardView
       
    }
    func GetNewsDate(){
        let url = apiUrl+"getNewslist"
  
        Alamofire.request(.GET, url, parameters: nil).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("资讯状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.NewsSouce = NewsModel(status.data!)
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return NewsSouce.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let newscell = NewsTableViewCell.cellWithTableView(tableView)
        newscell.selectionStyle = .None
        let newsinfo = NewsSouce.objectlist[indexPath.row]
        newscell.titleL.text=newsinfo.Newstitle
        newscell.jianjieL.text=newsinfo.Newsexcerpt
        let photo = newsinfo.Newsphoto
        let url = imageUrl+photo!
        
        newscell.imageV.sd_setImageWithURL(NSURL(string: url ),placeholderImage: UIImage(named: "青岛海情-002.JPG"))
        return newscell
       
    }
    //点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let newsVC = NewsViewController()
        let newsinfo = NewsSouce.objectlist[indexPath.row]
        newsVC.name=newsinfo.Newstitle!
        newsVC.time=newsinfo.Newscreat_time!
        newsVC.content=newsinfo.Newscontent!
        self.navigationController?.pushViewController(newsVC, animated: true)
        
    }
    //设施二级页面跳转
    func dobuttonOne(sender:UIButton){
        switch sender.tag {
        case 0:
            let oneVC = RoomViewController()
            oneVC.type="12"
            self.navigationController?.pushViewController(oneVC, animated: true)
        case 1:
            let oneVC = RoomViewController()
            oneVC.type="14"
            self.navigationController?.pushViewController(oneVC, animated: true)
        case 2:
            let oneVC = RoomViewController()
            oneVC.type="15"
            self.navigationController?.pushViewController(oneVC, animated: true)

        default:
            let oneVC = RoomViewController()
            oneVC.type="16"
            self.navigationController?.pushViewController(oneVC, animated: true)

        }
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title="设施"
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
