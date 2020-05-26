//
//  ViewController.swift
//  Sample
//
//  Created by motoki kawakami on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var label2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let user = UserRepository().fetchRemote() {
            label.text = "My name is \(user.name)."
        }
        
        if let user = UserRepository().fetchRemote() {
            label2.text = "I'm \(user.age) old years."
        }
    }
}

