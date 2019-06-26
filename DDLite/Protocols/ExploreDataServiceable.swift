//
//  ExploreDataServiceable.swift
//  DDLite
//
//  Created by Jason wang on 6/22/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import Foundation

protocol ExploreDataServiceable {
    func fetchExploreDataAt(_ lng: Double, lat: Double, onCompletion: @escaping (Result<ExploreViewModel, NetworkError>) -> Void)
}
