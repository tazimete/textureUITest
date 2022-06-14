//
//  CardCellNode.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/5/22.
//

import UIKit
import AsyncDisplayKit

class UserCellNode: ASCellNode {
    let item: Repository
    
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
        node.style.preferredLayoutSize = ASLayoutSizeMake(ASDimensionMake(.auto, 0), ASDimensionMake("70%"))
        node.truncationAttributedText = NSAttributedString(string: "…")
        node.truncationMode = .byTruncatingTail
        node.style.spacingAfter = 10
        node.backgroundColor = UIColor.clear
        node.placeholderEnabled = true
        node.placeholderFadeDuration = 0.15
        node.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        node.maximumNumberOfLines = 3
        return node
    }()
    
    
    init(item: Repository) {
        self.item = item
        
        super.init()
        
        clipsToBounds = true
        
        addSubnode(avatarNode)
        addSubnode(nameNode)
        addSubnode(descriptionNode)
        
        //set data
        avatarNode.url = URL(string: item.description ?? "")
        nameNode.attributedText = NSAttributedString(string: item.name ?? "")
        descriptionNode.attributedText = NSAttributedString(string: item.description.unwrappedValue)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio: CGFloat = constrainedSize.min.height/constrainedSize.max.width;
        
        avatarNode.style.preferredSize = CGSize(width: constrainedSize.min.height, height: constrainedSize.min.height)
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
        let nameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16), child: nameRelativeSpec)
        
        let descriptionTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16), child: descriptionRelativeSpec)
        
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [nameInsetSpec, descriptionTextInsetSpec]
        
        let horizontalStackSpec = ASStackLayoutSpec()
        horizontalStackSpec.direction = .horizontal
        horizontalStackSpec.children = [imageInsetSpec, verticalStackSpec]
        
        return horizontalStackSpec
    }
}
