//
//  BaseViewController.swift
//  GitRepoSearch
//
//  Created by Bhushan on 06/05/20.
//  Copyright © 2020 Bhushan. All rights reserved.
//

import UIKit
import PKHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showProgress(){
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    func hideProgress(){
        PKHUD.sharedHUD.hide()
    }
}
