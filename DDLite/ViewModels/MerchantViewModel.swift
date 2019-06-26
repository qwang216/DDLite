//
//  MerchantViewModel.swift
//  DDLite
//
//  Created by Jason wang on 6/22/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import Foundation

class MerchantViewModel {
    fileprivate let merchant: Merchant
    
    init(merchant: Merchant) {
        self.merchant = merchant
    }
    
    var merchantName: String {
        return merchant.name
    }
    
    var logoURLString: String {
        return merchant.coverImageURLString
    }
    
    var description: String {
        return merchant.description
    }
    
    var deliveryFee: String {
        let deliverFee = merchant.deliveryFee == 0 ? "Free" : "$\(merchant.deliveryFee)"
        return "\(deliverFee) delivery"
    }
    
    var estimateDeliveryTime: String {
        guard let deliverTime = merchant.estDeliveryTime else { return "N/A"}
        return "\(deliverTime) min"
    }
}
