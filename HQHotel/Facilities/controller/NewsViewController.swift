//
//  NewsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/3.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

     var titleL=UILabel()
     var timeL=UILabel()
     var textView=UITextView()
     var readL=UILabel()
     var readnumL:UILabel!
     var zanBT:UIButton!
    var name = String()
    var time = String()
    var content = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor=bkColor
       titleL=UILabel(frame: CGRectMake(5,70,self.view.bounds.width-10,50))
       titleL.text=name
        titleL.numberOfLines=0
        
        
       timeL=UILabel(frame: CGRectMake(5,70+50+5,self.view.bounds.width/3,20))
        timeL.text=time
        timeL.textColor=UIColor.grayColor()
        readL=UILabel(frame: CGRectMake(5,self.view.bounds.height-20,40,10))
        readL.text="阅读"
        readL.textColor=UIColor.grayColor()
        readL.font=UIFont.systemFontOfSize(16)
        readnumL=UILabel(frame: CGRectMake(50,self.view.bounds.height-22,80,13))
        readnumL.text="63672"
        readnumL.textColor=UIColor.grayColor()
        zanBT=UIButton(frame: CGRectMake(self.view.bounds.width-50, self.view.bounds.height-30, 20, 20))
        zanBT.imageView?.image=UIImage(named: "赞")
        let webView = UIWebView(frame: CGRectMake(5, 150, self.view.bounds.width-10, self.view.bounds.height-180))
        
        webView.loadHTMLString(content, baseURL: nil)

        print(content)
        
        self.view.addSubview(readnumL)
        self.view.addSubview(titleL)
        self.view.addSubview(readL)
        self.view.addSubview(timeL)
        self.view.addSubview(webView)
        self.view.addSubview(zanBT)
        
    }

    func getTextRectSize(text:NSString,fout:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName:fout]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        return rect
  
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    }

