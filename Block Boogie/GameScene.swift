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
class GameScene: SKScene, SKPhysicsContactDelegate
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
    var redBlock1:SKSpriteNode = SKSpriteNode()
    var redBlock2:SKSpriteNode = SKSpriteNode()
    var greenblock1:SKSpriteNode = SKSpriteNode()
    var blackblock1:SKSpriteNode = SKSpriteNode()
    var endblock1:SKSpriteNode = SKSpriteNode()
    var deathLabel:SKLabelNode = SKLabelNode()
    var purpleBlock:SKSpriteNode = SKSpriteNode()
    //------------------------------------------------
    //global booleans (RANDOM)
    let isTutorial: Bool = true
    var isCheckPointActive: Bool = false
    var collectibleFound:Bool = false
    var levelComplete:Bool = false
    
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
    override func didMove(to view: SKView)
    {
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
            
        }
        //checkpoint
        if let cp:checkpoint = self.childNode(withName: "checkpoint1") as? checkpoint
        {
            CheckPoint = cp
            CheckPoint.CheckPointPosition = CGPoint(x: CheckPoint.position.x, y: CheckPoint.position.y)
            CheckPoint.physicsBody!.categoryBitMask = blueblockCategory
            CheckPoint.physicsBody!.contactTestBitMask = blueblockCategory | playerCategory
        }
        //redblocks
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock1") as? SKSpriteNode
        {
            redBlock1 = someRedBlock
            redBlock1.physicsBody!.categoryBitMask = redblockCategory
            redBlock1.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock2") as? SKSpriteNode
        {
            redBlock2 = someRedBlock
            redBlock2.physicsBody!.categoryBitMask = redblockCategory
            redBlock2.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        //greenblocks
        if let someGreenBlock:SKSpriteNode = self.childNode(withName: "greenblock1") as? SKSpriteNode
        {
            greenblock1 = someGreenBlock
            greenblock1.physicsBody!.categoryBitMask = greenblockCategory
            greenblock1.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        //blackblocks
        if let someBlackBlock:SKSpriteNode = self.childNode(withName: "blackblock1") as? SKSpriteNode
        {
            blackblock1 = someBlackBlock
            blackblock1.physicsBody!.categoryBitMask = blackblockCategory
            blackblock1.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform: SKAction = SKAction.moveBy(x: 475.0, y: 0, duration: TimeInterval(3.0))
            blackblock1.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 1.0), moveplatform, SKAction.wait(forDuration: 1.0), moveplatform.reversed() ])))
        }
        //endblock
        if let theEndBlock:SKSpriteNode = self.childNode(withName: "EndBlock") as? SKSpriteNode
        {
            endblock1 = theEndBlock
            endblock1.physicsBody!.categoryBitMask = endblockCategory
            endblock1.physicsBody!.contactTestBitMask = endblockCategory | playerCategory
            
        }
        //death message
        if let theDeathLabel:SKLabelNode = self.childNode(withName: "deathlabel") as? SKLabelNode
        {
            deathLabel = theDeathLabel
            deathLabel.isHidden = true
        }
        //collectable purple block
        if let thepb:SKSpriteNode = self.childNode(withName: "purpleblock") as? SKSpriteNode
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
            deathLabel.position = thePlayer.position
            deathLabel.isHidden = false
            deathAnimation(thePlayer.physicsBody!.velocity, playerPosition:  thePlayer.position)
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(respawnPlayer)]))
            run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(hideDeathText)]))
            
        }
        //greenblocks
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == greenblockCategory)) || ((contact.bodyA.categoryBitMask == greenblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            print("bounce")
            thePlayer.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 100))
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
                let purpleRise = SKAction.moveBy(x: 0, y: 100, duration: 1)
                let purpleSpin = SKAction.repeatForever( SKAction.rotate(byAngle: 20, duration: 10))
                purpleBlock.run(purpleRise)
                purpleBlock.run(purpleSpin)
                collectibleFound = true
            }
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
    
    func endOfLevel()
    {
        let moveup: SKAction = SKAction.moveBy(x: 0.0, y: 250.0, duration: TimeInterval(1.5))
        endblock1.run(moveup)
        playerCamera.run(SKAction.scale(to: 2.0, duration: 3))
    }
    
    //respawn player at current respawn point
    func respawnPlayer()
    {
        thePlayer.position = thePlayer.RespawnPoint
        self.addChild(thePlayer)
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
            
            let moveup: SKAction = SKAction.moveBy(x: 0.0, y: 250.0, duration: TimeInterval(1.5))
            CheckPoint.run(moveup)
            
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
        playerCamera.position = CGPoint(x: thePlayer.position.x, y: thePlayer.position.y - 100)
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
            print("jump")
        }
        viewController.isJumping = false
        //-------------------------------------------------
        //left and right handling
        if(viewController.isLeft == true)
        {
            thePlayer.physicsBody!.applyImpulse(CGVector(dx: leftForce, dy: currentjumpForce))
        }
        else if(viewController.isRight == true)
        {
            thePlayer.physicsBody!.applyImpulse(CGVector(dx: rightForce, dy: currentjumpForce))
        }
        else
        {
            thePlayer.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: currentjumpForce))
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
