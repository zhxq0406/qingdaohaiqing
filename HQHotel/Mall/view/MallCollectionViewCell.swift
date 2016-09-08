//
//  MallCollectionViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class MallCollectionViewCell: UICollectionViewCell {

     var imageView: UIImageView!
    
     var nameL: UILabel!
    
     var jianjieL: UILabel!
    
     var priceL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView=UIImageView(frame: CGRectMake(0, 0, frame.width, frame.height-80))
        
        nameL=UILabel(frame: CGRectMake(5, frame.height-80, frame.width, 30))
        nameL.textColor=textColor
        nameL.baselineAdjustment = UIBaselineAdjustment.AlignBaselines
        jianjieL=UILabel(frame: CGRectMake(5, frame.height-50, frame.width, 10))
        jianjieL.textColor=textColor
        jianjieL.font=UIFont.systemFontOfSize(12)

        priceL=UILabel(frame: CGRectMake(5, frame.height-35, frame.width, 30))
        
        priceL.textColor=blueColor
        priceL.font=UIFont.systemFontOfSize(17)

        self.backgroundColor=UIColor.whiteColor()
        self.addSubview(imageView)
        self.addSubview(nameL)
        self.addSubview(jianjieL)
        self.addSubview(priceL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
