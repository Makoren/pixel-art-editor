//
//  Pencil.swift
//  pixel-art-editor
//
//  Created by Luke Lazzaro on 30/12/20.
//

import SpriteKit

class Pencil: NSObject, UIColorPickerViewControllerDelegate {
    let canvas: Canvas
    var color: UIColor = .black
    
    init(canvas: Canvas) {
        self.canvas = canvas
    }
    
    func drawPixel(at row: Int, _ col: Int) {
        // ensure you don't try to get an index that's out of range
        if col < 0 || col > canvas.gridWidth - 1 { return }
        if row < 0 || row > canvas.gridHeight - 1 { return }
        
        // I'm accessing the canvas node's children rather than making a separate array because I'm certain there are only going to be shape nodes here. I feel there's no need for another array storing the same data.
        guard let node = canvas.canvasNode.children[row * canvas.gridWidth + col] as? SKShapeNode else {
            print("No shape node to draw to.")
            return
        }
        node.fillColor = color
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        color = viewController.selectedColor
    }
}
