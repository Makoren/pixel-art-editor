//
//  Canvas.swift
//  pixel-art-editor
//
//  Created by Luke Lazzaro on 27/12/20.
//

import SpriteKit

class Canvas: SKView {

    let skScene: SKScene
    let grid: SKShapeNode
    let canvasNode: SKNode
    
    let gridWidth: Int = 8
    let gridHeight: Int = 6
    let cellSize: Int = 24
    var cells: [[Pixel]]
    
    required init?(coder: NSCoder) {
        guard let newScene = SKScene(fileNamed: "Canvas") else {
            fatalError("Could not load canvas!")
        }
        skScene = newScene
        grid = SKShapeNode()
        canvasNode = skScene.childNode(withName: "Canvas")!
        
        let row = Array(repeating: Pixel(color: .red, rowPos: 0, colPos: 0), count: gridHeight)
        cells = Array(repeating: row, count: gridWidth)
        
        // initialize properties before this
        super.init(coder: coder)
        
        skScene.scaleMode = .aspectFill
        
        grid.path = drawGridLines()
        skScene.addChild(grid)
        
        drawPixels()
        
        presentScene(skScene)
    }
    
    func drawGridLines() -> CGPath {        
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
        
        return path
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPos = touches.first!.location(in: grid)
        // Get the cell index
        let col = Int(touchPos.x / CGFloat(cellSize))
        let row = Int(touchPos.y / CGFloat(cellSize))
        cells[col][row].color = .blue
        cells[col][row].rowPos = row
        cells[col][row].colPos = col
        drawPixels()
    }
    
    func drawPixels() {
        for row in 0 ..< gridHeight {
            for col in 0 ..< gridWidth {
                let node = SKShapeNode(rect: CGRect(x: CGFloat(col) * CGFloat(cellSize),
                                                    y: CGFloat(row) * CGFloat(cellSize),
                                                    width: CGFloat(cellSize), height: CGFloat(cellSize)))
                node.strokeColor = .clear
                node.fillColor = cells[col][row].color
                canvasNode.addChild(node)
            }
        }
    }
    
}
