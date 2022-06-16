//
//  UILabel+Extension.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/17/22.
//

import UIKit


extension UILabel {
    
    func addTrailing(image: UIImage, text:String? = nil) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: "\(text.unwrappedValue)  ", attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
    
    func addLeading(image: UIImage, text:String? = nil) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: "  \(text.unwrappedValue)", attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
}
