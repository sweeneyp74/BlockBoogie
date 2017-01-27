//
//  OverWorldScene.swift
//  Block Boogie
//
//  Created by Patrick Sweeney on 5/18/16.
//  Copyright © 2016 Patrick Sweeney. All rights reserved.
//
import SpriteKit
import Foundation

//This will act as a template for other scenes
//it will include code for player movement and
class OverWorldScene: SKScene, SKPhysicsContactDelegate
{
    var viewController:GameViewController!
    
    //levels completed count
    var levelsComplete:Int = 0
    var blocksCollected:Int = 0
    
    //------------------------------------------------
    //CategoryBitMask assignments
    let playerCategory:UInt32 =  0x1 << 1
    let level1mask:UInt32 = 0x1 << 2
    let level2mask:UInt32 = 0x1 << 3
    let level3mask:UInt32 = 0x1 << 4
    let level4mask:UInt32 = 0x1 << 5
    let level5mask:UInt32 = 0x1 << 6
    let level6mask:UInt32 = 0x1 << 7
    let level7mask:UInt32 = 0x1 << 8
    let level8mask:UInt32 = 0x1 << 9
    let purplemask:UInt32 = 0x1 << 10
    let level9mask:UInt32 = 0x1 << 11
    let level10mask:UInt32 = 0x1 << 12
    let level11mask:UInt32 = 0x1 << 13
    let level12mask:UInt32 = 0x1 << 14
    let level13mask:UInt32 = 0x1 << 15
    let level14mask:UInt32 = 0x1 << 16
    let level15mask:UInt32 = 0x1 << 17
    let level16mask:UInt32 = 0x1 << 18
    let level17mask:UInt32 = 0x1 << 19
    let level18mask:UInt32 = 0x1 << 20
    let level19mask:UInt32 = 0x1 << 21
    let level20mask:UInt32 = 0x1 << 22
    let level21mask:UInt32 = 0x1 << 23

    //------------------------------------------------
    //global node declarations
    var playerCamera:SKCameraNode = SKCameraNode()
    var playerlabel:SKLabelNode = SKLabelNode()
    var thePlayer:player = player()
    var CheckPoint:checkpoint = checkpoint()
    var deathLabel:SKLabelNode = SKLabelNode()
    
    var redDoor1:SKSpriteNode = SKSpriteNode()
    var redDoor2:SKSpriteNode = SKSpriteNode()
    var redDoor4:SKSpriteNode = SKSpriteNode()
    var redDoor5:SKSpriteNode = SKSpriteNode()
    
    var black1:SKSpriteNode = SKSpriteNode()
    var black2:SKSpriteNode = SKSpriteNode()
    var black3:SKSpriteNode = SKSpriteNode()
    var black4:SKSpriteNode = SKSpriteNode()
    var black5:SKSpriteNode = SKSpriteNode()
    var blackMoreThan5:SKSpriteNode = SKSpriteNode()
    var blackplus9:SKSpriteNode = SKSpriteNode()
    var black11to14:SKSpriteNode = SKSpriteNode()
    var black15:SKSpriteNode = SKSpriteNode()
    
    var purpleblock:SKSpriteNode = SKSpriteNode();
    
    //level nodes
    var level1:SKSpriteNode = SKSpriteNode()
    var level2:SKSpriteNode = SKSpriteNode()
    var level3:SKSpriteNode = SKSpriteNode()
    var level4:SKSpriteNode = SKSpriteNode()
    var level5:SKSpriteNode = SKSpriteNode()
    var level6:SKSpriteNode = SKSpriteNode()
    var level7:SKSpriteNode = SKSpriteNode()
    var level8:SKSpriteNode = SKSpriteNode()
    var level9:SKSpriteNode = SKSpriteNode()
    var level10:SKSpriteNode = SKSpriteNode()
    var level11:SKSpriteNode = SKSpriteNode()
    var level12:SKSpriteNode = SKSpriteNode()
    var level13:SKSpriteNode = SKSpriteNode()
    var level14:SKSpriteNode = SKSpriteNode()
    var level15:SKSpriteNode = SKSpriteNode()
    var level16:SKSpriteNode = SKSpriteNode()
    var level17:SKSpriteNode = SKSpriteNode()
    var level18:SKSpriteNode = SKSpriteNode()
    var level19:SKSpriteNode = SKSpriteNode()
    var level20:SKSpriteNode = SKSpriteNode()
    var level21:SKSpriteNode = SKSpriteNode()
    //------------------------------------------------
    //global booleans (RANDOM)
    let isTutorial: Bool = false
    var isCheckPointActive: Bool = false
    var didtouchpurple: Bool = false
    
    //------------------------------------------------
    //player movement
    let leftForce:CGFloat = -2.0
    let rightForce:CGFloat = 2.0
    var currentjumpForce:CGFloat = 0.0
    
    //var isLeft:Bool = false
    //var isRight:Bool = false
    
    //var isJumping:Bool = false
    var onGround:Bool = false
    var framesInPlace:Int = 0
    var lastYposition:CGFloat = 0.0
    //------------------------------------------------
    //SKACTIONS ++++
    let moveplatform1 = SKAction.moveBy(x: 0, y: 150, duration: 2)
    
    
    //------------------------------------------------
    override func didMove(to view: SKView)
    {
        //viewController.levelNumber = 0;
        //--------------------------------------------------------
        //LOAD SAVED DATA
        //--------------------------------------------------------
        if(UserDefaults.standard.object(forKey: "level1") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level2") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level3") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level4") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level5") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level6") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level7") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level8") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level9") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level10") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level11") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level12") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level13") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level14") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level15") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level16") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level17") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level18") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level19") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level20") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(UserDefaults.standard.object(forKey: "level21") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        
        if(UserDefaults.standard.object(forKey: "block1") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block2") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block3") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block4") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block5") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block6") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block7") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block8") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block9") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block10") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block11") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block12") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block13") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block14") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block15") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block16") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block17") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block18") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block19") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block20") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(UserDefaults.standard.object(forKey: "block21") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        //--------------------------------------------------------
        //Setup gravity in scene//
        self.physicsWorld.gravity = (CGVector(dx: 0, dy: -9.8))
        self.physicsWorld.contactDelegate = self
        //Setup world boundary//
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: 8000, height: 8000))
        
        
        //--------------------------------------------------------
        //NODE SETUP
        //--------------------------------------------------------
        
        //Scene camera
        if let ourCamera:SKCameraNode = self.childNode(withName: "MainCamera") as? SKCameraNode
        {
            playerCamera = ourCamera
            self.camera = playerCamera
            //print("camera check!")
            
        }
        //player
        if let ourPlayer:player = self.childNode(withName: "Player") as? player
        {
            thePlayer = ourPlayer
            thePlayer.physicsBody?.categoryBitMask = playerCategory
            thePlayer.RespawnPoint = thePlayer.position
            //print("player check!")
            
        }
        //Number of levels beat label
        if let numlevelslabel:SKLabelNode = self.childNode(withName: "levelscompletelabel") as? SKLabelNode
        {
            if(levelsComplete <= 9)
            {
            numlevelslabel.text = "0" + String(levelsComplete) + " / 20"
            }
            else if(levelsComplete > 9)
            {
                numlevelslabel.text = String(levelsComplete) + " / 20"
            }
        }
        //Number of purple blocks collected label
        if let numlevelslabel:SKLabelNode = self.childNode(withName: "blockscollectedlabel") as? SKLabelNode
        {
            if(blocksCollected <= 9)
            {
                numlevelslabel.text = "0" + String(blocksCollected) + " / 20"
            }
            else if(blocksCollected > 9)
            {
                numlevelslabel.text = String(blocksCollected) + " / 20"
            }
        }

        /**checkpoint spin
        if let someCP:checkpoint = self.childNodeWithName("CheckPoint") as? checkpoint
        {
         CheckPoint = someCP
         CheckPoint.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(10, duration: 20)))
        }**/
        //welcome label
        if let welcomeLabel:SKLabelNode = self.childNode(withName: "greetingLabel") as? SKLabelNode
        {
            let rando = Int(arc4random_uniform(10) + 1)
            print("message: " + String(rando))
            if (rando == 1)
            {
                welcomeLabel.text = "HINT: COLLECT ALL BLOCKS FOR A BONUS LEVEL"
            }
            if (rando == 2)
            {
                welcomeLabel.text = "KEEP PUSHING, KEEP DYING"
            }
            if (rando == 3)
            {
                welcomeLabel.text = "HOW GOES IT?"
            }
            if (rando == 4)
            {
                welcomeLabel.text = "TIME TO BOOGIE"
            }
            if (rando == 5)
            {
                welcomeLabel.text = "HINT: YOU WILL DIE"
            }
            if (rando == 6)
            {
                welcomeLabel.text = "EMBRACE THE STRUGGLE"
            }
            if (rando == 7)
            {
                welcomeLabel.text = "KEEP CALM AND PLAY ON"
            }
            if (rando == 8)
            {
                welcomeLabel.text = "REMEMBER: YOU ARE AVERAGE AT THIS GAME"
            }
            if (rando == 9)
            {
                welcomeLabel.text = "WELCOME BACK"
            }
            if (rando == 10)
            {
                welcomeLabel.text = "HINT: THERE IS ONE COLLECTIBLE BLOCK ON EACH LEVEL"
            }
            
            if(levelsComplete > 20)
            {
                welcomeLabel.text = "100% Complete! Thanks for playing."

            }
            else if(levelsComplete == 20 && blocksCollected < 20)
            {
                welcomeLabel.text = "Every level complete! Now go find some more purple blocks."

            }
            
        }
        //purple block
        if let pb:SKSpriteNode = self.childNode(withName: "theViewBlock") as? SKSpriteNode
        {
            purpleblock = pb
            purpleblock.physicsBody!.categoryBitMask = purplemask
            purpleblock.physicsBody!.contactTestBitMask = purplemask | playerCategory
            
        }
        //red door1
        if let rd1:SKSpriteNode = self.childNode(withName: "redDoor1") as? SKSpriteNode
        {
            redDoor1 = rd1
            //let moveRight = SKAction.moveByX(100, y: 0, duration: 3)
            let moveUp = SKAction.moveBy(x: 0, y: 150, duration: 2)
            if(levelsComplete >= 0)
            {
                redDoor1.run(moveUp)
            }
        }
        //red door2
        if let rd2:SKSpriteNode = self.childNode(withName: "redDoor2") as? SKSpriteNode
        {
            redDoor2 = rd2
            //let moveLeft = SKAction.moveByX(-100, y: 0, duration: 3)
            let moveUp = SKAction.moveBy(x: 0, y: 150, duration: 2)
            if(levelsComplete >= 10)
            {
                redDoor2.run(moveUp)
            }
        }
        //red door3
        if let rd2:SKSpriteNode = self.childNode(withName: "redDoor3") as? SKSpriteNode
        {
            redDoor2 = rd2
            let moveUp = SKAction.moveBy(x: 0, y: 150, duration: 2)
            if(levelsComplete >= 5)
            {
                redDoor2.run(moveUp)
            }
        }
        //red door4
        if let rd4:SKSpriteNode = self.childNode(withName: "redDoor4") as? SKSpriteNode
        {
            redDoor4 = rd4
            let moveUp = SKAction.moveBy(x: 0, y: 100, duration: 2)
            if(blocksCollected >= 20)
            {
                redDoor4.run(moveUp)
            }
        }
        //red door5
        if let rd5:SKSpriteNode = self.childNode(withName: "redDoor5") as? SKSpriteNode
        {
            redDoor5 = rd5
            let moveUp = SKAction.moveBy(x: 112, y: 0, duration: 2)
            if(levelsComplete >= 20 && blocksCollected >= 20)
            {
                redDoor5.run(moveUp)
            }
        }


        //-------BLACKBLACK---------------------------------------
        //black elevators
        //--------------------------------------------------------
        if let b1:SKSpriteNode = self.childNode(withName: "black1") as? SKSpriteNode
        {
            black1 = b1
            if(levelsComplete >= 0)
            {
            black1.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), moveplatform1, SKAction.wait(forDuration: 2.0), moveplatform1.reversed() ])))
            }
        }
        if let b2:SKSpriteNode = self.childNode(withName: "black2") as? SKSpriteNode
        {
            black2 = b2
            if(levelsComplete >= 1)
            {
                black2.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), moveplatform1, SKAction.wait(forDuration: 2.0), moveplatform1.reversed() ])))
            }
        }
        if let b3:SKSpriteNode = self.childNode(withName: "black3") as? SKSpriteNode
        {
            black3 = b3
            if(levelsComplete >= 2)
            {
                black3.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), moveplatform1, SKAction.wait(forDuration: 2.0), moveplatform1.reversed() ])))
            }
        }
        if let b4:SKSpriteNode = self.childNode(withName: "black4") as? SKSpriteNode
        {
            black4 = b4
            if(levelsComplete >= 3)
            {
                black4.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), moveplatform1, SKAction.wait(forDuration: 2.0), moveplatform1.reversed() ])))
            }
        }
        if let b5:SKSpriteNode = self.childNode(withName: "black5") as? SKSpriteNode
        {
            black5 = b5
            if(levelsComplete >= 4)
            {
                black5.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), moveplatform1, SKAction.wait(forDuration: 2.0), moveplatform1.reversed() ])))
            }
        }
        if let bmore5:SKSpriteNode = self.childNode(withName: "black5plus") as? SKSpriteNode
        {
            blackMoreThan5 = bmore5
            if(levelsComplete >= 5)
            {
                let fiveplusAction = SKAction.moveBy(x: 0, y: -400, duration: 2.5)
                blackMoreThan5.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), fiveplusAction, SKAction.wait(forDuration: 2.0), fiveplusAction.reversed() ])))
            }
        }
        if let bmore9:SKSpriteNode = self.childNode(withName: "black9plus") as? SKSpriteNode
        {
            blackplus9 = bmore9
            if(levelsComplete >= 9)
            {
                let fiveplusAction = SKAction.moveBy(x: 0, y: -195, duration: 1)
                blackplus9.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), fiveplusAction, SKAction.wait(forDuration: 2.0), fiveplusAction.reversed() ])))
            }
        }
        if let bmore10:SKSpriteNode = self.childNode(withName: "black11to14") as? SKSpriteNode
        {
            black11to14 = bmore10
            if(levelsComplete >= 10)
            {
                let fiveplusAction = SKAction.moveBy(x: 0, y: 500, duration: 6)
                black11to14.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), fiveplusAction, SKAction.wait(forDuration: 2.0), fiveplusAction.reversed() ])))
            }
        }
        if let b15:SKSpriteNode = self.childNode(withName: "black15") as? SKSpriteNode
        {
            black15 = b15
            if(levelsComplete >= 14)
            {
                let fiveteenAction = SKAction.moveBy(x: 0, y: 451, duration: 4)
                black15.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 2.0), fiveteenAction, SKAction.wait(forDuration: 2.0), fiveteenAction.reversed() ])))
            }
        }
        //--------------------------------------------------------
        //YELLOW 15+ moving blocks
        //--------------------------------------------------------
        if let y1:SKSpriteNode = self.childNode(withName: "yellow1") as? SKSpriteNode
        {
            
            if(levelsComplete >= 15)
            {
                let yAction = SKAction.moveBy(x: 0, y: -125, duration: 4)
                y1.run(SKAction.sequence([ SKAction.wait(forDuration: 2.0), yAction ]))
            }
        }
        if let y2:SKSpriteNode = self.childNode(withName: "yellow2") as? SKSpriteNode
        {
            
            if(levelsComplete >= 15)
            {
                let yAction = SKAction.moveBy(x: 0, y: -80, duration: 4)
                y2.run(SKAction.sequence([ SKAction.wait(forDuration: 1.5), yAction ]))

            }
        }
        if let y3:SKSpriteNode = self.childNode(withName: "yellow3") as? SKSpriteNode
        {
            
            if(levelsComplete >= 15)
            {
                let yAction = SKAction.moveBy(x: 0, y: -40, duration: 4)
                y3.run(SKAction.sequence([ SKAction.wait(forDuration: 1.0), yAction ]))

            }
        }
        if let y4:SKSpriteNode = self.childNode(withName: "yellow4") as? SKSpriteNode
        {
            
            if(levelsComplete >= 17)
            {
                let yAction = SKAction.moveBy(x: -525, y: 0, duration: 4)
                y4.run(SKAction.sequence([ SKAction.wait(forDuration: 10.0), yAction ]))
                
            }
        }
        if let y5:SKSpriteNode = self.childNode(withName: "yellow5") as? SKSpriteNode
        {
            
            if(levelsComplete >= 18)
            {
                let yAction = SKAction.moveBy(x: -700, y: 0, duration: 4)
                y5.run(SKAction.sequence([ SKAction.wait(forDuration: 12.0), yAction ]))
                
            }
        }



        
        
        //----------------------------------------------------------
        //death message
        if let theDeathLabel:SKLabelNode = self.childNode(withName: "deathlabel") as? SKLabelNode
        {
            deathLabel = theDeathLabel
            deathLabel.isHidden = true
        }
        
        //--------------------------------------------------------
        //LEVEL NODE SETUP
        //--------------------------------------------------------
        if let l1:SKSpriteNode = self.childNode(withName: "level1") as? SKSpriteNode
        {
            level1 = l1
            level1.physicsBody!.categoryBitMask = level1mask
            level1.physicsBody!.contactTestBitMask = level1mask | playerCategory
            
            if(UserDefaults.standard.object(forKey: "level1") != nil)
            {
                level1.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block1") != nil)
                {
                    level1.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
    
            }

        }
        if let l2:SKSpriteNode = self.childNode(withName: "level2") as? SKSpriteNode
        {
            level2 = l2
            level2.physicsBody!.categoryBitMask = level2mask
            level2.physicsBody!.contactTestBitMask = level2mask | playerCategory
            
            if(UserDefaults.standard.object(forKey: "level2") != nil)
            {
                level2.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block2") != nil)
                {
                    level2.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }
            
        }
        if let l3:SKSpriteNode = self.childNode(withName: "level3") as? SKSpriteNode
        {
            level3 = l3
            level3.physicsBody!.categoryBitMask = level3mask
            level3.physicsBody!.contactTestBitMask = level3mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level3") != nil)
            {
                level3.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block3") != nil)
                {
                    level3.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l4:SKSpriteNode = self.childNode(withName: "level4") as? SKSpriteNode
        {
            level4 = l4
            level4.physicsBody!.categoryBitMask = level4mask
            level4.physicsBody!.contactTestBitMask = level4mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level4") != nil)
            {
                level4.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block4") != nil)
                {
                    level4.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l5:SKSpriteNode = self.childNode(withName: "level5") as? SKSpriteNode
        {
            level5 = l5
            level5.physicsBody!.categoryBitMask = level5mask
            level5.physicsBody!.contactTestBitMask = level5mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level5") != nil)
            {
                level5.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block5") != nil)
                {
                    level5.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l6:SKSpriteNode = self.childNode(withName: "level6") as? SKSpriteNode
        {
            level6 = l6
            level6.physicsBody!.categoryBitMask = level6mask
            level6.physicsBody!.contactTestBitMask = level6mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level6") != nil)
            {
                level6.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block6") != nil)
                {
                    level6.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l7:SKSpriteNode = self.childNode(withName: "level7") as? SKSpriteNode
        {
            level7 = l7
            level7.physicsBody!.categoryBitMask = level7mask
            level7.physicsBody!.contactTestBitMask = level7mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level7") != nil)
            {
                level7.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block7") != nil)
                {
                    level7.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l8:SKSpriteNode = self.childNode(withName: "level8") as? SKSpriteNode
        {
            level8 = l8
            level8.physicsBody!.categoryBitMask = level8mask
            level8.physicsBody!.contactTestBitMask = level8mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level8") != nil)
            {
                level8.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block8") != nil)
                {
                    level8.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l9:SKSpriteNode = self.childNode(withName: "level9") as? SKSpriteNode
        {
            level9 = l9
            level9.physicsBody!.categoryBitMask = level9mask
            level9.physicsBody!.contactTestBitMask = level9mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level9") != nil)
            {
                level9.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block9") != nil)
                {
                    level9.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l10:SKSpriteNode = self.childNode(withName: "level10") as? SKSpriteNode
        {
            level10 = l10
            level10.physicsBody!.categoryBitMask = level10mask
            level10.physicsBody!.contactTestBitMask = level10mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level10") != nil)
            {
                level10.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block10") != nil)
                {
                    level10.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l11:SKSpriteNode = self.childNode(withName: "level11") as? SKSpriteNode
        {
            level11 = l11
            level11.physicsBody!.categoryBitMask = level11mask
            level11.physicsBody!.contactTestBitMask = level11mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level11") != nil)
            {
                level11.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block11") != nil)
                {
                    level11.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l12:SKSpriteNode = self.childNode(withName: "level12") as? SKSpriteNode
        {
            level12 = l12
            level12.physicsBody!.categoryBitMask = level12mask
            level12.physicsBody!.contactTestBitMask = level12mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level12") != nil)
            {
                level12.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block12") != nil)
                {
                    level12.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l13:SKSpriteNode = self.childNode(withName: "level13") as? SKSpriteNode
        {
            level13 = l13
            level13.physicsBody!.categoryBitMask = level13mask
            level13.physicsBody!.contactTestBitMask = level13mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level13") != nil)
            {
                level13.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block13") != nil)
                {
                    level13.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l14:SKSpriteNode = self.childNode(withName: "level14") as? SKSpriteNode
        {
            level14 = l14
            level14.physicsBody!.categoryBitMask = level14mask
            level14.physicsBody!.contactTestBitMask = level14mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level14") != nil)
            {
                level14.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block14") != nil)
                {
                    level14.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l15:SKSpriteNode = self.childNode(withName: "level15") as? SKSpriteNode
        {
            level15 = l15
            level15.physicsBody!.categoryBitMask = level15mask
            level15.physicsBody!.contactTestBitMask = level15mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level15") != nil)
            {
                level15.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block15") != nil)
                {
                    level15.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l16:SKSpriteNode = self.childNode(withName: "level16") as? SKSpriteNode
        {
            level16 = l16
            level16.physicsBody!.categoryBitMask = level16mask
            level16.physicsBody!.contactTestBitMask = level16mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level16") != nil)
            {
                level16.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block16") != nil)
                {
                    level16.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l17:SKSpriteNode = self.childNode(withName: "level17") as? SKSpriteNode
        {
            level17 = l17
            level17.physicsBody!.categoryBitMask = level17mask
            level17.physicsBody!.contactTestBitMask = level17mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level17") != nil)
            {
                level17.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block17") != nil)
                {
                    level17.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l18:SKSpriteNode = self.childNode(withName: "level18") as? SKSpriteNode
        {
            level18 = l18
            level18.physicsBody!.categoryBitMask = level18mask
            level18.physicsBody!.contactTestBitMask = level18mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level18") != nil)
            {
                level18.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block18") != nil)
                {
                    level18.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }

        }
        if let l19:SKSpriteNode = self.childNode(withName: "level19") as? SKSpriteNode
        {
            level19 = l19
            level19.physicsBody!.categoryBitMask = level19mask
            level19.physicsBody!.contactTestBitMask = level19mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level19") != nil)
            {
                level19.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block19") != nil)
                {
                    level19.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }
            
        }
        if let l20:SKSpriteNode = self.childNode(withName: "level20") as? SKSpriteNode
        {
            level20 = l20
            level20.physicsBody!.categoryBitMask = level20mask
            level20.physicsBody!.contactTestBitMask = level20mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level20") != nil)
            {
                level20.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block20") != nil)
                {
                    level20.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }
            
        }
        if let l21:SKSpriteNode = self.childNode(withName: "level21") as? SKSpriteNode
        {
            level21 = l21
            level21.physicsBody!.categoryBitMask = level21mask
            level21.physicsBody!.contactTestBitMask = level21mask | playerCategory
            if(UserDefaults.standard.object(forKey: "level21") != nil)
            {
                level21.color = UIColor(red:1.0, green:0.40, blue:0.0, alpha:1.0)
                
                if(UserDefaults.standard.object(forKey: "block21") != nil)
                {
                    level21.color = UIColor(red:0.15, green:0.9, blue:0.15, alpha:1.0)
                }
                
            }
            
        }



        

        //--------------------------------------------------------
        //NODE SETUP END
        //--------------------------------------------------------
        
        
        
    }
    
    //special collision detection
    func didBegin(_ contact: SKPhysicsContact)
    {
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == purplemask)) || ((contact.bodyA.categoryBitMask == purplemask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if(didtouchpurple == false)
            {
            didtouchpurple = true
            let move: SKAction = SKAction.moveBy(x: 0, y: 900, duration: TimeInterval(5.0))
            purpleblock.run(SKAction.repeatForever(SKAction.sequence([move, SKAction.wait(forDuration: 2.0), move.reversed(), SKAction.wait(forDuration: 2.0)])))
            playerCamera.run(SKAction.sequence([ SKAction.scale(to: 1.0, duration: 3.0), SKAction.scale(to: 0.15, duration: 1)]))
            }
            
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level1mask)) || ((contact.bodyA.categoryBitMask == level1mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 1
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level2mask)) || ((contact.bodyA.categoryBitMask == level2mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 2
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level3mask)) || ((contact.bodyA.categoryBitMask == level3mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 3
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level4mask)) || ((contact.bodyA.categoryBitMask == level4mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 4
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level5mask)) || ((contact.bodyA.categoryBitMask == level5mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 5
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level6mask)) || ((contact.bodyA.categoryBitMask == level6mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 6
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level7mask)) || ((contact.bodyA.categoryBitMask == level7mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 7
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level8mask)) || ((contact.bodyA.categoryBitMask == level8mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 8
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level9mask)) || ((contact.bodyA.categoryBitMask == level9mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 9
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level10mask)) || ((contact.bodyA.categoryBitMask == level10mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 10
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level11mask)) || ((contact.bodyA.categoryBitMask == level11mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 11
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level12mask)) || ((contact.bodyA.categoryBitMask == level12mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 12
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level13mask)) || ((contact.bodyA.categoryBitMask == level13mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 13
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level14mask)) || ((contact.bodyA.categoryBitMask == level14mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 14
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level15mask)) || ((contact.bodyA.categoryBitMask == level15mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 15
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level16mask)) || ((contact.bodyA.categoryBitMask == level16mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 16
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level17mask)) || ((contact.bodyA.categoryBitMask == level17mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 17
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level18mask)) || ((contact.bodyA.categoryBitMask == level18mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 18
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level19mask)) || ((contact.bodyA.categoryBitMask == level19mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 19
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level20mask)) || ((contact.bodyA.categoryBitMask == level20mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 20
            viewController.switchToLevel()
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == level21mask)) || ((contact.bodyA.categoryBitMask == level21mask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            viewController.levelNumber = 21
            viewController.switchToLevel()
        }





    }
    
    //contact ends between two nodes!
    func didEnd(_ contact: SKPhysicsContact)
    {
        
    }
    
    //----------------------------------------------------
    //helper functions for speical condition collisions
    //----------------------------------------------------
    //end of level sequence
    
    func hideDeathText()
    {
        deathLabel.isHidden = true
    }
    
    //respawn player at current respawn point
    func respawnPlayer()
    {
        thePlayer.position = thePlayer.RespawnPoint
        
        self.addChild(thePlayer)
    }
    
    //Creates four splintering blocks upon death
    func deathAnimation(_ playerVelocity: CGVector, playerPosition: CGPoint)
    {
        
        thePlayer.removeFromParent()
        
        let block1 = SKSpriteNode()
        block1.size = CGSize(width: 25, height: 25)
        block1.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block1.position = playerPosition
        block1.physicsBody = SKPhysicsBody(rectangleOf: block1.size)
        block1.physicsBody!.velocity = playerVelocity
        block1.physicsBody!.restitution = CGFloat(0.5)
        
        let block2 = SKSpriteNode()
        block2.size = CGSize(width: 25, height: 25)
        block2.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block2.position = CGPoint(x: (playerPosition.x + 25.0), y: (playerPosition.y - 25.0))
        block2.physicsBody = SKPhysicsBody(rectangleOf: block1.size)
        block2.physicsBody!.velocity = playerVelocity
        block2.physicsBody!.restitution = CGFloat(0.5)
        
        let block3 = SKSpriteNode()
        block3.size = CGSize(width: 25, height: 25)
        block3.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block3.position = CGPoint(x: (playerPosition.x), y: (playerPosition.y - 25.0))
        block3.physicsBody = SKPhysicsBody(rectangleOf: block1.size)
        block3.physicsBody!.velocity = playerVelocity
        block3.physicsBody!.restitution = CGFloat(0.5)
        
        let block4 = SKSpriteNode()
        block4.size = CGSize(width: 25, height: 25)
        block4.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block4.position = CGPoint(x: (playerPosition.x + 25.0), y: (playerPosition.y))
        block4.physicsBody = SKPhysicsBody(rectangleOf: block1.size)
        block4.physicsBody!.velocity = playerVelocity
        block4.physicsBody!.restitution = CGFloat(0.5)
        
        self.addChild(block1)
        self.addChild(block2)
        self.addChild(block3)
        self.addChild(block4)
        
    }
    
    
    //------------------------------------------------
    //UPDATE <><><>
    //------------------------------------------------
    override func update(_ currentTime: TimeInterval)
    {
        //-------------------------------------------------
        //camera follow the player
        playerCamera.position = CGPoint(x: thePlayer.position.x, y: thePlayer.position.y + 150)
        //playerlabel.position = CGPointMake(thePlayer.position.x, thePlayer.position.y)
        thePlayer.physicsBody?.restitution = 0.0
        //-------------------------------------------------
        //player jump handling
        onGround = false
        currentjumpForce = 0.0
        
        if(thePlayer.position.y == lastYposition)
        {
            framesInPlace = framesInPlace + 1
        }
        else
        {
            framesInPlace = 0
        }
        
        lastYposition = thePlayer.position.y
        
        if(framesInPlace >= 1)
        {
            onGround = true
            framesInPlace = 1
            //print("onground")
            if(viewController.areControllsOn == true)
            {
                //print("ready to jump")
                viewController.JumpButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)
            }
        }
        else
        {
            if(viewController.areControllsOn == true)
            {
                //print("ready to jump")
                viewController.JumpButton.backgroundColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
            }
            
        }

        
        
        if(viewController.isJumping == true && onGround == true)
        {
            currentjumpForce = 70.0
            viewController.isJumping = false
            //print("jump")
            viewController.JumpButton.backgroundColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)

        }
        viewController.isJumping = false
        //-------------------------------------------------
        //left and right handling
        if(viewController.isLeft == true)
        {
            thePlayer.physicsBody?.applyImpulse(CGVector(dx: leftForce, dy: currentjumpForce))
            
        }
        else if(viewController.isRight == true)
        {
            thePlayer.physicsBody?.applyImpulse(CGVector(dx: rightForce, dy: currentjumpForce))
            
        }
        else
        {
            thePlayer.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: currentjumpForce))
            
        }
        //-------------------------------------------------
        if(viewController.isRespawning == true)
        {
            viewController.isRespawning = false
            
            print("death")
            deathLabel.position = thePlayer.position
            deathLabel.isHidden = false
            deathAnimation(thePlayer.physicsBody!.velocity, playerPosition:  thePlayer.position)
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(respawnPlayer)]))
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(hideDeathText)]))

        }
    }
    
    
}
