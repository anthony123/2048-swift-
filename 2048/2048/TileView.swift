//
//  TileView.swift
//  2048
//
//  Created by liuwq on 16/5/8.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

class TileView: UIView
{
    var value :Int? = nil{
        
        
        didSet{
            self.setNeedsDisplay()
            
        }
    }
    
    var numberLabel:UILabel?
    
    func setColorForValue(value:Int)->UIColor{
        var color: UIColor
        
        switch value{
        case 2,4: color = UIColor.blackColor()
        default:  color = UIColor.whiteColor()
        }
        return color
        
    }
    
    
    override func drawRect(rect: CGRect) {
        
        // draw rect
        self.backgroundColor = Constants.tileColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(Constants.tileCornerRadius)
        
        numberLabel?.removeFromSuperview()
        numberLabel = nil
        
        let frame = CGRect(x: 0, y: 0, width: Constants.tileWidth, height: Constants.tileWidth)
        //numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.tileWidth, height: Constants.tileWidth))
        numberLabel = UILabel()
        UIView.animateWithDuration(Constants.duration, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            self.numberLabel?.frame = frame
            }, completion: nil)
        numberLabel!.textAlignment = .Center
        numberLabel!.backgroundColor = Constants.tileColor
        numberLabel!.layer.masksToBounds = true
        numberLabel!.font = Constants.numberFont
        numberLabel!.minimumScaleFactor = 0.5
        numberLabel!.layer.cornerRadius = self.layer.cornerRadius
        if value == nil{
            numberLabel!.text = ""
            numberLabel!.backgroundColor = Constants.tileColor
        }else{
            numberLabel!.text = "\(value!)"
            numberLabel!.backgroundColor = self.setBackgroundColorForValue(value!)
            numberLabel!.textColor = self.setColorForValue(value!)
        }
        
        addSubview(numberLabel!)
        
        
    }
    
    func setBackgroundColorForValue(value:Int)->UIColor
    {
        var color:UIColor
        switch value{
        case 2: color =  UIColor(red: 238.0/255, green: 228.0/255, blue: 244.0/255, alpha: 1)
        case 4: color =  UIColor(red: 237.0/255, green: 224.0/255, blue: 200.0/255, alpha: 1)
        case 8: color =  UIColor(red: 245.0/255, green: 149.0/255, blue: 99.0/255, alpha: 1)
        case 16: color =  UIColor(red: 245.0/255, green: 130.0/255, blue: 97.0/255, alpha: 1)
        case 32: color =  UIColor(red: 246.0/255, green: 124.0/255, blue: 95.0/255, alpha: 1)
        case 64: color =  UIColor(red: 246.0/255, green: 94.0/255, blue: 59.0/255, alpha: 1)
        case 128: color =  UIColor(red: 237.0/255, green: 207.0/255, blue: 114.0/255, alpha: 1)
        case 256: color =  UIColor(red: 237.0/255, green: 207.0/255, blue: 114.0/255, alpha: 1)
        case 512: color =  UIColor(red: 237.0/255, green: 200.0/255, blue: 80.0/255, alpha: 1)
        case 1024: color =  UIColor(red: 237.0/255, green: 197.0/255, blue: 63.0/255, alpha: 1)
        case 2048: color =  UIColor(red: 237.0/255, green: 194.0/255, blue: 46.0/255, alpha: 1)
        default: color =  UIColor.darkGrayColor()
        }
        
        return color
    }
    
}
