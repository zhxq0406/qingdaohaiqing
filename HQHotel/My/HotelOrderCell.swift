//
//  HotelOrderCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class HotelOrderCell: UITableViewCell {

 

    @IBOutlet weak var imageview=UIImageView()
 
    @IBOutlet weak var fangxingL=UILabel()

    @IBOutlet weak var shuliangL=UILabel()
    @IBOutlet weak var zongjiaL=UILabel()
    
    
    @IBOutlet weak var quxiaoBT=UIButton()
    
    
    @IBOutlet weak var timeL=UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
