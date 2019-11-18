//
//  BottomView.swift
//  Licious
//
//  Created by Koushik Dutta on 19/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class BottomBar : UIToolbar{
    override open func didMoveToWindow(){
        super.didMoveToWindow()
        if #available(iOS 11.0, *){
            if self.window?.safeAreaLayoutGuide != nil {
                self.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: (self.window?.safeAreaLayoutGuide.bottomAnchor)!, multiplier: 1.0).isActive = true
            }
        }
    }
}
