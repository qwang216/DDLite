//
//  ExploreViewModel.swift
//  DDLite
//
//  Created by Jason wang on 6/22/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import Foundation

class ExploreViewModel {
    fileprivate var merchants: [MerchantViewModel]
    
    init(merchants: [MerchantViewModel]) {
        self.merchants = merchants
    }
    
    var merchantCounts: Int {
        return merchants.count
    }
    
    var exploreTitle: String {
        return "DoorDash"
    }
    
    func merchantVMAt(_ index: Int) -> MerchantViewModel {
        return merchants[index]
    }
    
}
