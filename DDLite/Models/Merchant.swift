//
//  DDMerchant.swift
//  DDLite
//
//  Created by Jason wang on 6/21/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import Foundation

struct Merchant {
    let id: Int // id
    let name: String // name
    let description: String // description
    let deliveryFee: Int // delivery_fee
    let coverImageURLString: String // cover_img_url
    let estDeliveryTime: Int? // asap_time
}

extension Merchant: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        
        case deliveryFee = "delivery_fee"
        case estDeliveryTime = "asap_time"
        case coverImageURLString = "cover_img_url"
    }
}
