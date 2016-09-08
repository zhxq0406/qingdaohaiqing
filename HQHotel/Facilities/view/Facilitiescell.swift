//
//  Facilitiescell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/16.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit


class Facilitiescell: UIView {

    private let imageView = UIImageView()
    
     override init(frame: CGRect){
        super.init(frame: frame)
        
        
        imageView.image=UIImage(named: "bj.jpg")
        imageView.frame=CGRectMake(0, 0, frame.width, frame.height)
       
        
        
        self.addSubview(imageView)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    






}
