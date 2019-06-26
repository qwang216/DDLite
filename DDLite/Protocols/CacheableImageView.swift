//
//  CacheableImageView.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

protocol CacheableImageView: class {
    var imageURL: String? { get set }
}

let imageCache = NSCache<NSString, UIImage>()
extension CacheableImageView where Self: UIImageView {
    func fetchImage(url: String) {
        let nsURLString = url as NSString
        imageURL = url
        image = nil
        
        if let cachedImage = imageCache.object(forKey: nsURLString) {
            self.image = cachedImage
            return
        }
        DDNetworkManager.shared.fetchDataFrom(url: url) { [unowned self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard self.imageURL == url, let validImage = UIImage(data: data) else { return }
                    imageCache.setObject(validImage, forKey: nsURLString)
                    self.image = validImage
                case .failure(let err):
                    print("loading Image error: ", String(describing: err.errorDescription))
                    self.image = UIImage(named: "doordash-logo")
                    
                }
                
                
                
            }
        }
    }
}
