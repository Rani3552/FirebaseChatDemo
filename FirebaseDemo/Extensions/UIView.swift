//
//  UIView.swift
//  FirebaseDemo
//
//  Created by Rani Singh on 01/06/20.
//  Copyright © 2020 InnoCric. All rights reserved.
//

import UIKit

extension UIView {
    
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView.init(style: .white)
        
        if let _ = self.viewWithTag(200) as? UIActivityIndicatorView {
            
        } else {
            activityIndicator.center = self.center
            activityIndicator.color = UIColor.black
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 200
            self.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.viewWithTag(200) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    
}
