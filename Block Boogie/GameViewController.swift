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
import AVFoundation

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
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mainMenuButt: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var newgameButton: UIButton!
    
    @IBOutlet weak var newyesbutton: UIButton!
    @IBOutlet weak var newnobutton: UIButton!
    //---------------------------------------------------
    //Scene (this doesnt work...
    var currentScene:SKScene = SKScene()
    
    //transition to new scene
    var fadeWhite:SKTransition = SKTransition.fade(withDuration: 1.5)
    //---------------------------------------------------
    //player movement bools
    var isLeft = false
    var isRight = false
    var isJumping = false
    
    var isRespawning = false
    var areControllsOn = true
    var isMusicOn = true
    //---------------------------------------------------
    var levelNumber: Int = 0
    var audioPlayer : AVAudioPlayer! = nil
    //---------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let scene = menu(fileNamed:"menu") {
            if(isMusicOn == true)
            {
            let path = Bundle.main.path(forResource: "v2", ofType:"mp3")
            let fileURL = URL(fileURLWithPath: path!)
            try! audioPlayer = AVAudioPlayer(contentsOf: fileURL, fileTypeHint: nil)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            }
            // Configure the view.
            let skView = self.view as! SKView
            
            //theView = SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill

            
            skView.presentScene(scene)
            
            //make global reference for the current scene
            
            scene.viewController = self
            currentScene = scene
            
            //setup scene inital state
            currentScene.isPaused = false
            //hide other buttons
            musicButton.isHidden = true
            newgameButton.isHidden = true
            PauseButton.isHidden = true
            ToggleUIButton.isHidden = true
            RespawnButton.isHidden = true
            ExitButton.isHidden = true
            newnobutton.isHidden = true
            newyesbutton.isHidden = true
            
            LeftButton.backgroundColor? = UIColor.clear
            RightButton.backgroundColor? = UIColor.clear
            JumpButton.backgroundColor? = UIColor.clear

        }
    }
    //-------------------------------------------------
    //LEVEL TRANSITIONS
    //-------------------------------------------------
    //This takes you back to the hub world and saves player progress
    func goBackToHub()
    {
        PauseButton.isHidden = false
        
        let skView = self.view as! SKView
        let scene = OverWorldScene(fileNamed:"OverWorldScene")
        scene?.scaleMode = .aspectFill
        scene?.viewController = self
        skView.presentScene(scene!, transition: fadeWhite)
        currentScene = scene!
    }
    
    func switchToLevel()
    {
        //do music stuff!
        if(isMusicOn == true && levelNumber > 1 && levelNumber < 21)
        {
            var path = Bundle.main.path(forResource: "v1", ofType:"mp3")
            
            let rando = Int(arc4random_uniform(6) + 1)
            if(rando == 1)
            {
                path = Bundle.main.path(forResource: "v1", ofType:"mp3")
                
            }
            else if(rando == 2)
            {
                path = Bundle.main.path(forResource: "v3", ofType:"mp3")

            }
            else if(rando == 3)
            {
                path = Bundle.main.path(forResource: "nocturne", ofType:"mp3")

            }
            else if(rando == 4)
            {
                path = Bundle.main.path(forResource: "andante", ofType:"mp3")

            }
            else if(rando == 5)
            {
                path = Bundle.main.path(forResource: "bal1", ofType:"mp3")
                
            }
            else if(rando == 6)
            {
                path = Bundle.main.path(forResource: "num7", ofType:"mp3")
                
            }
            else
            {
                path = Bundle.main.path(forResource: "v2", ofType:"mp3")

            }
            
            let fileURL = URL(fileURLWithPath: path!)
            try! audioPlayer = AVAudioPlayer(contentsOf: fileURL, fileTypeHint: nil)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        
        
        PauseButton.isHidden = false
        
        let skView = self.view as! SKView
        if(levelNumber == 1)
        {
            let scene = level1(fileNamed: "level1")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 0)
        {
            let scene = level0(fileNamed: "level0")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }

        else if(levelNumber == 2)
        {
            let scene = level2(fileNamed: "level2")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 3)
        {
            let scene = level3(fileNamed: "level3")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 4)
        {
            let scene = level4(fileNamed: "level4")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 5)
        {
            let scene = level5(fileNamed: "level5")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 6)
        {
            let scene = level6(fileNamed: "level6")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 7)
        {
            let scene = level7(fileNamed: "level7")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 8)
        {
            let scene = level8(fileNamed: "level8")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 9)
        {
            let scene = level8(fileNamed: "level9")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 10)
        {
            let scene = level10(fileNamed: "level10")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 11)
        {
            let scene = level11(fileNamed: "level11")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 12)
        {
            let scene = level12(fileNamed: "level12")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 13)
        {
            let scene = level13(fileNamed: "level13")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 14)
        {
            let scene = level14(fileNamed: "level14")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 15)
        {
            let scene = level15(fileNamed: "level15")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 16)
        {
            let scene = level16(fileNamed: "level16")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 17)
        {
            let scene = level17(fileNamed: "level17")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 18)
        {
            let scene = level18(fileNamed: "level18")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 19)
        {
            let scene = level19(fileNamed: "level19")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 20)
        {
            let scene = level20(fileNamed: "level20")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        else if(levelNumber == 21)
        {
            let scene = level21(fileNamed: "level21")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }

        else
        {
            let scene = OverWorldScene(fileNamed: "OverWorldScene")
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            skView.presentScene(scene!, transition: fadeWhite)
            currentScene = scene!
        }
        
        
    }
    
    //-------------------------------------------------
    //player movement UI
    //-------------------------------------------------
    @IBAction func leftButtonPressed(_ sender: UIButton)
    {
        //print("left start")
        self.isLeft = true
        //print(currentScene.isLeft)
        if(areControllsOn == true)
        {
            LeftButton.backgroundColor? = UIColor(red: 255/255, green: 0, blue: 0, alpha: 0.5)
        }

    }
    
    @IBAction func leftButtonReleased(_ sender: UIButton)
    {
        //print("left end")
        self.isLeft = false
        if(areControllsOn == true)
        {
            LeftButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)

        }
        
    }
    @IBAction func leftButtonReleasedOutside(_ sender: UIButton)
    {
        //print("left end")
        self.isLeft = false
        if(areControllsOn == true)
        {
            LeftButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)
        }
    }
    
    @IBAction func RightButtonPressed(_ sender: UIButton)
    {
        //print("right start")
        self.isRight = true
        if(areControllsOn == true)
        {
            RightButton.backgroundColor? = UIColor(red: 0, green: 0, blue: 255/255, alpha: 0.5)
        }
    }
    
    @IBAction func RightButtonReleased(_ sender: UIButton)
    {
        //print("right end")
        self.isRight = false
        if(areControllsOn == true)
        {
            RightButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)

        }
    }
    
    @IBAction func RightButtonReleasedOutside(_ sender: UIButton)
    {
        //print("right end")
        self.isRight = false
        if(areControllsOn == true)
        {
            RightButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)

        }
    }
    
    @IBAction func JumpButttonPressed(_ sender: UIButton)
    {
        self.isJumping = true
        JumpButton.backgroundColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        print("jummmmmp")

    }
    
    //-------------------------------------------------
    //Pause and othrt UI
    //-------------------------------------------------
    @IBAction func PauseButtonPressed(_ sender: UIButton)
    {
        if(PauseButton.titleLabel?.text == "OPTIONS")
        {
            PauseButton.setTitle("OPTIONS|", for: UIControlState())
            //self.currentScene.paused = true
            
            //make visible all other buttons
            ToggleUIButton.isHidden = false
            RespawnButton.isHidden = false
            ExitButton.isHidden = false
        }
        else if(PauseButton.titleLabel?.text == "OPTIONS|")
        {
            PauseButton.setTitle("OPTIONS", for: UIControlState())
            //self.currentScene.paused = false
            
            //hide other buttons
            ToggleUIButton.isHidden = true
            RespawnButton.isHidden = true
            ExitButton.isHidden = true
        }
    }
    
    //toggleUI
    @IBAction func ToggleControls(_ sender: UIButton)
    {
        if(areControllsOn == false)
        {
            areControllsOn = true
            
            LeftButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)
            RightButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)
            JumpButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)
        }
        else
        {
            areControllsOn = false
            
            LeftButton.backgroundColor? = UIColor.clear
            RightButton.backgroundColor? = UIColor.clear
            JumpButton.backgroundColor? = UIColor.clear
        }
    }
    
    //respawn the player
    @IBAction func RespawnPlayer(_ sender: UIButton)
    {
        switchToLevel()
        
        
        
        //UNPAUSE GAME
        PauseButton.setTitle("OPTIONS", for: UIControlState())
        //self.currentScene.paused = false
        
        //hide other buttons
        ToggleUIButton.isHidden = true
        RespawnButton.isHidden = true
        ExitButton.isHidden = true

    }
    
    @IBAction func ExitLevel(_ sender: UIButton)
    {
        goBackToHub()
        
        PauseButton.setTitle("OPTIONS", for: UIControlState())
        //self.currentScene.paused = false
        PauseButton.isHidden = false
        //hide other buttons
        ToggleUIButton.isHidden = true
        RespawnButton.isHidden = true
        ExitButton.isHidden = true
    }
    
    //main menu buttons
    
    @IBAction func startGame(_ sender: UIButton)
    {
        startButton.isHidden = true
        mainMenuButt.isHidden = true
        musicButton.isHidden = true
        newgameButton.isHidden = true
        newnobutton.isHidden = true
        newyesbutton.isHidden = true
        
        
        LeftButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)
        RightButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)
        JumpButton.backgroundColor? = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 0.5)

        if(UserDefaults.standard.object(forKey: "level0") != nil)
        {
            levelNumber = -1

        }
        else
        {
            levelNumber = 0

        }

        switchToLevel()
        
    }
    
    @IBAction func mainMenuOptions(_ sender: UIButton)
    {
        if(mainMenuButt.titleLabel?.text == "OPTIONS")
        {
            mainMenuButt.setTitle("|OPTIONS|", for: UIControlState())
            musicButton.isHidden = false
            newgameButton.isHidden = false
        }
        else if(mainMenuButt.titleLabel?.text == "|OPTIONS|")
        {
            mainMenuButt.setTitle("OPTIONS", for: UIControlState())
            musicButton.isHidden = true
            newgameButton.isHidden = true
            newnobutton.isHidden = true
            newyesbutton.isHidden = true
        }

    }
    
    @IBAction func newgameSelected(_ sender: UIButton)
    {
        newyesbutton.isHidden = false
        newnobutton.isHidden = false
    }
    
    @IBAction func nonewgame(_ sender: UIButton)
    {
        newyesbutton.isHidden = true
        newnobutton.isHidden = true
    }
    
    @IBAction func yesnewgame(_ sender: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        newyesbutton.isHidden = true
        newnobutton.isHidden = true
        newgameButton.setTitle("SAVE DELETED", for: UIControlState())

    }
    
    @IBAction func MainMenuMusicAction(_ sender: UIButton) {
        if(musicButton.titleLabel?.text == "MUSIC IS ON")
        {
            musicButton.setTitle("MUSIC IS OFF", for: UIControlState())
            isMusicOn = false
            audioPlayer.stop()
            
        }
        else if(musicButton.titleLabel?.text == "MUSIC IS OFF")
        {
            musicButton.setTitle("MUSIC IS ON", for: UIControlState())
            isMusicOn = true
            audioPlayer.play()
            
        }

    }
    
    
    //Nonsense bull that I dont use!
    
    override var shouldAutorotate : Bool
    {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool
    {
        return true
    }
}
