//
//  ScalableHeadingLabel.swift
//  morse-coder
//
//  Created by labuser on 9/3/18.
//  Copyright © 2018 mc. All rights reserved.
//
// Credits
// 1. Identifying screen sizes (https://stackoverflow.com/questions/25025779/setting-uilabel-text-to-bold)

import UIKit

class ScalableHeadingLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        font = UIFont.systemFont(ofSize: getFontSize())
    }
    
    func getFontSize() -> CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            /// iPhone 5/5C/5S
            case 1136:
                return 20
            /// iPhone 6/6S/7/8
            case 1334:
                return 22
            /// iPhone 6+/6S+/7+/8+
            case 1920, 2208:
                return 24
            /// iPhone X
            case 2436:
                return 26
            default:
                return 20
            }
        } else {
            switch UIScreen.main.nativeBounds.height {
            /// 7.9" and 9.7" iPad mini
            case 2048:
                return 30
            /// 10.5" iPad Pro
            case 2224:
                return 35
            /// 12.9" iPad Pro
            case 2732:
                return 40
            default:
                return 30
            }
        }
    }

}
