//
//  CustomButton.swift
//  Licious
//
//  Created by Koushik Dutta on 17/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import Foundation
import  UIKit

class CustomButton : UIButton{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitleColor(.gray, for: .disabled)
        layer.borderWidth = 1
        if !isEnabled{
            layer.borderColor = UIColor.gray.cgColor
        }
    }
        
    override var isEnabled: Bool{
        didSet{
            if(isEnabled){
                setTitleColor(.red, for: .normal)
                layer.borderColor = UIColor.red.cgColor
            }else{
                setTitleColor(.gray, for: .disabled)
                layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
    
}
