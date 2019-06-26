//
//  ExploreCell.swift
//  DDLite
//
//  Created by Jason wang on 6/21/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

class ExploreCell: DDBaseCell {
    
    // logoImage
    // resturantNameLabel
    // descriptionLabel
    let logoImageView: DDImageView = {
        let iv = DDImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        let height = iv.heightAnchor.constraint(equalToConstant: 60)
        height.isActive = true
        height.priority = UILayoutPriority(rawValue: 999)
        return iv
    }()
    
    let resturantNameLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return lb
    }()
    
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lb.textColor = .lightGray
        lb.numberOfLines = 1
        return lb
    }()
    
    // deliveryFeeLabel
    // estDeliveryTimeLabel
    let deliveryFeeLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lb.textColor = .gray
        return lb
    }()
    
    let estDeliveryTimeLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lb.textColor = .gray
        return lb
    }()
    
    var merchantVM: MerchantViewModel? {
        didSet {
            logoImageView.fetchImage(url: merchantVM?.logoURLString ?? "")
            resturantNameLabel.text = merchantVM?.merchantName
            descriptionLabel.text = merchantVM?.description
            deliveryFeeLabel.text = merchantVM?.deliveryFee
            estDeliveryTimeLabel.text = merchantVM?.estimateDeliveryTime
        }
    }
    
    override func setupCell() {
        super.setupCell()
        setupView()
    }
    
    fileprivate func setupView() {
        let deliveryStackView = UIStackView(arrangedSubviews: [deliveryFeeLabel, estDeliveryTimeLabel])
        deliveryStackView.axis = .horizontal
        deliveryStackView.distribution = .equalSpacing
        let infoStackView = UIStackView(arrangedSubviews: [resturantNameLabel, descriptionLabel, deliveryStackView])
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 5
        let containerStackView = UIStackView(arrangedSubviews: [logoImageView, infoStackView])
        containerStackView.axis = .horizontal
        containerStackView.spacing = 10
        containerStackView.distribution = .fill
        containerStackView.isLayoutMarginsRelativeArrangement = true
        containerStackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        contentView.addSubviews(containerStackView)
        containerStackView.fillToSuperView()
    }
}
