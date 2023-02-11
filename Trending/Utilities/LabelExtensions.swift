//
//  LabelExtensions.swift
//  Trending
//
//  Created by Natia's Mac on 11.02.23.
//

import UIKit
extension UILabel {
    
    func addTrailing(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.image?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 2, bottom: 2, right: 2))
        attachment.image?.withTintColor(.yellow)
        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
    
    func addLeading(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
}
