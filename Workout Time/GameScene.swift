//
//  GameScene.swift
//  Workout Time
//
//  Created by Marko Šplajt on 02/01/2019.
//  Copyright © 2019 MarkoSplajt. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom

var muteButton = SKSpriteNode()

class GameScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if muteButton.contains(location) {
                
                if self.isPaused == false {
                    self.isPaused = true
                    backingAudio.stop()
                    muteButton.texture = SKTexture(imageNamed: "mute")
                    
                } else if self.isPaused == true {
                    
                    self.isPaused = false
                    backingAudio.play()
                    muteButton.texture = SKTexture(imageNamed: "unMute")
                }
            }
        }
    }
    
    func createMuteButton()
    {
        muteButton = SKSpriteNode(imageNamed: "unMute")
        
        switch  (deviceIdiom) {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                muteButton.size = CGSize(width: 45, height: 45)
                muteButton.position = CGPoint(x: 60, y: 130)
                
            case 321...375: // iPhone 6, 7, 8
                muteButton.size = CGSize(width: 50, height: 50)
                muteButton.position = CGPoint(x: 65, y: 140)
                
            case 376...414: // iPhone 6+, 7+, 8+
                muteButton.size = CGSize(width: 60, height: 60)
                muteButton.position = CGPoint(x: 70, y: 155)
                
            default:
                break
            }
        default:
            break
        }
        
        if UIDevice().userInterfaceIdiom == .phone // iPhone X
        {
            switch UIScreen.main.nativeBounds.height
            {
                
            case 1792: // iPhone XR
                muteButton.size = CGSize(width: 60, height: 60)
                muteButton.position = CGPoint(x: 70, y: 200)
                
            case 2436: // iPhone X, Xs
                muteButton.size = CGSize(width: 55, height: 55)
                muteButton.position = CGPoint(x: 65, y: 180)
                
            case 2688: // iPhone Xs Max
                muteButton.size = CGSize(width: 60, height: 60)
                muteButton.position = CGPoint(x: 70, y: 200)
                
            default:
                print("unknown")
            }
        }
        
        muteButton.zPosition = 10
        self.addChild(muteButton)
    }
    
    override func didMove(to view: SKView) {
        createMuteButton()
    }
}
