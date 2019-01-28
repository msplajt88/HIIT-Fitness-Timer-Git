//
//  LaunchScreenViewController.swift
//  Workout Time
//
//  Created by Marko Šplajt on 06/01/2019.
//  Copyright © 2019 MarkoSplajt. All rights reserved.
//

import UIKit
import SpriteKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var startButtonLSOutlet: UIButton!
    @IBOutlet weak var progressLSOutlet: UIProgressView!
    @IBOutlet weak var launchScreenImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var timerLS = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
        startButtonLSOutlet.isHidden = true
        
        switch  (deviceIdiom){
            
        case .phone:
            switch screenWidth {
                
            case 0...320: // iPhone 5, SE
                titleLabel.frame = CGRect(x: 20, y: 20, width: 284, height: 44)
                progressLSOutlet.frame = CGRect(x: 16, y: 538, width: 288, height: 10)
                startButtonLSOutlet.frame = CGRect(x: 16, y: 490, width: 288, height: 40)
                launchScreenImage.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 25)
                
            case 321...375: // iPhone 6, 7, 8
                titleLabel.frame = CGRect(x: 43, y: 20, width: 288, height: 44)
                progressLSOutlet.frame = CGRect(x: 16, y: 637, width: 343, height: 10)
                startButtonLSOutlet.frame = CGRect(x: 43, y: 589, width: 288, height: 40)
                launchScreenImage.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 26)
                
            case 376...414: // iPhone 6+, 7+, 8+
                titleLabel.frame = CGRect(x: 37, y: 20, width: 340, height: 44)
                progressLSOutlet.frame = CGRect(x: 20, y: 706, width: 374, height: 10)
                startButtonLSOutlet.frame = CGRect(x: 63, y: 658, width: 288, height: 40)
                launchScreenImage.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            default:
                break
            }
        default:
            break
        }
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 1792: // iPhone XR
                titleLabel.frame = CGRect(x: 37, y: 44, width: 340, height: 44)
                progressLSOutlet.frame = CGRect(x: 20, y: 852, width: 374, height: 10)
                startButtonLSOutlet.frame = CGRect(x: 63, y: 804, width: 288, height: 40)
                launchScreenImage.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            case 2436: // iPhone X, Xs
                titleLabel.frame = CGRect(x: 16, y: 44, width: 343, height: 44)
                progressLSOutlet.frame = CGRect(x: 16, y: 768, width: 343, height: 10)
                startButtonLSOutlet.frame = CGRect(x: 43, y: 720, width: 288, height: 40)
                launchScreenImage.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            case 2688: // iPhone Xs Max
                titleLabel.frame = CGRect(x: 20, y: 44, width: 374, height: 60)
                progressLSOutlet.frame = CGRect(x: 20, y: 852, width: 374, height: 10)
                startButtonLSOutlet.frame = CGRect(x: 63, y: 779, width: 288, height: 50)
                launchScreenImage.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            default:
                print("unknown")
            }
        }
        
        /*progressLSOutlet.progressImage = UIImage(named: "progress")
        progressLSOutlet.trackImage = UIImage(named: "track")*/
        
        timerLS = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
        if (UserDefaults.standard.value(forKey: "name") as? String) == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let next = storyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
            addChildVC(viewController: next)
        }

    }
    
    @objc func updateTimer() {
        progressLSOutlet.progress += 0.333333333
        
        if progressLSOutlet.progress >= 1 {
            startButtonLSOutlet.isHidden = false
            timerLS.invalidate()
        }
    }
}

extension UIViewController {
    func addChildVC(viewController: UIViewController){
        self.addChild(viewController)
        viewController.view.frame = self.view.frame
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        }
    }
