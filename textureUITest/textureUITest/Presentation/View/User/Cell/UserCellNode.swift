//
//  CardCellNode.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/5/22.
//

import UIKit
import AsyncDisplayKit
import CoreMedia

class UserCellNode: ASCellNode {
    let item: User
    
    let avatarNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.clipsToBounds = true
        node.placeholderFadeDuration = 0.15
        node.contentMode = .scaleAspectFill
        node.shouldRenderProgressImages = true
        return node
    }()
    
    let nameNode: ASTextNode = {
        let node = ASTextNode()
        node.placeholderEnabled = true
        node.placeholderFadeDuration = 0.15
        node.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        return node
    }()
    
    let descriptionNode: ASTextNode = {
        let node = ASTextNode()
        node.truncationAttributedText = NSAttributedString(string: "…")
        node.truncationMode = .byTruncatingTail
        node.style.spacingAfter = 10
        node.backgroundColor = UIColor.clear
        node.placeholderEnabled = true
        node.placeholderFadeDuration = 0.15
        node.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        node.maximumNumberOfLines = 0
        node.isLayerBacked = true
        node.isOpaque = false
        return node
    }()
    
    
    init(item: User) {
        self.item = item
        
        super.init()
        
        clipsToBounds = true
        
        addSubnode(avatarNode)
        addSubnode(nameNode)
        addSubnode(descriptionNode)
        
        //set data
        avatarNode.url = URL(string: item.avatarUrl ?? "")
        nameNode.attributedText = NSAttributedString(string: item.name ?? "", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ])
        descriptionNode.attributedText = NSAttributedString(string: item.type.unwrappedValue, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular),
            NSAttributedString.Key.paragraphStyle: NSTextAlignment.justified
        ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio: CGFloat = constrainedSize.min.height/constrainedSize.max.width;
        
        avatarNode.style.preferredSize = CGSize(width: constrainedSize.min.height-20, height: constrainedSize.min.height-20)
        avatarNode.cornerRadius = (constrainedSize.min.height-20)/2
        let imageRatioSpec = ASRatioLayoutSpec(ratio: ratio, child: avatarNode)
        
        let nameRelativeSpec = ASRelativeLayoutSpec(
            horizontalPosition: .init(rawValue: 0)!,
            verticalPosition: .end,
            sizingOption: .init(rawValue: 0),
            child: nameNode)
        
        let imageRelativeSpec = ASRelativeLayoutSpec(
            horizontalPosition: .init(rawValue: 0)!,
            verticalPosition: .end,
            sizingOption: .init(rawValue: 0),
            child: imageRatioSpec)
        
        let descriptionRelativeSpec = ASRelativeLayoutSpec(
            horizontalPosition: .init(rawValue: 0)!,
            verticalPosition: .end,
            sizingOption: .init(rawValue: 0),
            child: descriptionNode)
        
        let imageInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: imageRelativeSpec)
        let nameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0), child: nameRelativeSpec)
        let descriptionInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0), child: descriptionRelativeSpec)
        
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [nameInsetSpec, descriptionInsetSpec]
        
        let vserticalStackInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 16), child: verticalStackSpec)
        
        let horizontalStackSpec = ASStackLayoutSpec()
        horizontalStackSpec.direction = .horizontal
        horizontalStackSpec.children = [imageInsetSpec, vserticalStackInsetSpec]
        
        return horizontalStackSpec
    }
}
