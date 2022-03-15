//
//  Constants.swift
//  defensivePiano
//
//  Created by Maksim on 13.03.2022.
//

import UIKit

final class DesignManager {
    
    let font = "Futura"
    let backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.4470588235, blue: 0.4588235294, alpha: 1)
    let logoName = "pianoLogo"
    let gameBackgroundColor = UIColor.red
    let diePoint = CGPoint(x: 10000, y: 10000)
    
    static let shared = DesignManager()
    
    private init() { }
}
