//
//  level8.swift
//  Block Boogie
//
//  Created by Patrick Sweeney on 6/5/16.
//  Copyright © 2016 Patrick Sweeney. All rights reserved.
//


import Foundation
import SpriteKit


class level8: SKScene, SKPhysicsContactDelegate
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
    let chaseblockCategory:UInt32 = 0x1 << 10
    //------------------------------------------------
    //global node declarations
    var playerCamera:SKCameraNode = SKCameraNode()
    var thePlayer:player = player()
    var CheckPoint:checkpoint = checkpoint()
    
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
    var redBlock23:SKSpriteNode = SKSpriteNode()
    var redBlock24:SKSpriteNode = SKSpriteNode()
    
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
    
    var chaseblock:SKSpriteNode = SKSpriteNode()
    //------------------------------------------------
    //global booleans (RANDOM)
    let isTutorial: Bool = false
    var isCheckPointActive: Bool = false
    var collectibleFound:Bool = false
    var levelComplete:Bool = false
    
    var chaseOngoing = false
    
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
    let redblockmove: SKAction = SKAction.moveByX(0, y: 415, duration: 0.5)
    let redblockmove2: SKAction = SKAction.moveByX(325, y: 0, duration: 1)
    
    let redblockmove3: SKAction = SKAction.moveByX(0, y: 612.61, duration: 0.75)
    let redblockmove4: SKAction = SKAction.moveByX(317.474, y: 0, duration: 1.25)
    
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
            thePlayer.physicsBody!.collisionBitMask = blueblockCategory | playerCategory | redblockCategory | blackblockCategory | blueblockCategory2 | blueblockCategory3 | endblockCategory | purpleblockCategory | chaseblockCategory
            print("playercheck")
            
        }
        //checkpoint
        if let cp:checkpoint = self.childNodeWithName("checkpoint1") as? checkpoint
        {
            CheckPoint = cp
            CheckPoint.CheckPointPosition = CGPointMake(CheckPoint.position.x - 100, CheckPoint.position.y)
            CheckPoint.physicsBody!.categoryBitMask = blueblockCategory
            CheckPoint.physicsBody!.collisionBitMask = blueblockCategory | playerCategory
            CheckPoint.physicsBody!.contactTestBitMask = blueblockCategory | playerCategory
        }
        //--------------------------------------------------------
        //chaseblock
        if let someChaseBlock:SKSpriteNode = self.childNodeWithName("startchaseblock") as? SKSpriteNode
        {
            chaseblock = someChaseBlock
            chaseblock.physicsBody!.categoryBitMask = chaseblockCategory
            chaseblock.physicsBody!.collisionBitMask = 0
            chaseblock.physicsBody!.contactTestBitMask = playerCategory | chaseblockCategory
        }
        //whiteblock whitewhitewhitewhiteohsowhite
        if let someWhiteBlock1:SKSpriteNode = self.childNodeWithName("whiteblock1") as? SKSpriteNode
        {
            whiteblock1 = someWhiteBlock1
            whiteblock1.physicsBody!.categoryBitMask = whiteblockCategory
            whiteblock1.physicsBody!.collisionBitMask = 0
            whiteblock1.physicsBody!.contactTestBitMask = playerCategory | whiteblockCategory
        }
        if let someWhiteBlock2:SKSpriteNode = self.childNodeWithName("whiteblock2") as? SKSpriteNode
        {
            whiteblock2 = someWhiteBlock2
            whiteblock2.physicsBody!.categoryBitMask = whiteblockCategory
            whiteblock2.physicsBody!.collisionBitMask = 0
            whiteblock2.physicsBody!.contactTestBitMask = playerCategory | whiteblockCategory
        }
        if let someWhiteBlock3:SKSpriteNode = self.childNodeWithName("whiteblock3") as? SKSpriteNode
        {
            whiteblock3 = someWhiteBlock3
            whiteblock3.physicsBody!.categoryBitMask = whiteblockCategory
            whiteblock3.physicsBody!.collisionBitMask = 0
            whiteblock3.physicsBody!.contactTestBitMask = playerCategory | whiteblockCategory
        }
        
        //blueblocks
        if let someblueblock:SKSpriteNode = self.childNodeWithName("blueblock1") as? SKSpriteNode
        {
            blueblock1 = someblueblock
            blueblock1.physicsBody!.categoryBitMask = blueblockCategory2
            blueblock1.physicsBody!.collisionBitMask = playerCategory | blueblockCategory2
            blueblock1.physicsBody!.contactTestBitMask = blueblockCategory2 | playerCategory
            
        }
        if let someblueblock:SKSpriteNode = self.childNodeWithName("blueblock2") as? SKSpriteNode
        {
            blueblock2 = someblueblock
            blueblock2.physicsBody!.categoryBitMask = blueblockCategory3
            blueblock2.physicsBody!.collisionBitMask = playerCategory | blueblockCategory3
            blueblock2.physicsBody!.contactTestBitMask = blueblockCategory3 | playerCategory
            
        }
        //--------------------------------------------------------
        //redblocks
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock1") as? SKSpriteNode
        {
            redBlock1 = someRedBlock
            redBlock1.physicsBody!.categoryBitMask = redblockCategory
            redBlock1.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock1.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove, redblockmove2, redblockmove.reversedAction(), redblockmove2.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock2") as? SKSpriteNode
        {
            redBlock2 = someRedBlock
            redBlock2.physicsBody!.categoryBitMask = redblockCategory
            redBlock2.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock2.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove.reversedAction(), redblockmove2.reversedAction(), redblockmove, redblockmove2 ])))
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock3") as? SKSpriteNode
        {
            redBlock3 = someRedBlock
            redBlock3.physicsBody!.categoryBitMask = redblockCategory
            redBlock3.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock3.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove3.reversedAction(), redblockmove4.reversedAction(), redblockmove3, redblockmove4])))
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock4") as? SKSpriteNode
        {
            redBlock4 = someRedBlock
            redBlock4.physicsBody!.categoryBitMask = redblockCategory
            redBlock4.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock4.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove3, redblockmove4, redblockmove3.reversedAction(), redblockmove4.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock5") as? SKSpriteNode
        {
            redBlock5 = someRedBlock
            redBlock5.physicsBody!.categoryBitMask = redblockCategory
            redBlock5.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock5.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove, redblockmove.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock6") as? SKSpriteNode
        {
            redBlock6 = someRedBlock
            redBlock6.physicsBody!.categoryBitMask = redblockCategory
            redBlock6.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock6.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove, redblockmove2, redblockmove.reversedAction(), redblockmove2.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock7") as? SKSpriteNode
        {
            redBlock7 = someRedBlock
            redBlock7.physicsBody!.categoryBitMask = redblockCategory
            redBlock7.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock7.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove, redblockmove2, redblockmove.reversedAction(), redblockmove2.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock8") as? SKSpriteNode
        {
            redBlock8 = someRedBlock
            redBlock8.physicsBody!.categoryBitMask = redblockCategory
            redBlock8.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock9") as? SKSpriteNode
        {
            redBlock9 = someRedBlock
            redBlock9.physicsBody!.categoryBitMask = redblockCategory
            redBlock9.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock10") as? SKSpriteNode
        {
            redBlock10 = someRedBlock
            redBlock10.physicsBody!.categoryBitMask = redblockCategory
            redBlock10.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock11") as? SKSpriteNode
        {
            redBlock11 = someRedBlock
            redBlock11.physicsBody!.categoryBitMask = redblockCategory
            redBlock11.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock12") as? SKSpriteNode
        {
            redBlock12 = someRedBlock
            redBlock12.physicsBody!.categoryBitMask = redblockCategory
            redBlock12.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock13") as? SKSpriteNode
        {
            redBlock13 = someRedBlock
            redBlock13.physicsBody!.categoryBitMask = redblockCategory
            redBlock13.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock14") as? SKSpriteNode
        {
            redBlock14 = someRedBlock
            redBlock14.physicsBody!.categoryBitMask = redblockCategory
            redBlock14.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock15") as? SKSpriteNode
        {
            redBlock15 = someRedBlock
            redBlock15.physicsBody!.categoryBitMask = redblockCategory
            redBlock15.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock16") as? SKSpriteNode
        {
            redBlock16 = someRedBlock
            redBlock16.physicsBody!.categoryBitMask = redblockCategory
            redBlock16.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock17") as? SKSpriteNode
        {
            redBlock17 = someRedBlock
            redBlock17.physicsBody!.categoryBitMask = redblockCategory
            redBlock17.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock18") as? SKSpriteNode
        {
            redBlock18 = someRedBlock
            redBlock18.physicsBody!.categoryBitMask = redblockCategory
            redBlock18.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock19") as? SKSpriteNode
        {
            redBlock19 = someRedBlock
            redBlock19.physicsBody!.categoryBitMask = redblockCategory
            redBlock19.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock20") as? SKSpriteNode
        {
            redBlock20 = someRedBlock
            redBlock20.physicsBody!.categoryBitMask = redblockCategory
            redBlock20.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            
            
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock21") as? SKSpriteNode
        {
            redBlock21 = someRedBlock
            redBlock21.physicsBody!.categoryBitMask = redblockCategory
            redBlock21.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
           
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock22") as? SKSpriteNode
        {
            redBlock22 = someRedBlock
            redBlock22.physicsBody!.categoryBitMask = redblockCategory
            redBlock22.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock23") as? SKSpriteNode
        {
            redBlock23 = someRedBlock
            redBlock23.physicsBody!.categoryBitMask = redblockCategory
            redBlock23.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            
        }
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redblock24") as? SKSpriteNode
        {
            redBlock24 = someRedBlock
            redBlock24.physicsBody!.categoryBitMask = redblockCategory
            redBlock24.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
           
            
        }

        //red spin BLOCK wooooooah so cool!!!!!!!!!!!
        if let someRedBlock:SKSpriteNode = self.childNodeWithName("redspin1") as? SKSpriteNode
        {
            redspin1 = someRedBlock
            redspin1.physicsBody!.categoryBitMask = redblockCategory
            redspin1.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            let redSpinAction = SKAction.repeatActionForever( SKAction.rotateByAngle(15, duration: 10))
            redspin1.runAction(redSpinAction)
        }
        
        
        /////////////////////////////////////////////////////////////////////////
        //greenblocks
        if let someGreenBlock:SKSpriteNode = self.childNodeWithName("greenblock1") as? SKSpriteNode
        {
            greenblock1 = someGreenBlock
            greenblock1.physicsBody!.categoryBitMask = greenblockCategory
            greenblock1.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        if let someGreenBlock:SKSpriteNode = self.childNodeWithName("greenblock2") as? SKSpriteNode
        {
            greenblock2 = someGreenBlock
            greenblock2.physicsBody!.categoryBitMask = greenblockCategory
            greenblock2.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        if let someGreenBlock:SKSpriteNode = self.childNodeWithName("greenblock3") as? SKSpriteNode
        {
            greenblock3 = someGreenBlock
            greenblock3.physicsBody!.categoryBitMask = greenblockCategory
            greenblock3.physicsBody!.contactTestBitMask = playerCategory | greenblockCategory
        }
        //blackblocks
        if let someBlackBlock:SKSpriteNode = self.childNodeWithName("blackblock1") as? SKSpriteNode
        {
            blackblock1 = someBlackBlock
            blackblock1.physicsBody!.categoryBitMask = blackblockCategory
            blackblock1.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform1: SKAction = SKAction.moveByX(0, y: 200, duration: NSTimeInterval(6.0))
            blackblock1.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(0.5), moveplatform1, SKAction.waitForDuration(0.5), moveplatform1.reversedAction() ])))
        }
        if let someBlackBlock2:SKSpriteNode = self.childNodeWithName("blackblock2") as? SKSpriteNode
        {
            blackblock2 = someBlackBlock2
            blackblock2.physicsBody!.categoryBitMask = blackblockCategory
            blackblock2.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform2: SKAction = SKAction.moveByX(0, y: 200, duration: NSTimeInterval(6.0))
            blackblock2.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(0.5), moveplatform2, SKAction.waitForDuration(0.5), moveplatform2.reversedAction() ])))
        }
        if let someBlackBlock3:SKSpriteNode = self.childNodeWithName("blackblock3") as? SKSpriteNode
        {
            blackblock3 = someBlackBlock3
            blackblock3.physicsBody!.categoryBitMask = blackblockCategory
            blackblock3.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform3: SKAction = SKAction.moveByX(0, y: 150, duration: NSTimeInterval(2.0))
            let moveplatform4: SKAction = SKAction.moveByX(-200, y: 0, duration: NSTimeInterval(2.0))
            blackblock3.runAction(SKAction.repeatActionForever(SKAction.sequence([ SKAction.waitForDuration(0.5), moveplatform3, moveplatform4, moveplatform3.reversedAction(), SKAction.waitForDuration(0.5), moveplatform3, moveplatform4.reversedAction(), moveplatform3.reversedAction() ])))
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
            //runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock(hideDeathText)]))
            
        }
        //greenblocks
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == greenblockCategory)) || ((contact.bodyA.categoryBitMask == greenblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            print("bounce")
            thePlayer.physicsBody!.applyImpulse(CGVectorMake(0, 250))
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
                let purpleRise = SKAction.moveByX(0, y: 50, duration: 1)
                let purpleSpin = SKAction.repeatActionForever( SKAction.rotateByAngle(20, duration: 10))
                purpleBlock.runAction(purpleRise)
                purpleBlock.runAction(purpleSpin)
                collectibleFound = true
                
            }
        }
        
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == whiteblockCategory)) || ((contact.bodyA.categoryBitMask == whiteblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            self.physicsWorld.gravity = (CGVectorMake(0, -2.0))
            isTouchingWhite = true
            //print("white and player touching")
        }
        
        //blueblocks
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == blueblockCategory2)) || ((contact.bodyA.categoryBitMask == blueblockCategory2) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if (blueblock1bool == false)
            {
                blueblock1bool = true
                blueblock1.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(0, y: 450, duration: 6), SKAction.waitForDuration(2), SKAction.moveByX(0, y: -450, duration: 6), SKAction.waitForDuration(2)])))
            }
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == blueblockCategory3)) || ((contact.bodyA.categoryBitMask == blueblockCategory3 ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if (blueblock2bool == false)
            {
                blueblock2bool = true
                blueblock2.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(0, y:-350 , duration: 6), SKAction.moveByX(0, y: 350, duration: 6)])))
            }
        }
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == chaseblockCategory)) || ((contact.bodyA.categoryBitMask == chaseblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            if (chaseOngoing == false)
            {
                chaseOngoing = true
                chaseblock.runAction(SKAction.moveByX(0, y: 7800, duration: 60))
            }
        }
        
    }
    
    //contact ends between two nodes!
    func didEndContact(contact: SKPhysicsContact)
    {
        if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == whiteblockCategory)) || ((contact.bodyA.categoryBitMask == whiteblockCategory ) && (contact.bodyB.categoryBitMask == playerCategory)))
        {
            self.physicsWorld.gravity = (CGVectorMake(0, -9.8))
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
        deathLabel.hidden = true
    }
    
    func endOfLevel()
    {
        let move: SKAction = SKAction.moveByX(0, y: 400, duration: NSTimeInterval(2))
        endblock1.runAction(move)
        playerCamera.runAction(SKAction.scaleTo(2.0, duration: 3))
        runAction(SKAction.sequence([SKAction.waitForDuration(3.5), SKAction.runBlock(goBackToHub)]))
        
        let levelbool = true
        NSUserDefaults.standardUserDefaults().setObject(levelbool, forKey:"level8")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if(collectibleFound == true)
        {
            NSUserDefaults.standardUserDefaults().setObject(levelbool, forKey:"block8")
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
        //reset normal movement
        self.physicsWorld.gravity = (CGVectorMake(0, -9.8))
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
        viewController.levelNumber = 8
        viewController.switchToLevel()
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
            
            
            let movecp: SKAction = SKAction.moveByX(0, y: 750, duration: 1)
            CheckPoint.runAction(SKAction.repeatActionForever( SKAction.sequence([movecp, SKAction.waitForDuration(1.5), movecp.reversedAction(), SKAction.waitForDuration(1.5)])))
            
        }
        
    }
    //reset chase
    func resetChase()
    {
        redBlock6.position = CGPoint(x: 1857.474, y: 6286.667)
        chaseOngoing = false
    }
    
    
    //Creates four splintering blocks upon death
    func deathAnimation(playerVelocity: CGVector, playerPosition: CGPoint)
    {
        
        thePlayer.removeFromParent()
        
        let block1 = SKSpriteNode()
        block1.size = CGSizeMake(25, 25)
        block1.color = UIColor(red:1.00, green:0.20, blue:0.40, alpha:1.0)
        block1.position = playerPosition
        block1.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block1.physicsBody!.velocity = playerVelocity
        block1.physicsBody!.restitution = CGFloat(0.5)
        deathBlock1 = block1
        
        let block2 = SKSpriteNode()
        block2.size = CGSizeMake(25, 25)
        block2.color = UIColor(red:1.00, green:0.20, blue:0.40, alpha:1.0)
        block2.position = CGPointMake((playerPosition.x + 25.0), (playerPosition.y - 25.0))
        block2.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block2.physicsBody!.velocity = playerVelocity
        block2.physicsBody!.restitution = CGFloat(0.5)
        deathBlock2 = block2
        
        let block3 = SKSpriteNode()
        block3.size = CGSizeMake(25, 25)
        block3.color = UIColor(red:1.00, green:0.20, blue:0.40, alpha:1.0)
        block3.position = CGPointMake((playerPosition.x), (playerPosition.y - 25.0))
        block3.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block3.physicsBody!.velocity = playerVelocity
        block3.physicsBody!.restitution = CGFloat(0.5)
        deathBlock3 = block3
        
        let block4 = SKSpriteNode()
        block4.size = CGSizeMake(25, 25)
        block4.color = UIColor(red:1.00, green:0.20, blue:0.40, alpha:1.0)
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
            //print("jump")
        }
        if(viewController.isJumping && isTouchingWhite == true)
        {
            currentjumpForce = 20.0
            viewController.isJumping = false
            //print("swim")
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
    }
    
    
}

