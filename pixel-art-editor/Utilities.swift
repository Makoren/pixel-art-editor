//
//  Utilities.swift
//  pixel-art-editor
//
//  Created by Luke Lazzaro on 28/12/20.
//

import Foundation
import SpriteKit

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat(arc4random()) / CGFloat(UInt32.max),
            green: CGFloat(arc4random()) / CGFloat(UInt32.max),
            blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
            alpha: 1
        )
    }
}
