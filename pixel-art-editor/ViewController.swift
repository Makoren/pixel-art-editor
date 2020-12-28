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
        // create CGContext somehow
        // loop over canvas children to get each shape node and stitch them together in the context
        // turn the context into an image
        // convert the image into PNG data and write it to a file
        
        let width = CGFloat(canvasView.gridWidth * canvasView.cellSize)
        let height = CGFloat(canvasView.gridHeight * canvasView.cellSize)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let img = renderer.image { ctx in
            for node in canvasView.canvasNode.children {
                let shapeNode = node as! SKShapeNode
                
                let renderer2 = UIGraphicsImageRenderer(size: CGSize(width: CGFloat(canvasView.cellSize), height: CGFloat(canvasView.cellSize)))
                let shapeImage = renderer2.image { ctx2 in
                    ctx.cgContext.setFillColor(shapeNode.fillColor.cgColor)
                    ctx.cgContext.fill(CGRect(x: shapeNode.position.x, y: shapeNode.position.y, width: CGFloat(canvasView.cellSize), height: CGFloat(canvasView.cellSize)))
                }
                print(shapeNode.position)
                shapeImage.draw(at: CGPoint())
            }
        }
        testImageView.image = img
    }
    
}

