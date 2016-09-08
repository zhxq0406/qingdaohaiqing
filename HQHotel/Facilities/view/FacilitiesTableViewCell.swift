//
//  FacilitiesTableViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/28.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class FacilitiesTableViewCell: UITableViewCell {

     var iconIV=UIImageView()
     var titleL=UILabel()
     var jieshaoL=UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        iconIV.frame = CGRectMake(10, 10, 70, 70)
        
        self.addSubview(iconIV)
        titleL.frame=CGRectMake(85,10,self.bounds.width-90,20)
        
        self.addSubview(titleL)
        jieshaoL.frame=CGRectMake(85,35,self.bounds.width-115,self.bounds.height-40)
        
        jieshaoL.font=UIFont.systemFontOfSize(12)
        jieshaoL.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        jieshaoL.numberOfLines=0
        self.addSubview(jieshaoL)
    }

    class func cellWithTableView(tableView:UITableView)->FacilitiesTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? FacilitiesTableViewCell
        
        if cell==nil {
            cell = FacilitiesTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }
}
