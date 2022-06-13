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
  
    let backgroundImageNode: ASImageNode
    let animalImageNode: ASNetworkImageNode
  
    let animalNameTextNode: ASTextNode
    let animalDescriptionTextNode: ASTextNode
  
//  fileprivate let gradientNode: GradientNode
  
  init(animalInfo: Repository) {
    self.animalInfo = animalInfo
    
    backgroundImageNode = ASImageNode()
    animalImageNode     = ASNetworkImageNode()
    
    animalNameTextNode        = ASTextNode()
    animalDescriptionTextNode = ASTextNode()
    
//    gradientNode = GradientNode()
    
    super.init()
    
    backgroundColor = UIColor.lightGray
    clipsToBounds = true
    
    //Animal Image
//    animalImageNode.url = animalInfo
    animalImageNode.clipsToBounds = true
    animalImageNode.delegate = self
    animalImageNode.placeholderFadeDuration = 0.15
    animalImageNode.contentMode = .scaleAspectFill
    animalImageNode.shouldRenderProgressImages = true
    
    //Animal Name
      animalNameTextNode.attributedText = NSAttributedString(string: animalInfo.description.unwrappedValue)
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
    
    //Background Image
    backgroundImageNode.placeholderFadeDuration = 0.15
//    backgroundImageNode.imageModificationBlock = { image in
//      let newImage = UIImage.resize(image, newSize: CGSize(width: 100, height: 300)).applyBlur(withRadius: 10, tintColor: UIColor(white: 0.5, alpha: 0.3), saturationDeltaFactor: 1.8, maskImage: nil)
//      return (newImage != nil) ? newImage : image
//    }
    
    //Gradient Node
//    gradientNode.isLayerBacked = true
//    gradientNode.isOpaque = false
//
    addSubnode(backgroundImageNode)
    addSubnode(animalImageNode)
//    addSubnode(gradientNode)
    
    addSubnode(animalNameTextNode)
    addSubnode(animalDescriptionTextNode)
      
      animalNameTextNode.frame = bounds
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let ratio: CGFloat = constrainedSize.min.height/constrainedSize.max.width;
    
//    let imageRatioSpec = ASRatioLayoutSpec(ratio: ratio, child: animalImageNode)
//    let gradientOverlaySpec = ASOverlayLayoutSpec(child: imageRatioSpec, overlay: animalNameTextNode)
    
    let relativeSpec = ASRelativeLayoutSpec(
        horizontalPosition: .init(rawValue: 0)!,
      verticalPosition: .end,
      sizingOption: .init(rawValue: 0),
      child: animalNameTextNode)
    
//      let nameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 0), child: relativeSpec)
    
//    let nameOverlaySpec = ASOverlayLayoutSpec(child: nameInsetSpec, overlay: animalDescriptionTextNode)
      let descriptionTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 28, bottom: 12, right: 28), child: animalDescriptionTextNode)
    
    let verticalStackSpec = ASStackLayoutSpec()
    verticalStackSpec.direction = .vertical
//    verticalStackSpec.children = [nameOverlaySpec, descriptionTextInsetSpec]
    
    let backgroundLayoutSpec = ASBackgroundLayoutSpec(child: verticalStackSpec, background: backgroundImageNode)
    
    return relativeSpec
  }
}

// MARK: - ASNetworkImageNodeDelegate

extension CardCellNode: ASNetworkImageNodeDelegate {
  func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
    backgroundImageNode.image = image
  }
}
