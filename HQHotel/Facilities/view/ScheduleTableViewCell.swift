//
//  ScheduleTableViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/29.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    internal var roomnum=UILabel()
    internal var time=UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        roomnum = UILabel(frame: CGRectMake(10,5,self.bounds.width/3,self.bounds.height-10))
        
        roomnum.textColor=UIColor.grayColor()
        self.addSubview(roomnum)
        time=UILabel(frame: CGRectMake(self.bounds.width/3,5,self.bounds.width/2,self.bounds.height-10))
        self.addSubview(time)
        
    }
    class func cellWithTableView(tableView:UITableView)->ScheduleTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? ScheduleTableViewCell
        
        if cell==nil {
            cell = ScheduleTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
           
        }
        return cell!
    }


}
