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
        let width = CGFloat(canvasView.gridWidth)
        let height = CGFloat(canvasView.gridHeight)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width / 2, height: height / 2))
        
        let img = renderer.image { ctx in
            for node in canvasView.canvasNode.children {
                let shapeNode = node as! SKShapeNode
                ctx.cgContext.setFillColor(shapeNode.fillColor.cgColor)
                ctx.cgContext.setStrokeColor(UIColor.clear.cgColor)
                ctx.cgContext.fill(CGRect(x: (shapeNode.position.x / CGFloat(canvasView.cellSize)) / 2,
                                          y: (shapeNode.position.y / CGFloat(canvasView.cellSize)) / 2,
                                          width: 0.5, height: 0.5))
            }
        }

        let newImage = UIImage(cgImage: img.cgImage!, scale: 2, orientation: .downMirrored)
        let data = UIGraphicsImageRenderer(size: CGSize(width: width / 2, height: height / 2)).pngData { _ in newImage.draw(at: .zero) }
        
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test.png")
        print(filename)
        try? data.write(to: filename)
        print("Successful!")
    }
    
}

