//
//  UITableView+Extensions.swift
//  DDLite
//
//  Created by Jason wang on 6/21/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ T: T.Type) where T: ReuseableView {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: ReuseableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("unable to dequeue cell: \(T.identifier)")
        }
        return cell
    }
}
