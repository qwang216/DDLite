//
//  Coordinator.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

protocol Coordinator {
    var child: [Coordinator] { get set }
    var nav: UINavigationController { get set }
    
    func start()
}
