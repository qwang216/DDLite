//
//  ExploreDataServices.swift
//  DDLite
//
//  Created by Jason wang on 6/22/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import Foundation
import CoreLocation

class ExploreDataServices: ExploreDataServiceable {
    
    func fetchExploreDataAt(_ lng: Double, lat: Double, onCompletion: @escaping (Result<ExploreViewModel, NetworkError>) -> Void) {
        DDNetworkManager.shared.fetchDDMerchant(url: "https://api.doordash.com/v1/store_search/?lat=\(lat)&lng=\(lng)") { (result) in
            
            switch result {
            case .success(let merchants):
                let merchantVM = merchants.map { MerchantViewModel.init(merchant: $0) }
                let exploreVM = ExploreViewModel(merchants: merchantVM)
                onCompletion(.success(exploreVM))
            case .failure(let err):
                onCompletion(.failure(err))
            }
            
        }
    }
    
}
