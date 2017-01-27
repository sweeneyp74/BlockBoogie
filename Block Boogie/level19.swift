//
//  level19.swift
//  Block Boogie
//
//  Created by Patrick Sweeney on 8/7/16.
//  Copyright © 2016 Patrick Sweeney. All rights reserved.
//

import Foundation
import SpriteKit



//This will act as a template for other scenes
//it will include code for player movement and
class level19: SKScene, SKPhysicsContactDelegate
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
            print("playercheck")
            
        }
        //checkpoint
        if let cp:checkpoint = self.childNode(withName: "checkpoint1") as? checkpoint
        {
            CheckPoint = cp
            CheckPoint.CheckPointPosition = CGPoint(x: CheckPoint.position.x, y: CheckPoint.position.y + 75)
            CheckPoint.physicsBody!.categoryBitMask = blueblockCategory
            CheckPoint.physicsBody!.collisionBitMask = blueblockCategory | playerCategory
            CheckPoint.physicsBody!.contactTestBitMask = blueblockCategory | playerCategory
        }
        //purplefollowblock
        if let pbf:SKSpriteNode = self.childNode(withName: "purpleblockfollow") as? SKSpriteNode
        {
            followpurple = pbf
            followpurple.isHidden = true
        }
        //--------------------------------------------------------
        //whiteblock whitewhitewhitewhiteohsowhite
        if let someWhiteBlock1:SKSpriteNode = self.childNode(withName: "whiteblock1") as? SKSpriteNode
        {
            whiteblock1 = someWhiteBlock1
            whiteblock1.physicsBody!.categoryBitMask = whiteblockCategory
            whiteblock1.physicsBody!.collisionBitMask = 0
            whiteblock1.physicsBody!.contactTestBitMask = playerCategory | whiteblockCategory
        }
        if let someWhiteBlock2:SKSpriteNode = self.childNode(withName: "whiteblock2") as? SKSpriteNode
        {
            whiteblock2 = someWhiteBlock2
            whiteblock2.physicsBody!.categoryBitMask = whiteblockCategory
            whiteblock2.physicsBody!.collisionBitMask = 0
            whiteblock2.physicsBody!.contactTestBitMask = playerCategory | whiteblockCategory
        }
        if let someWhiteBlock3:SKSpriteNode = self.childNode(withName: "whiteblock3") as? SKSpriteNode
        {
            whiteblock3 = someWhiteBlock3
            whiteblock3.physicsBody!.categoryBitMask = whiteblockCategory
            whiteblock3.physicsBody!.collisionBitMask = 0
            whiteblock3.physicsBody!.contactTestBitMask = playerCategory | whiteblockCategory
        }
        
        //blueblocks
        if let someblueblock:SKSpriteNode = self.childNode(withName: "blueblock1") as? SKSpriteNode
        {
            blueblock1 = someblueblock
            blueblock1.physicsBody!.categoryBitMask = blueblockCategory2
            blueblock1.physicsBody!.collisionBitMask = playerCategory | blueblockCategory2
            blueblock1.physicsBody!.contactTestBitMask = blueblockCategory2 | playerCategory
            
        }
        if let someblueblock:SKSpriteNode = self.childNode(withName: "blueblock2") as? SKSpriteNode
        {
            blueblock2 = someblueblock
            blueblock2.physicsBody!.categoryBitMask = blueblockCategory3
            blueblock2.physicsBody!.collisionBitMask = playerCategory | blueblockCategory3
            blueblock2.physicsBody!.contactTestBitMask = blueblockCategory3 | playerCategory
            
        }
        //--------------------------------------------------------
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
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock3") as? SKSpriteNode
        {
            redBlock3 = someRedBlock
            redBlock3.physicsBody!.categoryBitMask = redblockCategory
            redBlock3.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock3.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove, redblockmove.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock4") as? SKSpriteNode
        {
            redBlock4 = someRedBlock
            redBlock4.physicsBody!.categoryBitMask = redblockCategory
            redBlock4.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock4.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove, redblockmove.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock5") as? SKSpriteNode
        {
            redBlock5 = someRedBlock
            redBlock5.physicsBody!.categoryBitMask = redblockCategory
            redBlock5.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            //redBlock5.runAction(SKAction.repeatActionForever(SKAction.sequence([redblockmove, redblockmove.reversedAction()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock6") as? SKSpriteNode
        {
            redBlock6 = someRedBlock
            redBlock6.physicsBody!.categoryBitMask = redblockCategory
            redBlock6.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock6.run(SKAction.repeatForever(SKAction.sequence([redblockmove, redblockmove2, redblockmove.reversed(), redblockmove2.reversed()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock7") as? SKSpriteNode
        {
            redBlock7 = someRedBlock
            redBlock7.physicsBody!.categoryBitMask = redblockCategory
            redBlock7.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock7.run(SKAction.repeatForever(SKAction.sequence([redblockmove, redblockmove2, redblockmove.reversed(), redblockmove2.reversed()])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock8") as? SKSpriteNode
        {
            redBlock8 = someRedBlock
            redBlock8.physicsBody!.categoryBitMask = redblockCategory
            redBlock8.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock9") as? SKSpriteNode
        {
            redBlock9 = someRedBlock
            redBlock9.physicsBody!.categoryBitMask = redblockCategory
            redBlock9.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock10") as? SKSpriteNode
        {
            redBlock10 = someRedBlock
            redBlock10.physicsBody!.categoryBitMask = redblockCategory
            redBlock10.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock11") as? SKSpriteNode
        {
            redBlock11 = someRedBlock
            redBlock11.physicsBody!.categoryBitMask = redblockCategory
            redBlock11.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock12") as? SKSpriteNode
        {
            redBlock12 = someRedBlock
            redBlock12.physicsBody!.categoryBitMask = redblockCategory
            redBlock12.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock13") as? SKSpriteNode
        {
            redBlock13 = someRedBlock
            redBlock13.physicsBody!.categoryBitMask = redblockCategory
            redBlock13.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock13.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: -100, duration: 4), SKAction.moveBy(x: 0, y: 100, duration: 0.5)])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock14") as? SKSpriteNode
        {
            redBlock14 = someRedBlock
            redBlock14.physicsBody!.categoryBitMask = redblockCategory
            redBlock14.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock14.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: -100, duration: 3), SKAction.moveBy(x: 0, y: 100, duration: 0.5)])))
            
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock15") as? SKSpriteNode
        {
            redBlock15 = someRedBlock
            redBlock15.physicsBody!.categoryBitMask = redblockCategory
            redBlock15.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock15.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: -100, duration: 2), SKAction.moveBy(x: 0, y: 100, duration: 0.5)])))
            
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock16") as? SKSpriteNode
        {
            redBlock16 = someRedBlock
            redBlock16.physicsBody!.categoryBitMask = redblockCategory
            redBlock16.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock16.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: -100, duration: 1), SKAction.moveBy(x: 0, y: 100, duration: 0.5)])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock17") as? SKSpriteNode
        {
            redBlock17 = someRedBlock
            redBlock17.physicsBody!.categoryBitMask = redblockCategory
            redBlock17.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock17.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: 150, duration: 1), SKAction.moveBy(x: 0, y: -150, duration: 2)])))
            
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock18") as? SKSpriteNode
        {
            redBlock18 = someRedBlock
            redBlock18.physicsBody!.categoryBitMask = redblockCategory
            redBlock18.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock18.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: 150, duration: 1), SKAction.moveBy(x: 0, y: -150, duration: 2)])))
            
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock19") as? SKSpriteNode
        {
            redBlock19 = someRedBlock
            redBlock19.physicsBody!.categoryBitMask = redblockCategory
            redBlock19.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock19.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: 150, duration: 1), SKAction.moveBy(x: 0, y: -150, duration: 2)])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock20") as? SKSpriteNode
        {
            redBlock20 = someRedBlock
            redBlock20.physicsBody!.categoryBitMask = redblockCategory
            redBlock20.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock20.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: -150, duration: 1), SKAction.moveBy(x: 0, y: 150, duration: 2)])))
            
            
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock21") as? SKSpriteNode
        {
            redBlock21 = someRedBlock
            redBlock21.physicsBody!.categoryBitMask = redblockCategory
            redBlock21.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock21.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: -150, duration: 1), SKAction.moveBy(x: 0, y: 150, duration: 2)])))
        }
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redblock22") as? SKSpriteNode
        {
            redBlock22 = someRedBlock
            redBlock22.physicsBody!.categoryBitMask = redblockCategory
            redBlock22.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            redBlock22.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: -100, y: 0, duration: 2), SKAction.moveBy(x: 100, y: 0, duration: 0.5)])))
            
        }
        //red spin BLOCK wooooooah so cool!!!!!!!!!!!
        if let someRedBlock:SKSpriteNode = self.childNode(withName: "redspin1") as? SKSpriteNode
        {
            redspin1 = someRedBlock
            redspin1.physicsBody!.categoryBitMask = redblockCategory
            redspin1.physicsBody!.contactTestBitMask = playerCategory | redblockCategory
            let redSpinAction = SKAction.repeatForever( SKAction.rotate(byAngle: 15, duration: 22))
            redspin1.run(redSpinAction)
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
        //blackblocks
        if let someBlackBlock:SKSpriteNode = self.childNode(withName: "blackblock1") as? SKSpriteNode
        {
            blackblock1 = someBlackBlock
            blackblock1.physicsBody!.categoryBitMask = blackblockCategory
            blackblock1.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform1: SKAction = SKAction.moveBy(x: 0, y: 200, duration: TimeInterval(6.0))
            blackblock1.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 0.5), moveplatform1, SKAction.wait(forDuration: 0.5), moveplatform1.reversed() ])))
        }
        if let someBlackBlock2:SKSpriteNode = self.childNode(withName: "blackblock2") as? SKSpriteNode
        {
            blackblock2 = someBlackBlock2
            blackblock2.physicsBody!.categoryBitMask = blackblockCategory
            blackblock2.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform2: SKAction = SKAction.moveBy(x: 0, y: 200, duration: TimeInterval(6.0))
            blackblock2.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 0.5), moveplatform2, SKAction.wait(forDuration: 0.5), moveplatform2.reversed() ])))
        }
        if let someBlackBlock3:SKSpriteNode = self.childNode(withName: "blackblock3") as? SKSpriteNode
        {
            blackblock3 = someBlackBlock3
            blackblock3.physicsBody!.categoryBitMask = blackblockCategory
            blackblock3.physicsBody!.contactTestBitMask = blackblockCategory | playerCategory
            
            let moveplatform3: SKAction = SKAction.moveBy(x: 0, y: 150, duration: TimeInterval(2.0))
            let moveplatform4: SKAction = SKAction.moveBy(x: -200, y: 0, duration: TimeInterval(2.0))
            blackblock3.run(SKAction.repeatForever(SKAction.sequence([ SKAction.wait(forDuration: 0.5), moveplatform3, moveplatform4, moveplatform3.reversed(), SKAction.wait(forDuration: 0.5), moveplatform3, moveplatform4.reversed(), moveplatform3.reversed() ])))
        }
        //endblock
        if let theEndBlock:SKSpriteNode = self.childNode(withName: "endblock") as? SKSpriteNode
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
        
        let levelbool = true
        UserDefaults.standard.set(levelbool, forKey:"level19")
        UserDefaults.standard.synchronize()
        
        if(collectibleFound == true)
        {
            UserDefaults.standard.set(levelbool, forKey:"block19")
            UserDefaults.standard.synchronize()
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
        
        if(collectibleFound == true)
        {
            followpurple.isHidden = false
        }
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
            
            
            let movecp: SKAction = SKAction.moveBy(x: 0, y: 0, duration: 1)
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
        //camera follow the player
        playerCamera.position = CGPoint(x: thePlayer.position.x, y: thePlayer.position.y + 150)
        thePlayer.physicsBody?.restitution = 0.0
        followpurple.position = CGPoint(x: thePlayer.position.x, y: thePlayer.position.y)
        
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
            
            followpurple.isHidden = true
            
        }
        
    }
    
    
}
