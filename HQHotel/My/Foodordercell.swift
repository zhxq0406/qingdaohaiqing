//
//  Foodordercell.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/9.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class Foodordercell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
 
    @IBOutlet weak var nameL: UILabel!
  
    @IBOutlet weak var numL: UILabel!
    
    @IBOutlet weak var deleteBT: UIButton!
    
    @IBOutlet weak var priceL: UILabel!
    
    @IBOutlet weak var timeL: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
