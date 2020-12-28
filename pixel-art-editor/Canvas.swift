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
    
    required init?(coder: NSCoder) {
        guard let newScene = SKScene(fileNamed: "Canvas") else {
            fatalError("Could not load canvas!")
        }
        skScene = newScene
        grid = SKShapeNode()
        canvasNode = skScene.childNode(withName: "Canvas")!
        
        // initialize properties before this
        super.init(coder: coder)
        
        initPixels()
        //drawRandomPixels()
        
        skScene.scaleMode = .aspectFill
        
        grid.path = drawGridLines()
        skScene.addChild(grid)
        
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
        drawPixel(at: row, col)
    }
    
    func initPixels() {
        for row in 0 ..< gridHeight {
            for col in 0 ..< gridWidth {
                let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: CGFloat(cellSize), height: CGFloat(cellSize)))
                node.position.x = CGFloat(col * cellSize)
                node.position.y = CGFloat(row * cellSize)
                node.fillColor = .clear
                node.strokeColor = .clear
                canvasNode.addChild(node)
            }
        }
    }
    
    func drawPixel(at row: Int, _ col: Int) {
        // I'm accessing the canvas node's children rather than making a separate array because I'm certain there are only going to be shape nodes here. I feel there's no need for another array storing the same data.
        guard let node = canvasNode.children[row * gridWidth + col] as? SKShapeNode else {
            print("No shape node to draw to.")
            return
        }
        node.fillColor = .blue
    }
    
    // debugging function
    func drawRandomPixels() {
        for node in canvasNode.children {
            guard let shapeNode = node as? SKShapeNode else {
                print("Current node is not a shape node: \(node)")
                continue
            }
            shapeNode.fillColor = .randomColor()
        }
    }
    
}
