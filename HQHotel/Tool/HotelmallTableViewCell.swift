//
//  HotelmallTableViewCell.swift
//  HQHotel
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class HotelmallTableViewCell: UITableViewCell {

    var imageV=UIImageView()
    var titName = UILabel()
    var size = UILabel()
    let backView = UIView()
    var priceLab = UILabel()
    let pre = UILabel()
    var prie = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        imageV.frame=CGRectMake(10, 5, self.bounds.width-20,self.bounds.height-50)
        
        self.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.addSubview(imageV)
        
        titName.frame = CGRectMake(self.bounds.width/2-100, self.bounds.height-42, 200, 20)
        titName.textAlignment = .Center
        titName.font = UIFont.systemFontOfSize(13)
        
        size.frame = CGRectMake(self.bounds.width/2-70, self.bounds.height-20, 140, 15)
        size.textAlignment = .Center
        size.font = UIFont.systemFontOfSize(11)
        size.textColor = UIColor.grayColor()
        self.addSubview(titName)
        self.addSubview(size)
        
        backView.frame = CGRectMake(10, bounds.height-95, 80, 35)
        backView.backgroundColor = UIColor.blackColor()
        backView.alpha = 0.6
        self.addSubview(backView)
        
        pre.frame = CGRectMake(5, 7.5, 10, 20)
        pre.text = "¥"
        pre.textAlignment = .Center
        pre.textColor = UIColor.whiteColor()
        pre.font = UIFont.systemFontOfSize(11)
        backView.addSubview(pre)
        prie.frame = CGRectMake(50, 7.5, 30, 20)
        prie.textColor = UIColor.whiteColor()
        prie.font = UIFont.systemFontOfSize(11)
        backView.addSubview(prie)
        
        priceLab.frame = CGRectMake(20, bounds.height-87.5, 40, 20)
        priceLab.font = UIFont.systemFontOfSize(14)
        priceLab.textColor = UIColor.orangeColor()
        priceLab.textAlignment = .Right
        self.addSubview(priceLab)
        
        
    }
    
    class func cellWithTableView(tableView:UITableView)->HotelmallTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? HotelmallTableViewCell
        
        if cell==nil {
            cell = HotelmallTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }
}
