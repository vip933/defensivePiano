//
//  StartViewController.swift
//  defensivePiano
//
//  Created by Maksim on 13.03.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = UITextView()
        text.text = "hello!"
        view.addSubview(text)
        text.pin(to: view)
    }
}
