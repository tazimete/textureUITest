//
//  UIView+Extension.swift
//  currency-converter
//
//  Created by AGM Tazimon 26/7/21.
//

import UIKit


extension UIView {
 
    @IBInspectable var cornerRadius: CGFloat {
       set(newValue) {
           layer.cornerRadius = newValue
           layer.masksToBounds = newValue > 0
       }
        
        get{
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set(newValue) {
            layer.borderWidth = newValue
        }
         
         get{
             return layer.borderWidth
         }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set(newValue) {
            layer.borderColor = newValue?.cgColor
        }
         
         get{
            return UIColor(cgColor: layer.borderColor!)
         }
    }
    
 func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
     var topInset = CGFloat(0)
     var bottomInset = CGFloat(0)
     
     if #available(iOS 11, *), enableInsets {
         let insets = self.safeAreaInsets
         topInset = insets.top
         bottomInset = insets.bottom
     }
     
     translatesAutoresizingMaskIntoConstraints = false
     
     if let top = top {
        self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
     }
     if let left = left {
        self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
     }
     if let right = right {
        rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
     }
     if let bottom = bottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
     }
     if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
     }
     if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
     }
 }
 
}

extension UIView {
    func addShadow(offset: CGSize = CGSize(width: -1, height: 5), color: UIColor = UIColor.black, radius: CGFloat = 2, opacity: Float = 0.5) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        layer.shadowPath = UIBezierPath(rect: self.frame).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addTopShadow(shadowHeight height: CGFloat = 5) {
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: 0))
        shadowPath.addLine(to: CGPoint(x: frame.width, y:0))
        shadowPath.addLine(to: CGPoint(x: frame.width-20, y: frame.height ))
        shadowPath.addLine(to: CGPoint(x: frame.width-20, y: frame.height))
        shadowPath.close()

        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 2
    }
}
