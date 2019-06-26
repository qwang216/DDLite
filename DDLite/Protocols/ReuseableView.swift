//
//  ReuseableView.swift
//  DDLite
//
//  Created by Jason wang on 6/21/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

protocol ReuseableView {}
extension ReuseableView where Self: Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

