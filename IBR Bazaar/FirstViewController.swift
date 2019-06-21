//
//  FirstViewController.swift
//  IBR Bazaar
//
//  Created by Monish M S on 21/06/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "Home")
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: controller)
    }


}

