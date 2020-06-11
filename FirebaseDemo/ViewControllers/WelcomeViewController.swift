//
//  WelcomeViewController.swift
//  FirebaseDemo
//
//  Created by Rani Singh on 08/04/20.
//  Copyright © 2020 InnoCric. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    //MARK: - ViewController Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "⚡️Messages"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
}

