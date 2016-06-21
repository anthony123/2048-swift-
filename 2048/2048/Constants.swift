//
//  Constants.swift
//  2048
//
//  Created by liuwq on 16/5/8.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

struct Constants{
    static let  dimension = 4
    static let threshold = 2048
    static let tileWidth = 54.0
    static let tilePadding = 8.0
    static let boardCornerRadius = 2.0
    static let tileCornerRadius = 1.2
    static let duration:NSTimeInterval = 0.08
    static let gameBoardColor = UIColor(red: 187.0/255, green: 173.0/255, blue: 160.0/255, alpha: 1)
    static let tileColor = UIColor(red: 204.0/255, green: 192.0/255, blue: 179.0/255, alpha: 1)
    static let numberFont = UIFont(name: "HelveticaNeue-Bold", size: 40)
    static let randomRatio = 0.7  //generate "2" is 4 times bigger than "4"
    
}
