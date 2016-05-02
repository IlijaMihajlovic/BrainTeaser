//
//  LoginVC.swift
//  BrainTeaser
//
//  Created by Jonny B on 3/26/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    // Variables
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
        
      
    }

    override func viewDidAppear(animated: Bool) {
        
        self.animEngine.animateOnScreen(1)
    }

}

