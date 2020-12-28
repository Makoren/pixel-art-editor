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
        let width = CGFloat(canvasView.gridWidth * 24)
        let height = CGFloat(canvasView.gridHeight * 24)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let img = renderer.image { ctx in
            for node in canvasView.canvasNode.children {
                let shapeNode = node as! SKShapeNode
                ctx.cgContext.setFillColor(shapeNode.fillColor.cgColor)
                ctx.cgContext.setStrokeColor(UIColor.clear.cgColor)
                ctx.cgContext.fill(CGRect(x: shapeNode.position.x, y: shapeNode.position.y, width: 24, height: 24))
            }
        }
        
        // closest I can get to fixing orientation
        let newImage = UIImage(cgImage: img.cgImage!, scale: 1, orientation: .downMirrored)
        let data = UIGraphicsImageRenderer(size: CGSize(width: width, height: height)).pngData { _ in newImage.draw(at: .zero) }
        
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test.png")
        print(filename)
        try? data.write(to: filename)
        print("Successful!")
    }
    
}

