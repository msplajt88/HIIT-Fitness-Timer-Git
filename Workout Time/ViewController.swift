//
//  ViewController.swift
//  Workout Time
//
//  Created by Marko Splajt on 01/06/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData
import AVFoundation

var backingAudio = AVAudioPlayer()

class ViewController: UIViewController {
    
    //var interstitialAd: GADInterstitial?
    
    var git = "Git test"

    struct StopTapped {
        static let adRate = 5
    }
    
    struct WorkEnd {
        static let adRate = 1
    }
    
    //var bannerView = GADBannerView()
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var backgroundWeight: UIImageView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var getReadyLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var restLabelOutlet: UILabel!
    @IBOutlet weak var exerciseLabelOutlet: UILabel!
    @IBOutlet weak var roundsLabelOutlet: UILabel!
    @IBOutlet weak var activeWorkTime: UILabel!
    @IBOutlet weak var activeRestTime: UILabel!
    @IBOutlet weak var activeRoundsRestTime: UILabel!
    @IBOutlet weak var roundsRestLabel: UILabel!
    
    var timer = Timer()
    var workTimer = Timer()
    var restTimer = Timer()
    var exercisesTimer = Timer()
    var roundsTimer = Timer()
    var roundsRestTimer = Timer()
    
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var roundsRestTimeLabel: UILabel!
    
    let defaults = UserDefaults()
    
    // Start counters
    var mainSecondsStart = 6
    var secondsStart = 60
    var restStart = 30
    var exercisesStart = 10
    var roundsStart = 5
    var roundsRestStart = 60
    
    // Current counters. Values are set in "resetValues()" function
    var mainSeconds = 0
    var seconds = 0
    var rest = 0
    var exercises = 0
    var rounds = 0
    var roundsRest = 0
    
    // Is the exercise playing
    var isPlaying = false
    
    // Reset current counter values back to their starting values
    func resetValues() {
        mainSeconds = mainSecondsStart
        
        seconds = secondsStart
        workLabel.text = String(secondsStart) + " s"
        
        activeWorkTime.text = String(secondsStart)
        
        rest = restStart
        restLabel.text = String(restStart) + " s"
        
        exercises = exercisesStart
        exerciseLabel.text = String(exercisesStart)
        
        rounds = roundsStart
        roundsLabel.text = String(roundsStart)
        
        roundsRest = roundsRestStart
        roundsRestTimeLabel.text = String(roundsRestStart) + " s"
    }
    
    @IBOutlet weak var workSliderOutlet: UISlider!
    @IBAction func workSlider(_ sender: UISlider) {
        if(!isPlaying) {
            secondsStart = Int(sender.value)
            workLabel.text = String(secondsStart) + " s"
            
            activeWorkTime.text = String(secondsStart)
            
            /*UIView.animate(withDuration: TimeInterval(secondsStart), animations: {() in self.workSliderOutlet.setValue(Float(self.secondsStart), animated: true)})*/
        }
    }
    
    @IBOutlet weak var restSliderOutlet: UISlider!
    @IBAction func restSlider(_ sender: UISlider) {
        if(!isPlaying) {
            restStart = Int(sender.value)
            restLabel.text = String(restStart) + " s"
            
            activeRestTime.text = String(restStart)
        }
    }
    
    @IBOutlet weak var exerciseSliderOutlet: UISlider!
    @IBAction func exerciseSlider(_ sender: UISlider) {
        if(!isPlaying) {
            exercisesStart = Int(sender.value)
            exerciseLabel.text = String(exercisesStart)
        }
    }
    
    @IBOutlet weak var roundsSliderOutlet: UISlider!
    @IBAction func roundsSlider(_ sender: UISlider) {
        if(!isPlaying) {
            roundsStart = Int(sender.value)
            roundsLabel.text = String(roundsStart)
        }
    }
    
    
    @IBOutlet weak var roundsRestSliderOutlet: UISlider!
    @IBAction func roundsRestSlider(_ sender: UISlider) {
        if(!isPlaying) {
            roundsRestStart = Int(sender.value)
            roundsRestTimeLabel.text = String(roundsRestStart) + " s"
            
            activeRoundsRestTime.text = String(roundsRestStart)
        }
    }
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func start(_ sender: Any) {
        isPlaying = true
        
        resetValues()
        runTimer()
        updateTimer()
        
        timerLabel.isHidden = false
        getReadyLabel.isHidden = false
        
        startButton.isHidden = true
        
        startOutlet.isEnabled = false
        workSliderOutlet.isEnabled = false
        restSliderOutlet.isEnabled = false
        exerciseSliderOutlet.isEnabled = false
        roundsSliderOutlet.isEnabled = false
        roundsRestSliderOutlet.isEnabled = false
        creditsButton.isEnabled = false
        
        getReadyAudio.play()
    }
    
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func stop(_ sender: Any) {
        isPlaying = false
        resetValues()
        
        startButton.isHidden = false
        creditsButton.isEnabled = true
        
        //randomPresentationOfAdWithFrequency(oneIn: StopTapped.adRate)
        
        getReadyLabel.isHidden = true
        timer.invalidate()
        workTimer.invalidate()
        restTimer.invalidate()
        exercisesTimer.invalidate()
        roundsTimer.invalidate()
        roundsRestTimer.invalidate()
        startOutlet.isEnabled = true
        workSliderOutlet.isEnabled = true
        restSliderOutlet.isEnabled = true
        exerciseSliderOutlet.isEnabled = true
        roundsSliderOutlet.isEnabled = true
        roundsRestSliderOutlet.isEnabled = true
        
        workSliderOutlet.setValue(Float(seconds), animated: true)
        workLabel.text = String(seconds) + " s"
        
        activeWorkTime.isHidden = true
        activeWorkTime.text = String(seconds)
        
        activeRestTime.isHidden = true
        activeRestTime.text = String(rest)
        
        activeRoundsRestTime.isHidden = true
        activeRoundsRestTime.text = String(roundsRest)
        
        restSliderOutlet.setValue(Float(rest), animated: true)
        restLabel.text = String(rest) + " s"
        
        exerciseSliderOutlet.setValue(Float(exercises), animated: true)
        exerciseLabel.text = String(exercises)
        
        roundsSliderOutlet.setValue(Float(rounds), animated: true)
        roundsLabel.text = String(rounds)
        
        roundsRestSliderOutlet.setValue(Float(roundsRest), animated: true)
        roundsRestTimeLabel.text = String(roundsRest) + " s"
        
        timerLabel.isHidden = true
        timerLabel.text = String(mainSeconds)
    }
    
    var getReadyAudio = AVAudioPlayer()
    var workAudio = AVAudioPlayer()
    var restAudio = AVAudioPlayer()
    var roundRestAudio = AVAudioPlayer()
    
    func getReadyPlaySound() {
        do {
            getReadyAudio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "getReady", ofType: "mp3")!))
            getReadyAudio.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        getReadyAudio.volume = 3
    }
    
    func workPlaySound() {
        do {
            workAudio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "work", ofType: "mp3")!))
            workAudio.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        workAudio.volume = 3
    }
    
    func restPlaySound() {
        do {
            restAudio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "rest", ofType: "mp3")!))
            restAudio.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        restAudio.volume = 3
    }
    
    func roundRestPlaySound() {
        do {
            roundRestAudio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "roundRest", ofType: "mp3")!))
            roundRestAudio.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        roundRestAudio.volume = 3
    }
    
    @IBAction func creditsButtonClicked(_ sender: UIButton) {
        backingAudio.stop()
    }
    
    @objc func updateTimer() {
        mainSeconds -= 1
        timerLabel.text = "\(mainSeconds)"
        
        if mainSeconds == 0 {
            getReadyLabel.isHidden  = true
            
            activeWorkTime.isHidden = false
            activeRestTime.isHidden = true
            activeRoundsRestTime.isHidden = true
            
            timer.invalidate()
            timerLabel.isHidden = true
            
            updateWorkCounter()
            
            workAudio.play()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func workCounter() {
        seconds -= 1
        workLabel.text = String(seconds) + " s"
        
        activeWorkTime.text = String(seconds)
        
        if (seconds == 0) {
            rest = restStart
            restLabel.text = String(rest) + " s"
            
            workTimer.invalidate()
            
            activeWorkTime.isHidden = true
            activeRestTime.isHidden = false
            
            updateRestCounter()
            updateExerciseCounter()
            
            restAudio.play()
        }
    }
    
    @objc func updateWorkCounter() {
        workTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.workCounter), userInfo: nil, repeats: true)
    }
    
    @objc func restCounter() {
        rest -= 1
        restLabel.text = String(rest) + " s"
        
        activeRestTime.text = String(rest)
        
        if (rest == 0) {
            restTimer.invalidate()
            
            activeWorkTime.isHidden = false
            activeRestTime.isHidden = true
            activeRoundsRestTime.isHidden = true
            
            seconds = secondsStart
            workLabel.text = String(seconds) + " s"
            
            rest = restStart
            restLabel.text = String(restStart) + " s"
            
            activeWorkTime.text = String(seconds)
            activeRestTime.text = String(rest)
            activeRoundsRestTime.text = String(roundsRest)
            
            updateWorkCounter()
            
            workAudio.play()
     
            // Reset when rest is done and only if current number of exercises is 0
            if(exercises == 0) {
                workTimer.invalidate()
                restTimer.invalidate()
                exercises = exercisesStart
                exerciseLabel.text = String(exercises)
                
                activeWorkTime.isHidden = true
                activeRestTime.isHidden = true
                activeRoundsRestTime.isHidden = false
                
                activeWorkTime.text = String(seconds)
                activeRestTime.text = String(rest)
                activeRoundsRestTime.text = String(roundsRest)
                
                roundsCounter()
                updateRoundsRestCounter()
                
                roundRestAudio.play()
                workAudio.stop()
                
                if (rounds == 0) {
                    print("End")
                    
                    workEnd()
                    
                    startButton.isHidden = false
                    creditsButton.isEnabled = true
                    
                    //randomPresentationOfAdWithFrequency(oneIn: WorkEnd.adRate)
                    
                    roundsTimer.invalidate()
                    exercisesTimer.invalidate()
                    workTimer.invalidate()
                    restTimer.invalidate()
                    timer.invalidate()
                    
                    getReadyLabel.isHidden = true
                    timerLabel.isHidden = true
                    startOutlet.isEnabled = true
                    workSliderOutlet.isEnabled = true
                    restSliderOutlet.isEnabled = true
                    exerciseSliderOutlet.isEnabled = true
                    roundsSliderOutlet.isEnabled = true
                    roundsRestSliderOutlet.isEnabled = true
                    activeWorkTime.isHidden = true
                    activeRestTime.isHidden = true
                    activeRoundsRestTime.isHidden = true
                    
                    isPlaying = false;
                    
                    workSliderOutlet.setValue(Float(secondsStart), animated: true)
                    workLabel.text = String(secondsStart) + " s"
                    
                    activeWorkTime.text = String(secondsStart)
                    activeRestTime.text = String(restStart)
                    activeRoundsRestTime.text = String(roundsRestStart)
                    
                    restSliderOutlet.setValue(Float(restStart), animated: true)
                    restLabel.text = String(restStart) + " s"
                    
                    exerciseSliderOutlet.setValue(Float(exercisesStart), animated: true)
                    exerciseLabel.text = String(exercisesStart)
                    
                    roundsSliderOutlet.setValue(Float(roundsStart), animated: true)
                    roundsLabel.text = String(roundsStart)
                    
                    roundsRestSliderOutlet.setValue(Float(roundsRestStart), animated: true)
                    roundsRestTimeLabel.text = String(roundsRestStart) + " s"
                    
                    timerLabel.isHidden = true
                    timerLabel.text = String(mainSecondsStart)
                }
                else {
                    print("Next round")
                }
            }
        }
    }
    
    @objc func updateRestCounter() {
        restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.restCounter), userInfo: nil, repeats: true)
    }
    
    @objc func exerciseCounter() {
        exercises -= 1
        exerciseLabel.text = String(exercises)
        
        print("Exercises " + String(exercises));
        
    }
    
    func updateExerciseCounter() {
        exercisesTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.exerciseCounter), userInfo: nil, repeats: false)
    }
    
    @objc func roundsCounter() {
        rounds -= 1
        roundsLabel.text = String(rounds)
    }
    
    func updateRoundsRestCounter() {
        roundsRestTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.roundsRestCounter), userInfo: nil, repeats: true)
    }
    
    @objc func roundsRestCounter() {
        roundsRest -= 1
        roundsRestTimeLabel.text = String(roundsRest) + " s"
        
        activeRoundsRestTime.text = String(roundsRest)
 
            if (roundsRest == 0) {
                roundsRestTimer.invalidate()
                
                isPlaying = false
            
                roundsRest = roundsRestStart
                roundsRestTimeLabel.text = String(roundsRestStart) + " s"
                
                activeWorkTime.isHidden = false
                activeRoundsRestTime.isHidden = true
            
                updateWorkCounter()
                
                workAudio.play()
            }
    }
    
    func workEnd() {
        
        if (rounds == 0) {
        isPlaying = false
        resetValues()
        
        startButton.isHidden = false
            
        roundRestAudio.stop()
        
        //randomPresentationOfAdWithFrequency(oneIn: WorkEnd.adRate)
        
        getReadyLabel.isHidden = true
        timer.invalidate()
        workTimer.invalidate()
        restTimer.invalidate()
        exercisesTimer.invalidate()
        roundsTimer.invalidate()
        roundsRestTimer.invalidate()
        
        startOutlet.isEnabled = true
        workSliderOutlet.isEnabled = true
        restSliderOutlet.isEnabled = true
        exerciseSliderOutlet.isEnabled = true
        roundsSliderOutlet.isEnabled = true
        roundsRestSliderOutlet.isEnabled = true
        
        activeWorkTime.isHidden = true
        activeRestTime.isHidden = true
        activeRoundsRestTime.isHidden = true
        
        workSliderOutlet.setValue(Float(seconds), animated: true)
        workLabel.text = String(seconds) + " s"
        
        activeWorkTime.text = String(seconds)
        activeRestTime.text = String(rest)
        activeRoundsRestTime.text = String(roundsRest)
        
        restSliderOutlet.setValue(Float(rest), animated: true)
        restLabel.text = String(rest) + " s"
        
        exerciseSliderOutlet.setValue(Float(exercises), animated: true)
        exerciseLabel.text = String(exercises)
        
        roundsSliderOutlet.setValue(Float(rounds), animated: true)
        roundsLabel.text = String(rounds)
        
        roundsRestSliderOutlet.setValue(Float(roundsRest), animated: true)
        roundsRestTimeLabel.text = String(roundsRest) + " s"
        
        timerLabel.isHidden = true
        timerLabel.text = String(mainSeconds)
        }
    }
    
    /*func createAndLoadInterstitial() -> GADInterstitial {
        let request = GADRequest()
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-7711507841405386/4809351665")
        interstitial.delegate = self
        interstitial.load(request)
        return interstitial
        
        // real: ca-app-pub-7711507841405386/4809351665
        
        // test: ca-app-pub-3940256099942544/4411468910
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitialAd = createAndLoadInterstitial()
    }
    
    func randomNumberInRange(lower: Int, upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func randomPresentationOfAdWithFrequency(oneIn: Int) {
        let randomNumber = randomNumberInRange(lower: 1, upper: oneIn)
        
        print("Random number: \(randomNumber)")
        
        if randomNumber == 1 {
            if interstitialAd != nil {
                if interstitialAd!.isReady {
                    interstitialAd?.present(fromRootViewController: self)
                    print("Ad presented")
                } else {
                    print("Ad was not ready for presentation")
                }
            }
        }
    }*/
    
    func reverse(text: String) -> String {
        return String(text.reversed())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(reverse(text: "stressed"))
        
        definesPresentationContext = true
        creditsButton.isEnabled = true
                
        getReadyPlaySound()
        workPlaySound()
        restPlaySound()
        roundRestPlaySound()
        
        let filePath = Bundle.main.path(forResource: "backgroundSound", ofType: "mp3")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)
        
        do {
            backingAudio = try AVAudioPlayer(contentsOf: audioNSURL as URL)
        } catch {
            return print("Cannot Find The Audio")
        }
        
        backingAudio.numberOfLoops = -1
        backingAudio.volume = 1
        backingAudio.play()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.ignoresSiblingOrder = false
        skView.showsNodeCount = false
        skView.presentScene(scene)
        scene.scaleMode = .aspectFill
        
        // real: ca-app-pub-7711507841405386/1774421062
        // test: ca-app-pub-3940256099942544/6300978111
        
        /*bannerView.adUnitID = "ca-app-pub-7711507841405386/1774421062"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())*/
        
        // real: ca-app-pub-7711507841405386/1774421062
        
        // test: ca-app-pub-3940256099942544/6300978111
        
        /*let requestAd: GADRequest = GADRequest()
        requestAd.testDevices = [kGADSimulatorID]*/
        
        //interstitialAd = createAndLoadInterstitial()
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let thumbImageNormal = UIImage(named: "weight")
        let thumbImageHighlighted = UIImage(named: "weightH")
        let trackLeftImage = UIImage(named: "sliderLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        let trackRightImage = UIImage(named: "sliderRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        
        workSliderOutlet.setThumbImage(thumbImageNormal, for: .normal)
        workSliderOutlet.setThumbImage(thumbImageHighlighted, for: .highlighted)
        workSliderOutlet.setMinimumTrackImage(trackLeftResizable, for: .normal)
        workSliderOutlet.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        restSliderOutlet.setThumbImage(thumbImageNormal, for: .normal)
        restSliderOutlet.setThumbImage(thumbImageHighlighted, for: .highlighted)
        restSliderOutlet.setMinimumTrackImage(trackLeftResizable, for: .normal)
        restSliderOutlet.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        exerciseSliderOutlet.setThumbImage(thumbImageNormal, for: .normal)
        exerciseSliderOutlet.setThumbImage(thumbImageHighlighted, for: .highlighted)
        exerciseSliderOutlet.setMinimumTrackImage(trackLeftResizable, for: .normal)
        exerciseSliderOutlet.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        roundsSliderOutlet.setThumbImage(thumbImageNormal, for: .normal)
        roundsSliderOutlet.setThumbImage(thumbImageHighlighted, for: .highlighted)
        roundsSliderOutlet.setMinimumTrackImage(trackLeftResizable, for: .normal)
        roundsSliderOutlet.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        roundsRestSliderOutlet.setThumbImage(thumbImageNormal, for: .normal)
        roundsRestSliderOutlet.setThumbImage(thumbImageHighlighted, for: .highlighted)
        roundsRestSliderOutlet.setMinimumTrackImage(trackLeftResizable, for: .normal)
        roundsRestSliderOutlet.setMaximumTrackImage(trackRightResizable, for: .normal)
  
        getReadyLabel.isHidden = true
        timerLabel.isHidden = true
        activeWorkTime.isHidden = true
        activeRestTime.isHidden = true
        activeRoundsRestTime.isHidden = true
        
        switch  (deviceIdiom) {
            
        case .phone:
            switch screenWidth {
                
            case 0...320: // iPhone 5, SE
                background.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
                backgroundWeight.frame = CGRect(x: 50, y: 174, width: 220, height: 220)
                getReadyLabel.frame = CGRect(x: 97, y: 411, width: 126, height: 24)
                
                /*bannerView.frame = CGRect(x: 30, y: 518, width: 260, height: 50)
                view.addSubview(bannerView)*/
                
                workTimeLabel.frame = CGRect(x: 40, y: 23, width: 100, height: 20)
                restLabelOutlet.frame = CGRect(x: 40, y: 103, width: 60, height: 20)
                exerciseLabelOutlet.frame = CGRect(x: 40, y: 183, width: 154, height: 20)
                roundsLabelOutlet.frame = CGRect(x: 40, y: 263, width: 93, height: 20)
                roundsRestLabel.frame = CGRect(x: 40, y: 344, width: 131, height: 20)
                
                workLabel.frame = CGRect(x: 200, y: 23, width: 75, height: 20)
                restLabel.frame = CGRect(x: 200, y: 103, width: 75, height: 20)
                exerciseLabel.frame = CGRect(x: 245, y: 183, width: 30, height: 20)
                roundsLabel.frame = CGRect(x: 245, y: 263, width: 30, height: 20)
                roundsRestTimeLabel.frame = CGRect(x: 200, y: 343, width: 75, height: 21)
                
                activeWorkTime.frame = CGRect(x: 82.5, y: 426, width: 155, height: 85)
                activeRestTime.frame = CGRect(x: 82.5, y: 426, width: 155, height: 85)
                activeRoundsRestTime.frame = CGRect(x: 82.5, y: 426, width: 155, height: 85)
                timerLabel.frame = CGRect(x: 140, y: 443, width: 40, height: 50)
                
                activeWorkTime.font = UIFont(name: "Chalkduster", size: 70)
                activeRestTime.font = UIFont(name: "Chalkduster", size: 70)
                activeRoundsRestTime.font = UIFont(name: "Chalkduster", size: 70)
                timerLabel.font = UIFont(name: "Chalkduster", size: 50)
                
                workSliderOutlet.frame = CGRect(x: 35, y: 53, width: 250, height: 31)
                restSliderOutlet.frame = CGRect(x: 35, y: 133, width: 250, height: 31)
                exerciseSliderOutlet.frame = CGRect(x: 35, y: 213, width: 250, height: 31)
                roundsSliderOutlet.frame = CGRect(x: 35, y: 293, width: 250, height: 31)
                roundsRestSliderOutlet.frame = CGRect(x: 35, y: 374, width: 250, height: 31)
                
                startButton.frame = CGRect(x: 130, y: 428, width: 60, height: 65)
                stopButton.frame = CGRect(x: 240, y: 470, width: 40, height: 40)
                creditsButton.frame = CGRect(x: 40, y: 470, width: 40, height: 40)
                
            case 321...375: // iPhone 6, 7, 8
                background.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                backgroundWeight.frame = CGRect(x: 67, y: 214, width: 240, height: 240)
                getReadyLabel.frame = CGRect(x: 124, y: 471, width: 126, height: 24)
                
                /*bannerView.frame = CGRect(x: 35, y: 617, width: 305, height: 50)
                view.addSubview(bannerView)*/
                
                workTimeLabel.frame = CGRect(x: 40, y: 30, width: 155, height: 20)
                restLabelOutlet.frame = CGRect(x: 40, y: 120, width: 155, height: 20)
                exerciseLabelOutlet.frame = CGRect(x: 40, y: 210, width: 155, height: 20)
                roundsLabelOutlet.frame = CGRect(x: 40, y: 300, width: 155, height: 20)
                roundsRestLabel.frame = CGRect(x: 40, y: 390, width: 155, height: 20)
                
                workLabel.frame = CGRect(x: 264, y: 30, width: 75, height: 20)
                restLabel.frame = CGRect(x: 264, y: 120, width: 75, height: 20)
                exerciseLabel.frame = CGRect(x: 304, y: 210, width: 30, height: 20)
                roundsLabel.frame = CGRect(x: 304, y: 300, width: 30, height: 20)
                roundsRestTimeLabel.frame = CGRect(x: 264, y: 390, width: 75, height: 20)
                
                activeWorkTime.frame = CGRect(x: 98, y: 494, width: 187, height: 115)
                activeRestTime.frame = CGRect(x: 98, y: 494, width: 187, height: 115)
                activeRoundsRestTime.frame = CGRect(x: 98, y: 494, width: 187, height: 115)
                timerLabel.frame = CGRect(x: 167, y: 541, width: 40, height: 50)
                
                activeWorkTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRestTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRoundsRestTime.font = UIFont(name: "Chalkduster", size: 75)
                timerLabel.font = UIFont(name: "Chalkduster", size: 50)
                
                workSliderOutlet.frame = CGRect(x: 35, y: 70, width: 306, height: 31)
                restSliderOutlet.frame = CGRect(x: 35, y: 160, width: 306, height: 31)
                exerciseSliderOutlet.frame = CGRect(x: 35, y: 250, width: 306, height: 31)
                roundsSliderOutlet.frame = CGRect(x: 35, y: 340, width: 306, height: 31)
                roundsRestSliderOutlet.frame = CGRect(x: 35, y: 430, width: 306, height: 31)
                
                startButton.frame = CGRect(x: 148, y: 506, width: 80, height: 85)
                stopButton.frame = CGRect(x: 289, y: 559, width: 50, height: 50)
                creditsButton.frame = CGRect(x: 40, y: 559, width: 50, height: 50)
                
            case 376...414: // iPhone 6+, 7+, 8+
                background.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                backgroundWeight.frame = CGRect(x: 77, y: 230, width: 260, height: 260)
                getReadyLabel.frame = CGRect(x: 144, y: 503, width: 126, height: 24)
                
                /*bannerView.frame = CGRect(x: 40, y: 686, width: 334, height: 50)
                view.addSubview(bannerView)*/
                
                workTimeLabel.frame = CGRect(x: 40, y: 35, width: 155, height: 20)
                restLabelOutlet.frame = CGRect(x: 40, y: 125, width: 155, height: 20)
                exerciseLabelOutlet.frame = CGRect(x: 40, y: 215, width: 155, height: 20)
                roundsLabelOutlet.frame = CGRect(x: 40, y: 305, width: 155, height: 20)
                roundsRestLabel.frame = CGRect(x: 40, y: 395, width: 155, height: 20)
                
                workLabel.frame = CGRect(x: 282, y: 35, width: 75, height: 20)
                restLabel.frame = CGRect(x: 282, y: 125, width: 75, height: 20)
                exerciseLabel.frame = CGRect(x: 327, y: 215, width: 30, height: 20)
                roundsLabel.frame = CGRect(x: 327, y: 305, width: 30, height: 20)
                roundsRestTimeLabel.frame = CGRect(x: 282, y: 395, width: 75, height: 20)
                
                activeWorkTime.frame = CGRect(x: 114, y: 518, width: 187, height: 115)
                activeRestTime.frame = CGRect(x: 114, y: 518, width: 187, height: 115)
                activeRoundsRestTime.frame = CGRect(x: 114, y: 518, width: 187, height: 115)
                timerLabel.frame = CGRect(x: 187, y: 547, width: 40, height: 50)
                
                activeWorkTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRestTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRoundsRestTime.font = UIFont(name: "Chalkduster", size: 75)
                timerLabel.font = UIFont(name: "Chalkduster", size: 50)
                
                workSliderOutlet.frame = CGRect(x: 38, y: 75, width: 339, height: 31)
                restSliderOutlet.frame = CGRect(x: 38, y: 165, width: 339, height: 31)
                exerciseSliderOutlet.frame = CGRect(x: 38, y: 255, width: 339, height: 31)
                roundsSliderOutlet.frame = CGRect(x: 38, y: 345, width: 339, height: 31)
                roundsRestSliderOutlet.frame = CGRect(x: 38, y: 435, width: 339, height: 31)
                
                startButton.frame = CGRect(x: 147, y: 513, width: 120, height: 125)
                stopButton.frame = CGRect(x: 315, y: 617, width: 60, height: 60)
                creditsButton.frame = CGRect(x: 40, y: 617, width: 60, height: 60)
                
            default:
                break
            }
        default:
            break
        }
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 1792: // iPhone XR
                background.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                backgroundWeight.frame = CGRect(x: 77, y: 318, width: 260, height: 260)
                getReadyLabel.frame = CGRect(x: 144, y: 609, width: 126, height: 24)
                
                /*bannerView.frame = CGRect(x: 40, y: 814, width: 334, height: 50)
                view.addSubview(bannerView)*/
                
                workTimeLabel.frame = CGRect(x: 40, y: 50, width: 155, height: 20)
                restLabelOutlet.frame = CGRect(x: 40, y: 160, width: 155, height: 20)
                exerciseLabelOutlet.frame = CGRect(x: 40, y: 270, width: 155, height: 20)
                roundsLabelOutlet.frame = CGRect(x: 40, y: 380, width: 155, height: 20)
                roundsRestLabel.frame = CGRect(x: 40, y: 490, width: 155, height: 20)
                
                workLabel.frame = CGRect(x: 282, y: 50, width: 75, height: 20)
                restLabel.frame = CGRect(x: 282, y: 160, width: 75, height: 20)
                exerciseLabel.frame = CGRect(x: 327, y: 270, width: 30, height: 20)
                roundsLabel.frame = CGRect(x: 327, y: 380, width: 30, height: 20)
                roundsRestTimeLabel.frame = CGRect(x: 282, y: 490, width: 75, height: 20)
                
                activeWorkTime.frame = CGRect(x: 114, y: 660, width: 187, height: 115)
                activeRestTime.frame = CGRect(x: 114, y: 660, width: 187, height: 115)
                activeRoundsRestTime.frame = CGRect(x: 114, y: 660, width: 187, height: 115)
                timerLabel.frame = CGRect(x: 192, y: 692, width: 40, height: 50)
                
                activeWorkTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRestTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRoundsRestTime.font = UIFont(name: "Chalkduster", size: 75)
                timerLabel.font = UIFont(name: "Chalkduster", size: 50)
                
                workSliderOutlet.frame = CGRect(x: 38, y: 100, width: 339, height: 31)
                restSliderOutlet.frame = CGRect(x: 38, y: 210, width: 339, height: 31)
                exerciseSliderOutlet.frame = CGRect(x: 38, y: 320, width: 339, height: 31)
                roundsSliderOutlet.frame = CGRect(x: 38, y: 430, width: 339, height: 31)
                roundsRestSliderOutlet.frame = CGRect(x: 38, y: 540, width: 339, height: 31)
                
                startButton.frame = CGRect(x: 147, y: 641, width: 130, height: 135)
                stopButton.frame = CGRect(x: 315, y: 744, width: 60, height: 60)
                creditsButton.frame = CGRect(x: 40, y: 744, width: 60, height: 60)
                
            case 2436: // iPhone X, Xs
                background.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                backgroundWeight.frame = CGRect(x: 57, y: 260, width: 260, height: 260)
                getReadyLabel.frame = CGRect(x: 116, y: 588, width: 126, height: 24)
                
                /*bannerView.frame = CGRect(x: 38, y: 728, width: 300, height: 50)
                view.addSubview(bannerView)*/
                
                workTimeLabel.frame = CGRect(x: 40, y: 50, width: 155, height: 20)
                restLabelOutlet.frame = CGRect(x: 40, y: 160, width: 155, height: 20)
                exerciseLabelOutlet.frame = CGRect(x: 40, y: 270, width: 155, height: 20)
                roundsLabelOutlet.frame = CGRect(x: 40, y: 380, width: 155, height: 20)
                roundsRestLabel.frame = CGRect(x: 40, y: 490, width: 155, height: 20)
                
                workLabel.frame = CGRect(x: 261, y: 50, width: 75, height: 20)
                restLabel.frame = CGRect(x: 261, y: 160, width: 75, height: 20)
                exerciseLabel.frame = CGRect(x: 306, y: 270, width: 30, height: 20)
                roundsLabel.frame = CGRect(x: 306, y: 380, width: 30, height: 20)
                roundsRestTimeLabel.frame = CGRect(x: 261, y: 490, width: 75, height: 20)
                
                activeWorkTime.frame = CGRect(x: 94, y: 588, width: 187, height: 115)
                activeRestTime.frame = CGRect(x: 94, y: 588, width: 187, height: 115)
                activeRoundsRestTime.frame = CGRect(x: 94, y: 588, width: 187, height: 115)
                timerLabel.frame = CGRect(x: 168, y: 620, width: 40, height: 50)
                
                activeWorkTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRestTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRoundsRestTime.font = UIFont(name: "Chalkduster", size: 75)
                timerLabel.font = UIFont(name: "Chalkduster", size: 50)
                
                workSliderOutlet.frame = CGRect(x: 38, y: 100, width: 300, height: 31)
                restSliderOutlet.frame = CGRect(x: 38, y: 210, width: 300, height: 31)
                exerciseSliderOutlet.frame = CGRect(x: 38, y: 320, width: 300, height: 31)
                roundsSliderOutlet.frame = CGRect(x: 38, y: 430, width: 300, height: 31)
                roundsRestSliderOutlet.frame = CGRect(x: 38, y: 540, width: 300, height: 31)
                
                startButton.frame = CGRect(x: 122, y: 578, width: 130, height: 135)
                stopButton.frame = CGRect(x: 276, y: 660, width: 60, height: 60)
                creditsButton.frame = CGRect(x: 40, y: 665, width: 55, height: 55)
                
            case 2688: // iPhone Xs Max
                background.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                backgroundWeight.frame = CGRect(x: 67, y: 308, width: 280, height: 280)
                getReadyLabel.frame = CGRect(x: 144, y: 588, width: 126, height: 24)
                
                /*bannerView.frame = CGRect(x: 40, y: 812, width: 334, height: 50)
                view.addSubview(bannerView)*/
                
                workTimeLabel.frame = CGRect(x: 40, y: 50, width: 155, height: 20)
                restLabelOutlet.frame = CGRect(x: 40, y: 160, width: 155, height: 20)
                exerciseLabelOutlet.frame = CGRect(x: 40, y: 270, width: 155, height: 20)
                roundsLabelOutlet.frame = CGRect(x: 40, y: 380, width: 155, height: 20)
                roundsRestLabel.frame = CGRect(x: 40, y: 490, width: 155, height: 20)
                
                workLabel.frame = CGRect(x: 290, y: 50, width: 75, height: 20)
                restLabel.frame = CGRect(x: 290, y: 160, width: 75, height: 20)
                exerciseLabel.frame = CGRect(x: 335, y: 270, width: 30, height: 20)
                roundsLabel.frame = CGRect(x: 335, y: 380, width: 30, height: 20)
                roundsRestTimeLabel.frame = CGRect(x: 290, y: 490, width: 75, height: 20)
                
                activeWorkTime.frame = CGRect(x: 122, y: 622, width: 187, height: 115)
                activeRestTime.frame = CGRect(x: 122, y: 622, width: 187, height: 115)
                activeRoundsRestTime.frame = CGRect(x: 122, y: 622, width: 187, height: 115)
                timerLabel.frame = CGRect(x: 195, y: 696, width: 40, height: 50)
                
                activeWorkTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRestTime.font = UIFont(name: "Chalkduster", size: 75)
                activeRoundsRestTime.font = UIFont(name: "Chalkduster", size: 75)
                timerLabel.font = UIFont(name: "Chalkduster", size: 50)
                
                workSliderOutlet.frame = CGRect(x: 38, y: 100, width: 338, height: 31)
                restSliderOutlet.frame = CGRect(x: 38, y: 210, width: 338, height: 31)
                exerciseSliderOutlet.frame = CGRect(x: 38, y: 320, width: 338, height: 31)
                roundsSliderOutlet.frame = CGRect(x: 38, y: 430, width: 338, height: 31)
                roundsRestSliderOutlet.frame = CGRect(x: 38, y: 540, width: 338, height: 31)
                
                startButton.frame = CGRect(x: 142, y: 642, width: 130, height: 135)
                stopButton.frame = CGRect(x: 314, y: 744, width: 60, height: 60)
                creditsButton.frame = CGRect(x: 40, y: 744, width: 60, height: 60)
                
            default:
                print("unknown")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}







