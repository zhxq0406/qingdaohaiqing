//
//  NewsTableViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

     var imageV=UIImageView()
     var titleL=UILabel()
     var jianjieL=UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.backgroundColor=UIColor.whiteColor()
        titleL.frame=CGRectMake(10, 5, self.bounds.width-20, 20)
        
        imageV.frame=CGRectMake(10, 30, self.bounds.width-20, 110)

        jianjieL.frame=CGRectMake(10, 140, self.bounds.width-20, 60)

        jianjieL.textColor=UIColor.grayColor()
        jianjieL.font=UIFont.systemFontOfSize(12)
        jianjieL.lineBreakMode=NSLineBreakMode.ByCharWrapping
        jianjieL.numberOfLines=0
        //添加标题名称
        self.addSubview(titleL)
        //添加图片
        self.addSubview(imageV)
        //添加简介内容
        self.addSubview(jianjieL)

    }
    class func cellWithTableView(tableView:UITableView)->NewsTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? NewsTableViewCell
        
        if cell==nil {
            cell = NewsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            
        }
        return cell!
    }

}
