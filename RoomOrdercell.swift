//
//  RoomOrdercell.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/17.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class RoomOrdercell: UITableViewCell {
    
    @IBOutlet weak var nameL: UILabel!
    
    
    @IBOutlet weak var foodL: UILabel!
    
    
    @IBOutlet weak var foodIV: UIImageView!
    
    @IBOutlet weak var mianjiL: UILabel!
    
    @IBOutlet weak var chuangxingL: UILabel!
    
    @IBOutlet weak var chicunL: UILabel!
    
    
    @IBOutlet weak var iconIV: UIImageView!
    
    @IBOutlet weak var loucengL: UILabel!
    
    @IBOutlet weak var youhuijiaL: UILabel!
    
    @IBOutlet weak var menshijiaL: UILabel!
    
    @IBOutlet weak var yudingBT: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
