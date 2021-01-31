//
//  UIColor.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 30.01.2021.
//

import UIKit

extension UIColor {
    
    static var confettiColors: [UIColor ] {
        get {
            return [
                (r:149,g:58,b:255), (r:255,g:195,b:41), (r:255,g:101,b:26),
                (r:123,g:92,b:255), (r:76,g:126,b:255), (r:71,g:192,b:255),
                (r:255,g:47,b:39), (r:255,g:91,b:134), (r:233,g:122,b:208)
            ].map {
                UIColor(red: $0.r / 255.0, green: $0.g / 255.0, blue: $0.b / 255.0, alpha: 1)
            }
        }
    }
    
    static func randomConfettiColor() -> UIColor {
        confettiColors.randomElement()!
    }
}
