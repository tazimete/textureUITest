//
//  CurrencyItemCell.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/15/22.
//

import UIKit


typealias BalanceItemCellConfig = ListViewCellConfigurator<BalanceItemCell, AbstractCellViewModel>

class BalanceItemCell: UICollectionViewCell, ConfigurableCell {
    typealias DataType = AbstractCellViewModel
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 0
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero, setAdaptive: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppConfig.shared.getTheme().getColors().textColorDark
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.applyAdaptiveLayout()
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        let contentViewConstraint = [
            AdaptiveLayoutConstraint(item: containerView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0, setAdaptiveLayout: true),
            AdaptiveLayoutConstraint(item: containerView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0, setAdaptiveLayout: true),
            AdaptiveLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0, setAdaptiveLayout: true),
            AdaptiveLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0, setAdaptiveLayout: true)
        ]
        
        let lblTitleConstraint = [
            AdaptiveLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 5, setAdaptiveLayout: true),
            AdaptiveLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 5, setAdaptiveLayout: true),
            AdaptiveLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0, setAdaptiveLayout: true)
        ]

        NSLayoutConstraint.activate(contentViewConstraint + lblTitleConstraint)
    }
    
    func configure(data: DataType) {
        titleLabel.text = "\( data.title ?? "")"
    }
}
