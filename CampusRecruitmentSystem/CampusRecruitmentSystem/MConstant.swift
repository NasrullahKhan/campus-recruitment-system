//
//  MConstant.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 24/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    
    func showHud() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    func hideHud() {
        MBProgressHUD.hide(for: self, animated: true)
    }

}

extension UIViewController {
    
    func showAlert(title: String, msg: String) {
        
        let alertController = UIAlertController(title: title, message:
            msg, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
