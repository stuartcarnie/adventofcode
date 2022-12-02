//
//  GameScene.swift
//  Intcode
//
//  Created by Stuart Carnie on 12/16/19.
//  Copyright © 2019 Stuart Carnie. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var tileMap: SKTileMapNode?
    private var tileSet: SKTileSet?
    private var tileGroup: SKTileGroup?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.tileMap = childNode(withName: "//tileMap") as? SKTileMapNode
        if let tileMap = self.tileMap {
            tileMap.alpha = 0.0
            tileMap.run(.fadeIn(withDuration: 2.0))
        }
        
        self.tileSet = SKTileSet(named: "Block Tile Set")
        if let tileSet = self.tileSet {
            tileGroup = tileSet.defaultTileGroup
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let row = tileMap!.tileRowIndex(fromPosition: pos)
        let col = tileMap!.tileColumnIndex(fromPosition: pos)
        
        if col >= tileMap!.numberOfColumns {
            tileMap!.numberOfColumns = col + 1
        }
        
        tileMap!.setTileGroup(tileGroup, forColumn: col, row: row)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let row = tileMap!.tileRowIndex(fromPosition: pos)
        let col = tileMap!.tileColumnIndex(fromPosition: pos)
        if col >= tileMap!.numberOfColumns {
            tileMap!.numberOfColumns = col + 1
        }
        
        tileMap!.setTileGroup(tileGroup, forColumn: col, row: row)
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
