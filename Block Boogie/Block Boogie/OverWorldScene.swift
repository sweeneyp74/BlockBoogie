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
    var levelsComplete:Int = 20
    var blocksCollected:Int = 20
    
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
    let moveplatform1 = SKAction.moveByX(0, y: 150, duration: 2)
    
    
    //------------------------------------------------
    override func didMoveToView(view: SKView)
    {
        //--------------------------------------------------------
        //LOAD SAVED DATA
        //--------------------------------------------------------
        if(NSUserDefaults.standardUserDefaults().objectForKey("level1") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level2") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level3") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level4") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level5") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level6") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level7") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level8") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level9") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level10") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level11") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level12") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level13") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level14") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level15") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level16") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level17") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level18") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level19") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("level20") != nil)
        {
            levelsComplete = levelsComplete + 1
        }
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("block1") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block2") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block3") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block4") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block5") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block6") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block7") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block8") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block9") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block10") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block11") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block12") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block13") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block14") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block15") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block16") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block17") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block18") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block19") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block20") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("block21") != nil)
        {
            blocksCollected = blocksCollected + 1
        }
        //--------------------------------------------------------
        //Setup gravity in scene//
        self.physicsWorld.gravity = (CGVectorMake(0, -9.8))
        self.physicsWorld.contactDelegate = self
        //Setup world boundary//
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: 8000, height: 8000))
        
        
        //--------------------------------------------------------
        //NODE SETUP
        //--------------------------------------------------------
        
        //Scene camera
        if let ourCamera:SKCameraNode = self.childNodeWithName("MainCamera") as? SKCameraNode
        {
            playerCamera = ourCamera
            self.camera = playerCamera
            //print("camera check!")
            
        }
        //player
        if let ourPlayer:player = self.childNodeWithName("Player") as? player
        {
            thePlayer = ourPlayer
            thePlayer.physicsBody?.categoryBitMask = playerCategory
            thePlayer.RespawnPoint = thePlayer.position
            //print("player check!")
            
        }
        //Number of levels beat label
        if let numlevelslabel:SKLabelNode = self.childNodeWithName("levelscompletelabel") as? SKLabelNode
        {
            if(levelsComplete <= 9)
            {
            numlevelslabel.text = "0" + String(levelsComplete) + " / 21"
            }
            else if(levelsComplete > 9)
            {
                numlevelslabel.text = String(levelsComplete) + " / 21"
            }
        }
        //Number of purple blocks collected label
        if let numlevelslabel:SKLabelNode = self.childNodeWithName("blockscollectedlabel") as? SKLabelNode
        {
            if(blocksCollected <= 9)
            {
                numlevelslabel.text = "0" + String(blocksCollected) + " / 21"
            }
            else if(blocksCollected > 9)
            {
                numlevelslabel.text = String(blocksCollected) + " / 21"
            }
        }

        /**checkpoint spin
        if let someCP:checkpoint = self.childNodeWithName("CheckPoint") as? checkpoint
        {
         CheckPoint = someCP
         CheckPoint.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(10, duration: 20)))
        }**/
        //welcome label
        if let welcomeLabel:SKLabelNode = self.childNodeWithName("greetingLabel") as? SKLabelNode
        {
            let rando = Int(arc4random_uniform(10) + 1)
            print(rando)
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
                welcomeLabel.text = "YOU ARE AVERAGE AT THIS GAME"
            }
            if (rando == 9)
            {
                welcomeLabel.text = "WELCOME BACK"
            }
            if (rando == 10)
            {
                welcomeLabel.text = "HINT: THERE IS ONE COLLECTIBLE BLOCK ON EACH LEVEL"
            }
            
        }
        //purple block
        if let pb:SKSpriteNode = self.childNodeWithName("theViewBlock") as? SKSpriteNode
        {
            purpleblock = pb
            purpleblock.physicsBody!.categoryBitMask = purplemask
            purpleblock.physicsBody!.contactTestBitMask = purplemask | playerCategory
            
        }
        //red door1
        if let rd1:SKSpriteNode = self.childNodeWithName("redDoor1") as? SKSpriteNode
        {
            redDoor1 = rd1
            //let moveRight = SKAction.moveByX(100, y: 0, duration: 3)
            let moveUp = SKAction.moveByX(0, y: 150, duration: 2)
            if(levelsComplete >= 0)
            {
                redDoor1.runAction(moveUp)
            }
        }
        //red door2
        if let rd2:SKSpriteNode = self.childNodeWithName("redDoor2") as? SKSpriteNode
        {
            redDoor2 = rd2
            //let moveLeft = SKAction.moveByX(-100, y: 0, duration: 3)
            let moveUp = SKAction.moveByX(0, y: 150, duration: 2)
            if(levelsComplete >= 10)
            {
                redDoor2.runAction(moveUp)
            }
        }
        //red door3
        if let rd2:SKSpriteNode = self.childNodeWithName("redDoor3") as? SKSpriteNode
        {
            redDoor2 = rd2
            let moveUp = SKAction.moveByX(0, y: 150, duration: 2)
            if(levelsComplete >= 5)
            {
                redDoor2.runAction(moveUp)
            }
        }
        //red door4
        if let rd4:SKSpriteNode = self.childNodeWithName("redDoor4") as? SKSpriteNode
        {
            redDoor4 = rd4
            let moveUp = SKAction.moveByX(0, y: 100, duration: 2)
            if(levelsComplete >= 15)
            {
                redDoor4.runAction(moveUp)
            }
        }
        //red door5
        if let rd5:SKSpriteNode = self.childNodeWithName("redDoor5") as? SKSpriteNode
        {
            redDoor5 = rd5
            let moveUp = SKAction.moveByX(112, y: 0, duration: 2)
            if(levelsComplete >= 20 && blocksCollected >= 20)
            {
                redDoor5.runAction(moveUp)
            }
        }


        //-------BLACKBLACK---------------------------------------
        //black elevators
        //--------------------------------------------------------
        if let b1:SKSpriteNode = self.childNodeWithName("black1") as? SKSpriteNode
        {
            black1 = b1
            if(levelsComplete >= 0)
            {
            black1.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(2.0), moveplatform1, SKAction.waitForDuration(2.0), moveplatform1.reversedAction() ])))
            }
        }
        if let b2:SKSpriteNode = self.childNodeWithName("black2") as? SKSpriteNode
        {
            black2 = b2
            if(levelsComplete >= 1)
            {
                black2.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(2.0), moveplatform1, SKAction.waitForDuration(2.0), moveplatform1.reversedAction() ])))
            }
        }
        if let b3:SKSpriteNode = self.childNodeWithName("black3") as? SKSpriteNode
        {
            black3 = b3
            if(levelsComplete >= 2)
            {
                black3.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(2.0), moveplatform1, SKAction.waitForDuration(2.0), moveplatform1.reversedAction() ])))
            }
        }
        if let b4:SKSpriteNode = self.childNodeWithName("black4") as? SKSpriteNode
        {
            black4 = b4
            if(levelsComplete >= 3)
            {
                black4.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(2.0), moveplatform1, SKAction.waitForDuration(2.0), moveplatform1.reversedAction() ])))
            }
        }
        if let b5:SKSpriteNode = self.childNodeWithName("black5") as? SKSpriteNode
        {
            black5 = b5
            if(levelsComplete >= 4)
            {
                black5.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(2.0), moveplatform1, SKAction.waitForDuration(2.0), moveplatform1.reversedAction() ])))
            }
        }
        if let bmore5:SKSpriteNode = self.childNodeWithName("black5plus") as? SKSpriteNode
        {
            blackMoreThan5 = bmore5
            if(levelsComplete >= 5)
            {
                let fiveplusAction = SKAction.moveByX(0, y: -400, duration: 10)
                blackMoreThan5.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(2.0), fiveplusAction, SKAction.waitForDuration(2.0), fiveplusAction.reversedAction() ])))
            }
        }
        if let bmore9:SKSpriteNode = self.childNodeWithName("black9plus") as? SKSpriteNode
        {
            blackplus9 = bmore9
            if(levelsComplete >= 9)
            {
                let fiveplusAction = SKAction.moveByX(0, y: -195, duration: 3)
                blackplus9.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(2.0), fiveplusAction, SKAction.waitForDuration(2.0), fiveplusAction.reversedAction() ])))
            }
        }

        
        //----------------------------------------------------------
        //death message
        if let theDeathLabel:SKLabelNode = self.childNodeWithName("deathlabel") as? SKLabelNode
        {
            deathLabel = theDeathLabel
            deathLabel.hidden = true
        }
        
        //--------------------------------------------------------
        //LEVEL NODE SETUP
        //--------------------------------------------------------
        if let l1:SKSpriteNode = self.childNodeWithName("level1") as? SKSpriteNode
        {
            level1 = l1
            level1.physicsBody!.categoryBitMask = level1mask
            level1.physicsBody!.contactTestBitMask = level1mask | playerCategory

        }
        if let l2:SKSpriteNode = self.childNodeWithName("level2") as? SKSpriteNode
        {
            level2 = l2
            level2.physicsBody!.categoryBitMask = level2mask
            level2.physicsBody!.contactTestBitMask = level2mask | playerCategory
            
        }
        if let l3:SKSpriteNode = self.childNodeWithName("level3") as? SKSpriteNode
        {
            level3 = l3
            level3.physicsBody!.categoryBitMask = level3mask
            level3.physicsBody!.contactTestBitMask = level3mask | playerCategory
        }
        if let l4:SKSpriteNode = self.childNodeWithName("level4") as? SKSpriteNode
        {
            level4 = l4
            level4.physicsBody!.categoryBitMask = level4mask
            level4.physicsBody!.contactTestBitMask = level4mask | playerCategory
        }
        if let l5:SKSpriteNode = self.childNodeWithName("level5") as? SKSpriteNode
        {
            level5 = l5
            level5.physicsBody!.categoryBitMask = level5mask
            level5.physicsBody!.contactTestBitMask = level5mask | playerCategory
        }
        if let l6:SKSpriteNode = self.childNodeWithName("level6") as? SKSpriteNode
        {
            level6 = l6
            level6.physicsBody!.categoryBitMask = level6mask
            level6.physicsBody!.contactTestBitMask = level6mask | playerCategory
        }
        if let l7:SKSpriteNode = self.childNodeWithName("level7") as? SKSpriteNode
        {
            level7 = l7
            level7.physicsBody!.categoryBitMask = level7mask
            level7.physicsBody!.contactTestBitMask = level7mask | playerCategory
        }
        if let l8:SKSpriteNode = self.childNodeWithName("level8") as? SKSpriteNode
        {
            level8 = l8
            level8.physicsBody!.categoryBitMask = level8mask
            level8.physicsBody!.contactTestBitMask = level8mask | playerCategory
        }
        if let l9:SKSpriteNode = self.childNodeWithName("level9") as? SKSpriteNode
        {
            level9 = l9
            level9.physicsBody!.categoryBitMask = level9mask
            level9.physicsBody!.contactTestBitMask = level9mask | playerCategory
        }

        //--------------------------------------------------------
        //NODE SETUP END
        //--------------------------------------------------------
        
        
        
    }
    
    //special collision detection
    func didBeginContact(contact: SKPhysicsContact)
    {
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == purplemask)) || ((contact.bodyA.categoryBitMask == purplemask ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if(didtouchpurple == false)
            {
            didtouchpurple = true
            let move: SKAction = SKAction.moveByX(0, y: 900, duration: NSTimeInterval(5.0))
            purpleblock.runAction(SKAction.repeatActionForever(SKAction.sequence([move, SKAction.waitForDuration(2.0), move.reversedAction(), SKAction.waitForDuration(2.0)])))
            playerCamera.runAction(SKAction.sequence([ SKAction.scaleTo(1.0, duration: 3.0), SKAction.scaleTo(0.15, duration: 1)]))
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


    }
    
    //contact ends between two nodes!
    func didEndContact(contact: SKPhysicsContact)
    {
        
    }
    
    //----------------------------------------------------
    //helper functions for speical condition collisions
    //----------------------------------------------------
    //end of level sequence
    
    func hideDeathText()
    {
        deathLabel.hidden = true
    }
    
    //respawn player at current respawn point
    func respawnPlayer()
    {
        thePlayer.position = thePlayer.RespawnPoint
        
        self.addChild(thePlayer)
    }
    
    //Creates four splintering blocks upon death
    func deathAnimation(playerVelocity: CGVector, playerPosition: CGPoint)
    {
        
        thePlayer.removeFromParent()
        
        let block1 = SKSpriteNode()
        block1.size = CGSizeMake(25, 25)
        block1.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block1.position = playerPosition
        block1.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block1.physicsBody!.velocity = playerVelocity
        block1.physicsBody!.restitution = CGFloat(0.5)
        
        let block2 = SKSpriteNode()
        block2.size = CGSizeMake(25, 25)
        block2.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block2.position = CGPointMake((playerPosition.x + 25.0), (playerPosition.y - 25.0))
        block2.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block2.physicsBody!.velocity = playerVelocity
        block2.physicsBody!.restitution = CGFloat(0.5)
        
        let block3 = SKSpriteNode()
        block3.size = CGSizeMake(25, 25)
        block3.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block3.position = CGPointMake((playerPosition.x), (playerPosition.y - 25.0))
        block3.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block3.physicsBody!.velocity = playerVelocity
        block3.physicsBody!.restitution = CGFloat(0.5)
        
        let block4 = SKSpriteNode()
        block4.size = CGSizeMake(25, 25)
        block4.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block4.position = CGPointMake((playerPosition.x + 25.0), (playerPosition.y))
        block4.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
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
    override func update(currentTime: CFTimeInterval)
    {
        //-------------------------------------------------
        //camera follow the player
        playerCamera.position = CGPointMake(thePlayer.position.x, thePlayer.position.y - 100)
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
        
        if(framesInPlace >= 2)
        {
            onGround = true
            framesInPlace = 2
            //print("onground")
        }
        
        
        if(viewController.isJumping == true && onGround == true)
        {
            currentjumpForce = 70.0
            viewController.isJumping = false
            //print("jump")
        }
        viewController.isJumping = false
        //-------------------------------------------------
        //left and right handling
        if(viewController.isLeft == true)
        {
            thePlayer.physicsBody?.applyImpulse(CGVectorMake(leftForce, currentjumpForce))
            
        }
        else if(viewController.isRight == true)
        {
            thePlayer.physicsBody?.applyImpulse(CGVectorMake(rightForce, currentjumpForce))
            
        }
        else
        {
            thePlayer.physicsBody?.applyImpulse(CGVectorMake(0.0, currentjumpForce))
            
        }
        //-------------------------------------------------
        if(viewController.isRespawning == true)
        {
            viewController.isRespawning = false
            
            print("death")
            deathLabel.position = thePlayer.position
            deathLabel.hidden = false
            deathAnimation(thePlayer.physicsBody!.velocity, playerPosition:  thePlayer.position)
            runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock(respawnPlayer)]))
            runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock(hideDeathText)]))

        }
    }
    
    
}
