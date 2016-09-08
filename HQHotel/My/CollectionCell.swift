//
//  CollectionCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/17.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {

    var iconView = UIImageView()
    var nameL = UILabel()
    var jianjieL = UILabel()
    var priceL = UILabel()
    var yudingBT = UIButton()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       iconView.frame = CGRectMake(10, 10, 80, 80)
        self.addSubview(iconView)
        nameL.frame = CGRectMake(100,10,self.bounds.width-180,20)
        self.addSubview(nameL)
        jianjieL.frame = CGRectMake(100,40,self.bounds.width-180,50)
        jianjieL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
        jianjieL.font=UIFont.systemFontOfSize(12)
        jianjieL.numberOfLines=0
        self.addSubview(jianjieL)
        priceL.frame = CGRectMake(self.bounds.width-70,10,60,20)
        priceL.textColor=orangeColor
        self.addSubview(priceL)
        yudingBT.frame = CGRectMake(self.bounds.width-70,60,60,20)
        yudingBT.backgroundColor=orangeColor
        yudingBT.setTitle("预订", forState: .Normal)
        yudingBT.titleLabel?.font=UIFont.systemFontOfSize(14)
        yudingBT.layer.cornerRadius=3
        self.addSubview(yudingBT)

    
    }
    class func cellWithTableView(tableView:UITableView)->CollectionCell  {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? CollectionCell
        
        if cell==nil {
            cell = CollectionCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
            
        }
        return cell!
    }
    
    
}
