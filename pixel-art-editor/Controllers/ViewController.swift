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
    @IBOutlet weak var widthStepper: UIStepper!
    @IBOutlet weak var heightStepper: UIStepper!
    
    var exportedData: Data?
    
    override func viewDidLoad() {
        canvasView.gridWidth = Int(widthStepper.value)
        canvasView.gridHeight = Int(heightStepper.value)
        canvasView.initPixels()
        canvasView.drawGridLines()
    }
    
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
        exportedData = UIGraphicsImageRenderer(size: CGSize(width: width / 2, height: height / 2)).pngData { _ in newImage.draw(at: .zero) }
        
        // save data to a temporary URL, then save that URL somewhere in Files
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("test.png")
        do {
            try exportedData!.write(to: url)
        } catch {
            print("error saving image data")
        }
        
        let dpvc = UIDocumentPickerViewController(forExporting: [url])
        show(dpvc, sender: self)
    }
    
    @IBAction func canvasWidthChanged(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            //canvasView.redrawCanvas(width: Int(stepper.value), height: canvasView.gridHeight)
            canvasView.gridWidth = Int(stepper.value)
            canvasView.initPixels()
            canvasView.drawGridLines()
        } else {
            print("Not a stepper!")
        }
    }
    
    @IBAction func canvasHeightChanged(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            //canvasView.redrawCanvas(width: canvasView.gridWidth, height: Int(stepper.value))
            canvasView.gridHeight = Int(stepper.value)
            canvasView.initPixels()
            canvasView.drawGridLines()
        } else {
            print("Not a stepper!")
        }
    }
    
    @IBAction func pencilButtonPressed(_ sender: Any) {
        let cpvc = UIColorPickerViewController()
        cpvc.delegate = canvasView.pencil!
        cpvc.selectedColor = canvasView.pencil!.color
        cpvc.modalPresentationStyle = .fullScreen
        show(cpvc, sender: self)
    }
    
    @IBAction func eraserButtonPressed(_ sender: Any) {
        canvasView.pencil!.color = .clear
    }
}

