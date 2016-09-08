//
//  BreakTableViewCell.swift
//  HQHotel
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class BreakTableViewCell: UITableViewCell {

    let content = UILabel()
    let guige = UILabel()
    let danjia = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        content.frame = CGRectMake(10, 7, 100, 30)
        content.textAlignment = .Center
        content.font = UIFont.systemFontOfSize(14)
        guige.frame = CGRectMake(WIDTH/5*3, 7, 50, 30)
        guige.font = UIFont.systemFontOfSize(14)
        guige.textAlignment = .Center
        danjia.frame = CGRectMake(WIDTH-50, 7, 40, 30)
        danjia.textAlignment = .Center
        danjia.font = UIFont.systemFontOfSize(14)
        
        self.addSubview(content)
        self.addSubview(guige)
        self.addSubview(danjia)
        
        // Configure the view for the selected state
    }

    class func cellWithTableView(tableView:UITableView)->ScheduleTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? ScheduleTableViewCell
        
        if cell==nil {
            cell = ScheduleTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
            
        }
        return cell!
    }

}
