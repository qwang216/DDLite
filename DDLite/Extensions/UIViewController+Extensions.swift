//
//  UIViewController+Extensions.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertView(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}
