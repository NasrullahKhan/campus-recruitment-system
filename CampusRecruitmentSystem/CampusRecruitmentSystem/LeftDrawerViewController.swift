//
//  LeftDrawerViewController.swift
//  Firebase-SignUP-SignIN
//
//  Created by Nasrullah Khan on 25/01/2017.
//  Copyright © 2017 Nasrullah Khan. All rights reserved.
//

import UIKit
import DrawerController

class LeftDrawerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.evo_drawerController?.showsShadows = false
        
        // Opening Gestures
        self.evo_drawerController?.openDrawerGestureModeMask.formSymmetricDifference(.panningNavigationBar)
        self.evo_drawerController?.openDrawerGestureModeMask.formSymmetricDifference(.panningCenterView)
        self.evo_drawerController?.openDrawerGestureModeMask.formSymmetricDifference(.bezelPanningCenterView)
        
        // Closing Gestures
        self.evo_drawerController?.closeDrawerGestureModeMask.formSymmetricDifference(.panningNavigationBar)
        self.evo_drawerController?.closeDrawerGestureModeMask.formSymmetricDifference(.panningCenterView)
        self.evo_drawerController?.closeDrawerGestureModeMask.formSymmetricDifference(.panningDrawerView)
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        
        let nav = self.evo_drawerController?.childViewControllers[0]
        self.evo_drawerController?.setCenter(nav!, withFullCloseAnimation: true, completion: nil)
        
    }

}
