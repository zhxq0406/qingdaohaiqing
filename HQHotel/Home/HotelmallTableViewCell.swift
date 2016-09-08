//
//  HotelmallTableViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class HotelmallTableViewCell: UITableViewCell {

     var imageV=UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        imageV.frame=CGRectMake(10, 5, self.bounds.width-20,self.bounds.height-35)
        imageV.image=UIImage(named: "青岛海情-0.JPG")
        self.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.addSubview(imageV)
        
        
        
        
    }
    
   class func cellWithTableView(tableView:UITableView)->HotelmallTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? HotelmallTableViewCell
        
        if cell==nil {
            cell = HotelmallTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }

}
