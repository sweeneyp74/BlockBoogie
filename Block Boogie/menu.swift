//
//  menu.swift
//  Block Boogie
//
//  Created by Patrick Sweeney on 8/15/16.
//  Copyright © 2016 Patrick Sweeney. All rights reserved.
//

import Foundation
import SpriteKit



//This will act as a template for other scenes
//it will include code for player movement and
class menu: SKScene, SKPhysicsContactDelegate
{
    var viewController:GameViewController!
    
    //------------------------------------------------
    //CategoryBitMask assignments
    let playerCategory:UInt32 =  0x1 << 0
    let redblockCategory:UInt32 =  0x1 << 1
    let greenblockCategory:UInt32 =  0x1 << 2
    let blueblockCategory:UInt32 = 0x1 << 3
    let blackblockCategory:UInt32 = 0x1 << 4
    let endblockCategory:UInt32 = 0x1 << 5
    let purpleblockCategory:UInt32 = 0x1 << 6
    let whiteblockCategory:UInt32 = 0x1 << 7
    let blueblockCategory2:UInt32 = 0x1 << 8
    let blueblockCategory3:UInt32 = 0x1 << 9
    //------------------------------------------------
    //global node declarations
    var playerCamera:SKCameraNode = SKCameraNode()
    var thePlayer:player = player()
    var CheckPoint:checkpoint = checkpoint()
    var followpurple:SKSpriteNode = SKSpriteNode()
    
    var deathBlock1:SKSpriteNode = SKSpriteNode()
    var deathBlock2:SKSpriteNode = SKSpriteNode()
    var deathBlock3:SKSpriteNode = SKSpriteNode()
    var deathBlock4:SKSpriteNode = SKSpriteNode()
    
    var redspin1:SKSpriteNode = SKSpriteNode()
    
    var redBlock1:SKSpriteNode = SKSpriteNode()
    var redBlock2:SKSpriteNode = SKSpriteNode()
    var redBlock3:SKSpriteNode = SKSpriteNode()
    var redBlock4:SKSpriteNode = SKSpriteNode()
    var redBlock5:SKSpriteNode = SKSpriteNode()
    var redBlock6:SKSpriteNode = SKSpriteNode()
    var redBlock7:SKSpriteNode = SKSpriteNode()
    var redBlock8:SKSpriteNode = SKSpriteNode()
    var redBlock9:SKSpriteNode = SKSpriteNode()
    var redBlock10:SKSpriteNode = SKSpriteNode()
    var redBlock11:SKSpriteNode = SKSpriteNode()
    var redBlock12:SKSpriteNode = SKSpriteNode()
    var redBlock13:SKSpriteNode = SKSpriteNode()
    var redBlock14:SKSpriteNode = SKSpriteNode()
    var redBlock15:SKSpriteNode = SKSpriteNode()
    var redBlock16:SKSpriteNode = SKSpriteNode()
    var redBlock17:SKSpriteNode = SKSpriteNode()
    var redBlock18:SKSpriteNode = SKSpriteNode()
    var redBlock19:SKSpriteNode = SKSpriteNode()
    var redBlock20:SKSpriteNode = SKSpriteNode()
    var redBlock21:SKSpriteNode = SKSpriteNode()
    var redBlock22:SKSpriteNode = SKSpriteNode()
    
    
    var greenblock1:SKSpriteNode = SKSpriteNode()
    var greenblock2:SKSpriteNode = SKSpriteNode()
    var greenblock3:SKSpriteNode = SKSpriteNode()
    
    var endblock1:SKSpriteNode = SKSpriteNode()
    var deathLabel:SKLabelNode = SKLabelNode()
    var purpleBlock:SKSpriteNode = SKSpriteNode()
    
    var whiteblock1:SKSpriteNode = SKSpriteNode()
    var whiteblock2:SKSpriteNode = SKSpriteNode()
    var whiteblock3:SKSpriteNode = SKSpriteNode()
    
    var blueblock1:SKSpriteNode = SKSpriteNode()
    var blueblock2:SKSpriteNode = SKSpriteNode()
    var blueblock1bool:Bool = false
    var blueblock2bool:Bool = false
    
    var blackblock1:SKSpriteNode = SKSpriteNode()
    var blackblock2:SKSpriteNode = SKSpriteNode()
    var blackblock3:SKSpriteNode = SKSpriteNode()
    //------------------------------------------------
    //global booleans (RANDOM)
    let isTutorial: Bool = false
    var isCheckPointActive: Bool = false
    var collectibleFound:Bool = false
    var levelComplete:Bool = false
    
    let level:Int = 2
    
    var isTouchingWhite:Bool = false
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
    //SKACTIONS THAT ARE USED MULTIPLE TIMES
    let redblockmove: SKAction = SKAction.moveBy(x: 0, y: 400, duration: 0.5)
    let redblockmove2: SKAction = SKAction.moveBy(x: 800, y: 0, duration: 1)
    //------------------------------------------------
    override func didMove(to view: SKView)
    {
        //--------------------------------------------------------
        //VIEW CONTROLLER STUFF!
        //--------------------------------------------------------
        //nah just playin
        
        
        //Setup gravity in scene//
        self.physicsWorld.gravity = (CGVector(dx: 0, dy: -9.8))
        self.physicsWorld.contactDelegate = self
        //Setup world boundary//
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: 8000, height: 8000))
        self.physicsBody!.categoryBitMask = redblockCategory
        
        
        //--------------------------------------------------------
        //NODE SETUP
        //--------------------------------------------------------
        
        //Scene camera
        if let ourCamera:SKCameraNode = self.childNode(withName: "MainCamera") as? SKCameraNode
        {
            playerCamera = ourCamera
            self.camera = playerCamera
            
        }
        //player
        if let ourPlayer:player = self.childNode(withName: "Player") as? player
        {
            thePlayer = ourPlayer
            thePlayer.RespawnPoint = thePlayer.position //set spawn position to current Respawn Point
            thePlayer.physicsBody!.categoryBitMask = playerCategory
            thePlayer.physicsBody!.collisionBitMask = blueblockCategory | playerCategory | redblockCategory | blackblockCategory | blueblockCategory2 | blueblockCategory3 | endblockCategory | purpleblockCategory
            
            let diceRoll = CGFloat(arc4random_uniform(300) + 1)
            thePlayer.physicsBody?.applyImpulse(CGVector(dx: diceRoll, dy: 0))
            print("playercheck")
            
        }
        //--------------------------------------------------------

        
        //--------------------------------------------------------
        //redblocks
      
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock12") as? SKSpriteNode
        {
            redBlock13 = someRedBlock
            redBlock13.physicsBody!.categoryBitMask = redblockCategory
            redBlock13.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock13.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(0, y: -100, duration: 4), SKAction.moveByX(0, y: 100, duration: 0.5)])))
        }
        
        
        
        /////////////////////////////////////////////////////////////////////////
        //greenblocks
        if let someGreenBlock:SKSpriteNode = self.childNode(withName: "greenblock1") as? SKSpriteNode
        {
            greenblock1 = someGreenBlock
            greenblock1.physicsBody!.categoryBitMask = greenblockCategory
            greenblock1.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        if let someGreenBlock:SKSpriteNode = self.childNode(withName: "greenblock2") as? SKSpriteNode
        {
            greenblock2 = someGreenBlock
            greenblock2.physicsBody!.categoryBitMask = greenblockCategory
            greenblock2.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        if let someGreenBlock:SKSpriteNode = self.childNode(withName: "greenblock3") as? SKSpriteNode
        {
            greenblock3 = someGreenBlock
            greenblock3.physicsBody!.categoryBitMask = greenblockCategory
            greenblock3.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        //--------------------------------------------------------
        //NODE SETUP END
        //--------------------------------------------------------
        
        
        
    }
    
    //special collision detection
    func didBegin(_ contact: SKPhysicsContact)
    {
        //checkpoint
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == blueblockCategory)) || ((contact.bodyA.categoryBitMask == blueblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            print("checkpoint touched")
            moveCheckPoint()
            thePlayer.RespawnPoint = CheckPoint.CheckPointPosition
        }
        //redblocks
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == redblockCategory)) || ((contact.bodyA.categoryBitMask == redblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            print("death")
            deathLabel.position = CGPoint( x: thePlayer.position.x, y: thePlayer.position.y + 150)
            
            let rando = Int(arc4random_uniform(30) + 1)
            print("message: " + String(rando))
            if (rando == 1)
            {
                deathLabel.text = "LOL YOU DIED"
            }
            if (rando == 2)
            {
                deathLabel.text = "HONESTLY YOU ARE PRETTY BAD"
            }
            if (rando == 3)
            {
                deathLabel.text = "DEAD ONCE MORE... NOOB"
            }
            if (rando == 4)
            {
                deathLabel.text = "HAHAHAAHAH DEAD"
            }
            if (rando == 5)
            {
                deathLabel.text = "YOU MAKE ME LAUGH"
            }
            if (rando == 6)
            {
                deathLabel.text = "TE HE HE"
            }
            if (rando == 7)
            {
                deathLabel.text = "I NEVER ONCE DIED HERE"
            }
            if (rando == 8)
            {
                deathLabel.text = "YOU ARE AVERAGE AT THIS GAME"
            }
            if (rando == 9)
            {
                deathLabel.text = "NOOB"
            }
            if (rando == 10)
            {
                deathLabel.text = "LOL"
            }
            if (rando == 11)
            {
                deathLabel.text = "GO BACK TO TEMPLE RUN"
            }
            if (rando == 12)
            {
                deathLabel.text = "GO BACK TO POKEMON GO"
            }
            if (rando == 13)
            {
                deathLabel.text = "ARE YOU EVEN TRYING?"
            }
            if (rando == 14)
            {
                deathLabel.text = "KEEP PUSHING. YOU ARE AWESOME!"
            }
            if (rando == 15)
            {
                deathLabel.text = "YOU ARE NOT AWESOME"
            }
            if (rando == 16)
            {
                deathLabel.text = "EVERYONE ELSE BEAT THIS PART FIRST TRY"
            }
            if (rando == 17)
            {
                deathLabel.text = "LOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOLOL"
            }
            if (rando == 18)
            {
                deathLabel.text = "YOU DIED ( ͡° ͜ʖ ͡°)"
            }
            if (rando == 19)
            {
                deathLabel.text = "( ͡° ͜ʖ ͡°)"
            }
            if (rando == 20)
            {
                deathLabel.text = "WOW... JUST WOW"
            }
            if (rando == 21)
            {
                deathLabel.text = "IS DYING A JOKE TO YOU?!"
            }
            if (rando == 22)
            {
                deathLabel.text = "YOU DIED...   ...AGAIN"
            }
            if (rando == 23)
            {
                deathLabel.text = "IM LAUGHING AT YOU"
            }
            if (rando == 24)
            {
                deathLabel.text = "OMG"
            }
            if (rando == 25)
            {
                deathLabel.text = "..."
            }
            if (rando == 26)
            {
                deathLabel.text = "ITS NOT THE GAME, ITS YOU"
            }
            if (rando == 27)
            {
                deathLabel.text = "S#$T F&#K S#&T"
            }
            if (rando == 28)
            {
                deathLabel.text = "AUUUUUGGGGGGGHHHHHHHh"
            }
            if (rando == 29)
            {
                deathLabel.text = "I JUST LOST COUNT OF HOW MANY TIMES YOU DIED"
            }
            if (rando == 30)
            {
                deathLabel.text = "I STOPPED COUNTING DEATHS AGES AGO"
            }
            
            
            deathLabel.isHidden = false
            deathAnimation(thePlayer.physicsBody!.velocity, playerPosition:  thePlayer.position)
            if(collectibleFound == true)
            {
                deathLabel.text = "YOU DIED WITH A PURPLE BLOCK! - RESTARTING LEVEL"
                run(SKAction.sequence([SKAction.wait(forDuration: 2.5),SKAction.run(viewController.switchToLevel)]))
            }
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(respawnPlayer)]))
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(hideDeathText)]))
            
            followpurple.isHidden = true
        }
        //greenblocks
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == greenblockCategory)) || ((contact.bodyA.categoryBitMask == greenblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            print("bounce")
            thePlayer.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 250))
        }
        //endblock
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == endblockCategory)) || ((contact.bodyA.categoryBitMask == endblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if(levelComplete == false)
            {
                //print("end of level reached")
                levelComplete = true
                endOfLevel()
            }
        }
        //purple block
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == purpleblockCategory)) || ((contact.bodyA.categoryBitMask == purpleblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if(collectibleFound == false)
            {
                //print("purple block collected")
                //here you would mark this as already collected normally
                let purpleRise = SKAction.moveBy(x: 0, y: 50, duration: 1)
                let purpleSpin = SKAction.repeatForever( SKAction.rotate(byAngle: 20, duration: 10))
                purpleBlock.run(purpleRise)
                purpleBlock.run(purpleSpin)
                collectibleFound = true
                
                followpurple.isHidden = false
                
                
            }
        }
        
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == whiteblockCategory)) || ((contact.bodyA.categoryBitMask == whiteblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            self.physicsWorld.gravity = (CGVector(dx: 0, dy: -2.0))
            isTouchingWhite = true
            //print("white and player touching")
        }
        
        //blueblocks
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == blueblockCategory2)) || ((contact.bodyA.categoryBitMask == blueblockCategory2) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if (blueblock1bool == false)
            {
                blueblock1bool = true
                blueblock1.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: 450, duration: 6), SKAction.wait(forDuration: 2), SKAction.moveBy(x: 0, y: -450, duration: 6), SKAction.wait(forDuration: 2)])))
            }
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == blueblockCategory3)) || ((contact.bodyA.categoryBitMask == blueblockCategory3 ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if (blueblock2bool == false)
            {
                blueblock2bool = true
                blueblock2.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y:-350 , duration: 6), SKAction.moveBy(x: 0, y: 350, duration: 6)])))
            }
        }
    }
    
    //contact ends between two nodes!
    func didEnd(_ contact: SKPhysicsContact)
    {
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == whiteblockCategory)) || ((contact.bodyA.categoryBitMask == whiteblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            self.physicsWorld.gravity = (CGVector(dx: 0, dy: -9.8))
            isTouchingWhite = false
            print("no longer")
        }
    }
    
    //----------------------------------------------------
    //helper functions for speical condition collisions
    //----------------------------------------------------
    //end of level sequence
    
    func hideDeathText()
    {
        deathLabel.isHidden = true
    }
    
    func endOfLevel()
    {
        let move: SKAction = SKAction.moveBy(x: 0, y: -1000, duration: TimeInterval(2))
        endblock1.run(move)
        playerCamera.run(SKAction.scale(to: 1.0, duration: 3))
        run(SKAction.sequence([SKAction.wait(forDuration: 3.5), SKAction.run(goBackToHub)]))
        
    }
    func goBackToHub()
    {
        viewController.goBackToHub()
    }
    
    //respawn player at current respawn point
    func respawnPlayer()
    {
        //reset normal movement
        self.physicsWorld.gravity = (CGVector(dx: 0, dy: -9.8))
        isTouchingWhite = false
        //determine respawn point
        thePlayer.position = thePlayer.RespawnPoint
        //add player back to the scene
        self.addChild(thePlayer)
        //remove deathBlocks
        deathBlock1.removeFromParent()
        deathBlock2.removeFromParent()
        deathBlock3.removeFromParent()
        deathBlock4.removeFromParent()
        
        let diceRoll = CGFloat(arc4random_uniform(300) + 1)
        thePlayer.physicsBody?.applyImpulse(CGVector(dx: diceRoll, dy: 0))
    }
    
    //move CheckPoint to activated position
    func moveCheckPoint()
    {
        if(isCheckPointActive == false)
        {
            isCheckPointActive = true
            //checkpointlabel
            if let cplabel:SKLabelNode = self.childNode(withName: "checkpointlabel") as? SKLabelNode
            {
                //print("checkpoint label should change here")
                cplabel.text = "ACTIVE"
            }
            
            
            let movecp: SKAction = SKAction.moveBy(x: 0, y: 150, duration: 1)
            CheckPoint.run(SKAction.repeatForever( SKAction.sequence([movecp, SKAction.wait(forDuration: 1.5), movecp.reversed(), SKAction.wait(forDuration: 1.5)])))
            
        }
        
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
        deathBlock1 = block1
        
        let block2 = SKSpriteNode()
        block2.size = CGSize(width: 25, height: 25)
        block2.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block2.position = CGPoint(x: (playerPosition.x + 25.0), y: (playerPosition.y - 25.0))
        block2.physicsBody = SKPhysicsBody(rectangleOf: block1.size)
        block2.physicsBody!.velocity = playerVelocity
        block2.physicsBody!.restitution = CGFloat(0.5)
        deathBlock2 = block2
        
        let block3 = SKSpriteNode()
        block3.size = CGSize(width: 25, height: 25)
        block3.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block3.position = CGPoint(x: (playerPosition.x), y: (playerPosition.y - 25.0))
        block3.physicsBody = SKPhysicsBody(rectangleOf: block1.size)
        block3.physicsBody!.velocity = playerVelocity
        block3.physicsBody!.restitution = CGFloat(0.5)
        deathBlock3 = block3
        
        let block4 = SKSpriteNode()
        block4.size = CGSize(width: 25, height: 25)
        block4.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block4.position = CGPoint(x: (playerPosition.x + 25.0), y: (playerPosition.y))
        block4.physicsBody = SKPhysicsBody(rectangleOf: block1.size)
        block4.physicsBody!.velocity = playerVelocity
        block4.physicsBody!.restitution = CGFloat(0.5)
        deathBlock4 = block4
        
        self.addChild(deathBlock1)
        self.addChild(deathBlock2)
        self.addChild(deathBlock3)
        self.addChild(deathBlock4)
    }
    
    
    
    //------------------------------------------------
    //UPDATE <><><>
    //------------------------------------------------
    override func update(_ currentTime: TimeInterval)
    {
        //-------------------------------------------------
        thePlayer.physicsBody?.restitution = 0.4
        //-------------------------------------------------
        //-------------------------------------------------
        if(viewController.isRespawning == true)
        {
            viewController.isRespawning = false
            
            deathAnimation(thePlayer.physicsBody!.velocity, playerPosition:  thePlayer.position)
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(respawnPlayer)]))
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(hideDeathText)]))
            
        }
        
    }
    
    
}
