//
//  GameScene.swift
//  Block Boogie
//
//  Created by Patrick Sweeney on 5/18/16.
//  Copyright (c) 2016 Patrick Sweeney. All rights reserved.
//

import SpriteKit



//This will act as a template for other scenes
//it will include code for player movement and
class level1: SKScene, SKPhysicsContactDelegate
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
    
    //------------------------------------------------
    //global node declarations
    var playerCamera:SKCameraNode = SKCameraNode()
    var thePlayer:player = player()
    var CheckPoint:checkpoint = checkpoint()
    
    var deathBlock1:SKSpriteNode = SKSpriteNode()
    var deathBlock2:SKSpriteNode = SKSpriteNode()
    var deathBlock3:SKSpriteNode = SKSpriteNode()
    var deathBlock4:SKSpriteNode = SKSpriteNode()
    
    var redBlock1:SKSpriteNode = SKSpriteNode()
    var redBlock2:SKSpriteNode = SKSpriteNode()
    var redBlock3:SKSpriteNode = SKSpriteNode()
    var redBlock4:SKSpriteNode = SKSpriteNode()
    var redBlock5:SKSpriteNode = SKSpriteNode()
    var redBlock6:SKSpriteNode = SKSpriteNode()
    var redBlock7:SKSpriteNode = SKSpriteNode()
    
    var greenblock1:SKSpriteNode = SKSpriteNode()
    var blackblock1:SKSpriteNode = SKSpriteNode()
    var blackblock2:SKSpriteNode = SKSpriteNode()
    
    var endblock1:SKSpriteNode = SKSpriteNode()
    var deathLabel:SKLabelNode = SKLabelNode()
    var purpleBlock:SKSpriteNode = SKSpriteNode()
    
    var redpit1:SKSpriteNode = SKSpriteNode()
    var redpit2:SKSpriteNode = SKSpriteNode()
    var redpit3:SKSpriteNode = SKSpriteNode()
    var redpit4:SKSpriteNode = SKSpriteNode()
    var redpit5:SKSpriteNode = SKSpriteNode()
    //------------------------------------------------
    //global booleans (RANDOM)
    let isTutorial: Bool = false
    var isCheckPointActive: Bool = false
    var collectibleFound:Bool = false
    var levelComplete:Bool = false
    
    let level:Int = 1
    
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
    
    
    //------------------------------------------------
    override func didMoveToView(view: SKView)
    {
        //Setup gravity in scene//
        self.physicsWorld.gravity = (CGVectorMake(0, -9.8))
        self.physicsWorld.contactDelegate = self
        //Setup world boundary//
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: 8000, height: 8000))
        self.physicsBody!.categoryBitMask = redblockCategory
        
        
        //--------------------------------------------------------
        //NODE SETUP
        //--------------------------------------------------------
        
        //Scene camera
        if let ourCamera:SKCameraNode = self.childNodeWithName("MainCamera") as? SKCameraNode
        {
            playerCamera = ourCamera
            self.camera = playerCamera
            
        }
        //player
        if let ourPlayer:player = self.childNodeWithName("Player") as? player
        {
            thePlayer = ourPlayer
            thePlayer.RespawnPoint = thePlayer.position //set spawn position to current Respawn Point
            thePlayer.physicsBody!.categoryBitMask = playerCategory
            print("playercheck")
            
        }
        //checkpoint
        if let cp:checkpoint = self.childNodeWithName("checkpoint1") as? checkpoint
        {
            CheckPoint = cp
            CheckPoint.CheckPointPosition = CGPointMake(CheckPoint.position.x, CheckPoint.position.y)
            CheckPoint.physicsBody!.categoryBitMask = blueblockCategory
            CheckPoint.physicsBody!.contactTestBitMask = blueblockCategory | playerCategory
        }
        //--------------------------------------------------------
        //redblocks
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock1") as? SKSpriteNode
        {
            redBlock1 = someRedBlock
            redBlock1.physicsBody!.categoryBitMask = redblockCategory
            redBlock1.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock2") as? SKSpriteNode
        {
            redBlock2 = someRedBlock
            redBlock2.physicsBody!.categoryBitMask = redblockCategory
            redBlock2.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock3") as? SKSpriteNode
        {
            redBlock3 = someRedBlock
            redBlock3.physicsBody!.categoryBitMask = redblockCategory
            redBlock3.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock4") as? SKSpriteNode
        {
            redBlock4 = someRedBlock
            redBlock4.physicsBody!.categoryBitMask = redblockCategory
            redBlock4.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock5") as? SKSpriteNode
        {
            redBlock5 = someRedBlock
            redBlock5.physicsBody!.categoryBitMask = redblockCategory
            redBlock5.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock6") as? SKSpriteNode
        {
            redBlock6 = someRedBlock
            redBlock6.physicsBody!.categoryBitMask = redblockCategory
            redBlock6.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock7") as? SKSpriteNode
        {
            redBlock7 = someRedBlock
            redBlock7.physicsBody!.categoryBitMask = redblockCategory
            redBlock7.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        //--------------------------------------------------------
        //redpit//////////////////////////////////////////////////////////////////
        if let someRedpit1:SKSpriteNode = self.childNodeWithName("redpit1") as? SKSpriteNode
        {
            redpit1 = someRedpit1
            redpit1.physicsBody!.categoryBitMask = redblockCategory
            redpit1.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedpit2:SKSpriteNode = self.childNodeWithName("redpit2") as? SKSpriteNode
        {
            redpit2 = someRedpit2
            redpit2.physicsBody!.categoryBitMask = redblockCategory
            redpit2.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedpit3:SKSpriteNode = self.childNodeWithName("redpit3") as? SKSpriteNode
        {
            redpit3 = someRedpit3
            redpit3.physicsBody!.categoryBitMask = redblockCategory
            redpit3.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedpit4:SKSpriteNode = self.childNodeWithName("redpit4") as? SKSpriteNode
        {
            redpit4 = someRedpit4
            redpit4.physicsBody!.categoryBitMask = redblockCategory
            redpit4.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedpit5:SKSpriteNode = self.childNodeWithName("redpit5") as? SKSpriteNode
        {
            redpit5 = someRedpit5
            redpit5.physicsBody!.categoryBitMask = redblockCategory
            redpit5.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }

        /////////////////////////////////////////////////////////////////////////
        //greenblocks
        if let someGreenBlock:SKSpriteNode = self.childNodeWithName("greenblock1") as? SKSpriteNode
        {
            greenblock1 = someGreenBlock
            greenblock1.physicsBody!.categoryBitMask = greenblockCategory
            greenblock1.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        //blackblocks
        if let someBlackBlock:SKSpriteNode = self.childNodeWithName("blackblock1") as? SKSpriteNode
        {
            blackblock1 = someBlackBlock
            blackblock1.physicsBody!.categoryBitMask = blackblockCategory
            blackblock1.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform1: SKAction = SKAction.moveByX(600.0, y: 0, duration: NSTimeInterval(5.0))
            blackblock1.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(1.5), moveplatform1, SKAction.waitForDuration(1.5), moveplatform1.reversedAction() ])))
        }
        if let someBlackBlock2:SKSpriteNode = self.childNodeWithName("blackblock2") as? SKSpriteNode
        {
            blackblock2 = someBlackBlock2
            blackblock2.physicsBody!.categoryBitMask = blackblockCategory
            blackblock2.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform2: SKAction = SKAction.moveByX(-600.0, y: 0, duration: NSTimeInterval(5.0))
            blackblock2.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(1.5), moveplatform2, SKAction.waitForDuration(1.5), moveplatform2.reversedAction() ])))
        }

        //endblock
        if let theEndBlock:SKSpriteNode = self.childNodeWithName("endblock") as? SKSpriteNode
        {
            endblock1 = theEndBlock
            endblock1.physicsBody!.categoryBitMask = endblockCategory
            endblock1.physicsBody!.contactTestBitMask = endblockCategory | playerCategory
            
        }
        //death message
        if let theDeathLabel:SKLabelNode = self.childNodeWithName("deathlabel") as? SKLabelNode
        {
            deathLabel = theDeathLabel
            deathLabel.hidden = true
        }
        //collectable purple block
        if let thepb:SKSpriteNode = self.childNodeWithName("purpleblock") as? SKSpriteNode
        {
            print("purple node made")
            purpleBlock = thepb
            purpleBlock.physicsBody!.categoryBitMask = purpleblockCategory
            purpleBlock.physicsBody!.contactTestBitMask = playerCategory | purpleblockCategory
        }
        //--------------------------------------------------------
        //NODE SETUP END
        //--------------------------------------------------------
        
        
        
    }
    
    //special collision detection
    func didBeginContact(contact: SKPhysicsContact)
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
            deathLabel.position = thePlayer.position
            deathLabel.hidden = false
            deathAnimation(thePlayer.physicsBody!.velocity, playerPosition:  thePlayer.position)
            runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock(respawnPlayer)]))
            runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock(hideDeathText)]))
            
        }
        //greenblocks
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == greenblockCategory)) || ((contact.bodyA.categoryBitMask == greenblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            print("bounce")
            thePlayer.physicsBody!.applyImpulse(CGVectorMake(0, 100))
        }
        //endblock
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == endblockCategory)) || ((contact.bodyA.categoryBitMask == endblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if(levelComplete == false)
            {
                print("end of level reached")
                levelComplete = true
                endOfLevel()
            }
        }
        //purple block
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == purpleblockCategory)) || ((contact.bodyA.categoryBitMask == purpleblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if(collectibleFound == false)
            {
                print("purple block collected")
                //here you would mark this as already collected normally
                let purpleRise = SKAction.moveByX(0, y: 100, duration: 1)
                let purpleSpin = SKAction.repeatActionForever( SKAction.rotateByAngle(20, duration: 10))
                purpleBlock.runAction(purpleRise)
                purpleBlock.runAction(purpleSpin)
                collectibleFound = true

            }
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
    
    func endOfLevel()
    {
        let move: SKAction = SKAction.moveByX(-400, y: 0, duration: NSTimeInterval(1.5))
        endblock1.runAction(move)
        playerCamera.runAction(SKAction.scaleTo(2.0, duration: 3))
        runAction(SKAction.sequence([SKAction.waitForDuration(3.5), SKAction.runBlock(goBackToHub)]))
        
        let levelbool = true
        NSUserDefaults.standardUserDefaults().setObject(levelbool, forKey:"level1")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if(collectibleFound == true)
        {
            NSUserDefaults.standardUserDefaults().setObject(levelbool, forKey:"block1")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    func goBackToHub()
    {
        viewController.goBackToHub()
    }
    
    //respawn player at current respawn point
    func respawnPlayer()
    {
        thePlayer.position = thePlayer.RespawnPoint
        self.addChild(thePlayer)
        //remove deathBlocks
        deathBlock1.removeFromParent()
        deathBlock2.removeFromParent()
        deathBlock3.removeFromParent()
        deathBlock4.removeFromParent()

    }
    
    //move CheckPoint to activated position
    func moveCheckPoint()
    {
        if(isCheckPointActive == false)
        {
            isCheckPointActive = true
            //checkpointlabel
            if let cplabel:SKLabelNode = self.childNodeWithName("checkpointlabel") as? SKLabelNode
            {
                //print("checkpoint label should change here")
                cplabel.text = "ACTIVE"
            }
            
            
            let movecp: SKAction = SKAction.moveByX(0, y: -400, duration: 3)
            CheckPoint.runAction(movecp)
            
        }
        
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
        deathBlock1 = block1
        
        let block2 = SKSpriteNode()
        block2.size = CGSizeMake(25, 25)
        block2.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block2.position = CGPointMake((playerPosition.x + 25.0), (playerPosition.y - 25.0))
        block2.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block2.physicsBody!.velocity = playerVelocity
        block2.physicsBody!.restitution = CGFloat(0.5)
        deathBlock2 = block2
        
        let block3 = SKSpriteNode()
        block3.size = CGSizeMake(25, 25)
        block3.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block3.position = CGPointMake((playerPosition.x), (playerPosition.y - 25.0))
        block3.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block3.physicsBody!.velocity = playerVelocity
        block3.physicsBody!.restitution = CGFloat(0.5)
        deathBlock3 = block3
        
        let block4 = SKSpriteNode()
        block4.size = CGSizeMake(25, 25)
        block4.color = UIColor(red:0.20, green:0.40, blue:1.00, alpha:1.0)
        block4.position = CGPointMake((playerPosition.x + 25.0), (playerPosition.y))
        block4.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
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
    override func update(currentTime: CFTimeInterval)
    {
        //-------------------------------------------------
        //camera follow the player
        playerCamera.position = CGPointMake(thePlayer.position.x, thePlayer.position.y - 100)
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
        }
        
        
        if(viewController.isJumping == true && onGround == true)
        {
            currentjumpForce = 70.0
            viewController.isJumping = false
            print("jump")
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
