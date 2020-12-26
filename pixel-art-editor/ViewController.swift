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
        
        guard let skView = self.view as? SKView,
              let scene = SKScene(fileNamed: "Canvas") else {
            fatalError("what")
        }
        
        scene.scaleMode = .aspectFill
        
        let grid = drawGridLines()
        grid.position = CGPoint(x: -100, y: -100)   // use a camera to move around the scene instead of this
        scene.addChild(grid)
        
        skView.presentScene(scene)
    }

    func drawGridLines() -> SKShapeNode {
        let gridWidth = 8
        let gridHeight = 6
        let cellSize = 24
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addRect(CGRect(x: 0, y: 0, width: cellSize * gridWidth, height: cellSize * gridHeight))
        
        for row in 1 ..< gridHeight {
            path.move(to: CGPoint(x: 0, y: row * cellSize))
            path.addLine(to: CGPoint(x: cellSize * gridWidth, y: row * cellSize))
        }
        
        for col in 1 ..< gridWidth {
            path.move(to: CGPoint(x: col * cellSize, y: 0))
            path.addLine(to: CGPoint(x: col * cellSize, y: cellSize * gridHeight))
        }
        
        let shape = SKShapeNode()
        shape.path = path
        return shape
    }

}

