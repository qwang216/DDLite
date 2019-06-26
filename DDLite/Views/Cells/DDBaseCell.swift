//
//  DDBaseCell.swift
//  DDLite
//
//  Created by Jason wang on 6/21/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

class DDBaseCell: UITableViewCell, ReuseableView {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    func setupCell() {
        //insert any common cell logic here
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
