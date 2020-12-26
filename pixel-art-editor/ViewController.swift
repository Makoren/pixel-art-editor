//
//  ViewController.swift
//  pixel-art-editor
//
//  Created by Luke Lazzaro on 27/12/20.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let skView = self.view as? SKView else {
            fatalError("Could not load canvas")
        }
        
        let canvas = Canvas()
        canvas.scene.scaleMode = .aspectFill
        skView.presentScene(canvas.scene)
    }

}

