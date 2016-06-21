//
//  GameViewController.swift
//  Block Boogie
//
//  Created by Patrick Sweeney on 5/18/16.
//  Copyright (c) 2016 Patrick Sweeney. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class GameViewController: UIViewController {

    //---------------------------------------------------
    //BUTTON OBJECT REFERENCES
    //---------------------------------------------------
    @IBOutlet weak var LeftButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    @IBOutlet weak var JumpButton: UIButton!
    
    @IBOutlet weak var PauseButton: UIButton!
    @IBOutlet weak var ToggleUIButton: UIButton!
    @IBOutlet weak var RespawnButton: UIButton!
    @IBOutlet weak var ExitButton: UIButton!
    //---------------------------------------------------
    //Scene (this doesnt work...
    var currentScene:SKScene = SKScene()
    
    //transition to new scene
    var fadeWhite:SKTransition = SKTransition.fadeWithColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1.0), duration: 3)
    //---------------------------------------------------
    //player movement bools
    var isLeft = false
    var isRight = false
    var isJumping = false
    
    var isRespawning = false
    var areControllsOn = false
    //---------------------------------------------------
    var levelNumber: Int = 0
    //---------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let scene = OverWorldScene(fileNamed:"OverWorldScene") {
            
            // Configure the view.
            let skView = self.view as! SKView
            
            //theView = SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill

            
            skView.presentScene(scene)
            
            //make global reference for the current scene
            
            scene.viewController = self
            currentScene = scene
            
            //setup scene inital state
            currentScene.paused = false
            //hide other buttons
            ToggleUIButton.hidden = true
            RespawnButton.hidden = true
            ExitButton.hidden = true
            
            
            if(scene.isTutorial == true)
            {
                print("colored In")
                LeftButton.backgroundColor? = UIColor(red: 0, green: 255, blue: 0, alpha: 1.0)
                RightButton.backgroundColor? = UIColor(red: 0, green: 0, blue: 255, alpha: 1.0)
                JumpButton.backgroundColor? = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
                
            }
            else
            {
                LeftButton.backgroundColor? = UIColor.clearColor()
                RightButton.backgroundColor? = UIColor.clearColor()
                JumpButton.backgroundColor? = UIColor.clearColor()

            }
        }
    }
    //-------------------------------------------------
    //LEVEL TRANSITIONS
    //-------------------------------------------------
    //This takes you back to the hub world and saves player progress
    func goBackToHub()
    {
        let skView = self.view as! SKView
        let scene = OverWorldScene(fileNamed:"OverWorldScene")
        scene?.scaleMode = .AspectFill
        scene?.viewController = self
        skView.presentScene(scene!, transition: fadeWhite)
        currentScene = scene!
    }
    
    func switchToLevel()
    {
        let skView = self.view as! SKView
        if(levelNumber == 1)
        {
            let scene = level1(fileNamed: "level1")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 2)
        {
            let scene = level2(fileNamed: "level2")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 3)
        {
            let scene = level3(fileNamed: "level3")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 4)
        {
            let scene = level4(fileNamed: "level4")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 5)
        {
            let scene = level5(fileNamed: "level5")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 6)
        {
            let scene = level6(fileNamed: "level6")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 7)
        {
            let scene = level7(fileNamed: "level7")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 8)
        {
            let scene = level8(fileNamed: "level8")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 9)
        {
            let scene = level8(fileNamed: "level9")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else
        {
            let scene = OverWorldScene(fileNamed: "OverWorldScene")
            scene?.scaleMode = .AspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        
        
    }
    
    //-------------------------------------------------
    //player movement UI
    //-------------------------------------------------
    @IBAction func leftButtonPressed(sender: UIButton)
    {
        //print("left start")
        self.isLeft = true
        //print(currentScene.isLeft)
    }
    
    @IBAction func leftButtonReleased(sender: UIButton)
    {
        //print("left end")
        self.isLeft = false
        
    }
    @IBAction func leftButtonReleasedOutside(sender: UIButton)
    {
        //print("left end")
        self.isLeft = false
    }
    
    @IBAction func RightButtonPressed(sender: UIButton)
    {
        //print("right start")
        self.isRight = true
    }
    
    @IBAction func RightButtonReleased(sender: UIButton)
    {
        //print("right end")
        self.isRight = false
    }
    
    @IBAction func RightButtonReleasedOutside(sender: UIButton)
    {
        //print("right end")
        self.isRight = false
    }
    
    @IBAction func JumpButttonPressed(sender: UIButton)
    {
        self.isJumping = true
    }
    
    //-------------------------------------------------
    //Pause and othrt UI
    //-------------------------------------------------
    @IBAction func PauseButtonPressed(sender: UIButton)
    {
        if(PauseButton.titleLabel?.text == "PAUSE")
        {
            PauseButton.setTitle("UNPAUSE", forState: UIControlState.Normal)
            self.currentScene.paused = true
            
            //make visible all other buttons
            ToggleUIButton.hidden = false
            RespawnButton.hidden = false
            ExitButton.hidden = false
        }
        else if(PauseButton.titleLabel?.text == "UNPAUSE")
        {
            PauseButton.setTitle("PAUSE", forState: UIControlState.Normal)
            self.currentScene.paused = false
            
            //hide other buttons
            ToggleUIButton.hidden = true
            RespawnButton.hidden = true
            ExitButton.hidden = true
        }
    }
    
    //toggleUI
    @IBAction func ToggleControls(sender: UIButton)
    {
        if(areControllsOn == false)
        {
            areControllsOn = true
            
            LeftButton.backgroundColor? = UIColor(red: 0, green: 255, blue: 0, alpha: 0.5)
            RightButton.backgroundColor? = UIColor(red: 0, green: 0, blue: 255, alpha: 0.5)
            JumpButton.backgroundColor? = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
        }
        else
        {
            areControllsOn = false
            
            LeftButton.backgroundColor? = UIColor.clearColor()
            RightButton.backgroundColor? = UIColor.clearColor()
            JumpButton.backgroundColor? = UIColor.clearColor()
        }
    }
    
    //respawn the player
    @IBAction func RespawnPlayer(sender: UIButton)
    {
        switchToLevel()
        
        
        
        //UNPAUSE GAME
        PauseButton.setTitle("PAUSE", forState: UIControlState.Normal)
        self.currentScene.paused = false
        
        //hide other buttons
        ToggleUIButton.hidden = true
        RespawnButton.hidden = true
        ExitButton.hidden = true

    }
    
    @IBAction func ExitLevel(sender: UIButton)
    {
        goBackToHub()
        
        PauseButton.setTitle("PAUSE", forState: UIControlState.Normal)
        self.currentScene.paused = false
        
        //hide other buttons
        ToggleUIButton.hidden = true
        RespawnButton.hidden = true
        ExitButton.hidden = true
    }
    
    
    
    
    
    
    //Nonsense bull that I dont use!
    
    override func shouldAutorotate() -> Bool
    {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
}
