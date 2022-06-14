//
//  CardCellNode.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/5/22.
//

import UIKit
import AsyncDisplayKit

class CardCellNode: ASCellNode {
    let animalInfo: Repository
    
    let animalImageNode: ASNetworkImageNode
    
    let animalNameTextNode: ASTextNode
    let animalDescriptionTextNode: ASTextNode
    
    
    init(animalInfo: Repository) {
        self.animalInfo = animalInfo
        
        animalImageNode     = ASNetworkImageNode()
        
        animalNameTextNode        = ASTextNode()
        animalDescriptionTextNode = ASTextNode()
        
        super.init()
        
        backgroundColor = UIColor.lightGray
        clipsToBounds = true
        
        //Animal Image
        animalImageNode.url = URL(string: animalInfo.description ?? "")
        animalImageNode.clipsToBounds = true
        animalImageNode.delegate = self
        animalImageNode.placeholderFadeDuration = 0.15
        animalImageNode.contentMode = .scaleAspectFill
        animalImageNode.shouldRenderProgressImages = true
        animalImageNode.backgroundColor = .orange
        
        //Animal Name
        animalNameTextNode.attributedText = NSAttributedString(string: animalInfo.name ?? "nil string")
        animalNameTextNode.placeholderEnabled = true
        animalNameTextNode.placeholderFadeDuration = 0.15
        animalNameTextNode.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        
        //Animal Description
        animalDescriptionTextNode.attributedText = NSAttributedString(string: animalInfo.description.unwrappedValue)
        animalDescriptionTextNode.truncationAttributedText = NSAttributedString(string: "…")
        animalDescriptionTextNode.backgroundColor = UIColor.clear
        animalDescriptionTextNode.placeholderEnabled = true
        animalDescriptionTextNode.placeholderFadeDuration = 0.15
        animalDescriptionTextNode.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        
        addSubnode(animalImageNode)
        
        addSubnode(animalNameTextNode)
        addSubnode(animalDescriptionTextNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio: CGFloat = constrainedSize.min.height/constrainedSize.max.width;
        
        animalImageNode.style.preferredSize = CGSize(width: constrainedSize.min.height, height: constrainedSize.min.height)
        let imageRatioSpec = ASRatioLayoutSpec(ratio: ratio, child: animalImageNode)
        
        let nameRelativeSpec = ASRelativeLayoutSpec(
            horizontalPosition: .init(rawValue: 10)!,
            verticalPosition: .end,
            sizingOption: .init(rawValue: 0),
            child: animalNameTextNode)
        
        let imageRelativeSpec = ASRelativeLayoutSpec(
            horizontalPosition: .init(rawValue: 0)!,
            verticalPosition: .end,
            sizingOption: .init(rawValue: 0),
            child: imageRatioSpec)
        
        let imageInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: imageRelativeSpec)
        let nameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16), child: nameRelativeSpec)
        
        let descriptionTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16), child: animalDescriptionTextNode)
        
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [nameInsetSpec, descriptionTextInsetSpec]
        
        let horizontalStackSpec = ASStackLayoutSpec()
        horizontalStackSpec.direction = .horizontal
        horizontalStackSpec.children = [imageInsetSpec, verticalStackSpec]
        
        return horizontalStackSpec
    }
}

// MARK: - ASNetworkImageNodeDelegate

extension CardCellNode: ASNetworkImageNodeDelegate {
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        //      animalImageNode.image = image
    }
}
