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
    let viewController: ViewController
    var pencil: Pencil?
    
    var gridWidth: Int = 8
    var gridHeight: Int = 6
    let cellSize: Int = 24
    
    required init?(coder: NSCoder) {
        guard let newScene = SKScene(fileNamed: "Canvas") else {
            fatalError("Could not load canvas!")
        }
        
        viewController = UIApplication.shared.windows.first!.rootViewController as! ViewController
        skScene = newScene
        skScene.scaleMode = .aspectFill
        grid = SKShapeNode()
        canvasNode = skScene.childNode(withName: "Canvas")!
        
        // initialize properties before this
        super.init(coder: coder)
        
        // this needed to be optional since it needed to be initialised before super.init,
        // but I couldn't pass self before super.init. this should be safe to always force unwrap.
        pencil = Pencil(canvas: self)
        
        initPixels()
        drawGridLines()
        
        skScene.addChild(grid)
        presentScene(skScene)
    }
    
    func drawGridLines() {
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
        
        grid.path = path
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    func handleTouches(_ touches: Set<UITouch>) {
        let touchPos = touches.first!.location(in: grid)
        // Get the cell index
        let col = Int(touchPos.x / CGFloat(cellSize))
        let row = Int(touchPos.y / CGFloat(cellSize))
        
        pencil!.drawPixel(at: row, col)
    }
    
    func initPixels() {
        canvasNode.removeAllChildren()
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
    
    
    
    func redrawCanvas(width newWidth: Int, height newHeight: Int) {
        // get pixels from canvas
        // cut out nodes that are outside the new canvas bounds somehow
        // loop over array to redraw the remaining pixels
        
        // this function has the stepper values passed in
        
        // if the width changed, increase or decrease grid width
        if newWidth < gridWidth {
            for row in 0 ..< gridHeight {
                let node = canvasNode.children[gridWidth * row]
                node.removeFromParent()
            }
        }
        
//        if newHeight < gridHeight {
//            for row in 0 ..< gridHeight {
//                let node = canvasNode.children[gridWidth * row - 1]
//                node.removeFromParent()
//            }
//        }
        
        gridWidth = newWidth
        gridHeight = newHeight
    }
    
}
