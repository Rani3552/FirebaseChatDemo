//
//  Utility.swift
//  FirebaseDemo
//
//  Created by Rani Singh on 01/06/20.
//  Copyright © 2020 InnoCric. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
    
    static let sharedMHUtility = Utility()
    
    func showAlert(message : String, actionTitle: String, onVC: UIViewController?) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message:message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
            if let vc = onVC {
                vc.present(alertController, animated: true, completion: nil)
            } else {
                self.APPDELEGATE.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    func showCustomAlert(title: String?, message: String, cancelTitle: String?, okTitle: String, onVC: UIViewController?, completionBlock:@escaping (Bool) -> Void) {

          DispatchQueue.main.async {

            let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
              if let cancel = cancelTitle {
                  alertController.addAction(UIAlertAction(title: cancel, style: .default, handler: { (action) in
                      completionBlock(false)
                  }))
              }
              alertController.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action) in
                  completionBlock(true)
              }))
              if let vc = onVC {
                  vc.present(alertController, animated: true, completion: nil)
              } else {
                self.APPDELEGATE.window?.rootViewController?.present(alertController, animated: true, completion: nil)
              }
          }
      }
    
}
