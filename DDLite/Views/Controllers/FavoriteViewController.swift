//
//  FavoriteViewController.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let messageLabel: UILabel = {
       let lb = UILabel()
        lb.text = "Coming Soon..."
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        view.addSubview(messageLabel)
        messageLabel.centerSuperView()
        view.backgroundColor = .white
        
    }
}
