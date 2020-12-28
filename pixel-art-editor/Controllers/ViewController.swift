//
//  ViewController.swift
//  pixel-art-editor
//
//  Created by Luke Lazzaro on 27/12/20.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet var canvasView: Canvas!
    @IBOutlet weak var testImageView: UIImageView!
    
    @IBAction func exportButtonPressed(_ sender: Any) {
        let width = CGFloat(canvasView.gridWidth * canvasView.cellSize)
        let height = CGFloat(canvasView.gridHeight * canvasView.cellSize)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let data = renderer.pngData { ctx in
            for node in canvasView.canvasNode.children {
                let shapeNode = node as! SKShapeNode
                ctx.cgContext.setFillColor(shapeNode.fillColor.cgColor)
                ctx.cgContext.setStrokeColor(UIColor.clear.cgColor)
                ctx.cgContext.fill(CGRect(x: shapeNode.position.x, y: shapeNode.position.y, width: CGFloat(canvasView.cellSize), height: CGFloat(canvasView.cellSize)))
            }
        }
        
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test.png")
        print(filename)
        try? data.write(to: filename)
        print("Successful!")
    }
    
}

