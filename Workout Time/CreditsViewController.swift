//
//  CreditsViewController.swift
//  Workout Time
//
//  Created by Marko Šplajt on 03/01/2019.
//  Copyright © 2019 MarkoSplajt. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creditsLabel: UIButton!
    @IBOutlet weak var privacyPolicyLabel: UIButton!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var gymImage: UIImageView!
    
    @IBOutlet weak var musicButton: UIButton!
    @IBAction func musicButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/alexandar.ivcic")! as URL, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch  (deviceIdiom){
            
        case .phone:
            switch screenWidth {
                
            case 0...320: // iPhone 5, SE
                titleLabel.frame = CGRect(x: 20, y: 20, width: 288, height: 44)
                creditsLabel.frame = CGRect(x: 38, y: 159, width: 40, height: 40)
                privacyPolicyLabel.frame = CGRect(x: 243, y: 159, width: 40, height: 40)
                background.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
                backButton.frame = CGRect(x: 16, y: 508, width: 288, height: 40)
                gymImage.frame = CGRect(x: 38, y: 207, width: 245, height: 293)
                musicButton.frame = CGRect(x: 140, y: 159, width: 40, height: 40)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 25)
                
            case 321...375: // iPhone 6, 7, 8
                titleLabel.frame = CGRect(x: 43, y: 20, width: 288, height: 44)
                creditsLabel.frame = CGRect(x: 38, y: 126, width: 45, height: 45)
                privacyPolicyLabel.frame = CGRect(x: 286, y: 126, width: 45, height: 45)
                background.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                backButton.frame = CGRect(x: 43, y: 607, width: 288, height: 40)
                gymImage.frame = CGRect(x: 39, y: 232, width: 296, height: 367)
                musicButton.frame = CGRect(x: 165, y: 126, width: 45, height: 45)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 26)
                
            case 376...414: // iPhone 6+, 7+, 8+
                titleLabel.frame = CGRect(x: 37, y: 20, width: 340, height: 44)
                creditsLabel.frame = CGRect(x: 20, y: 126, width: 55, height: 55)
                privacyPolicyLabel.frame = CGRect(x: 339, y: 126, width: 55, height: 55)
                background.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                backButton.frame = CGRect(x: 63, y: 676, width: 288, height: 40)
                gymImage.frame = CGRect(x: 43, y: 232, width: 323, height: 436)
                musicButton.frame = CGRect(x: 180, y: 126, width: 55, height: 55)
                
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
                creditsLabel.frame = CGRect(x: 38, y: 144, width: 55, height: 55)
                privacyPolicyLabel.frame = CGRect(x: 320, y: 144, width: 55, height: 55)
                background.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                backButton.frame = CGRect(x: 63, y: 822, width: 288, height: 40)
                gymImage.frame = CGRect(x: 23, y: 294, width: 369, height: 530)
                musicButton.frame = CGRect(x: 180, y: 144, width: 55, height: 55)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            case 2436: // iPhone X, Xs
                titleLabel.frame = CGRect(x: 16, y: 44, width: 343, height: 44)
                creditsLabel.frame = CGRect(x: 38, y: 144, width: 55, height: 55)
                privacyPolicyLabel.frame = CGRect(x: 276, y: 144, width: 55, height: 55)
                background.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                backButton.frame = CGRect(x: 44, y: 738, width: 288, height: 40)
                gymImage.frame = CGRect(x: 24, y: 270, width: 327, height: 460)
                musicButton.frame = CGRect(x: 160, y: 144, width: 55, height: 55)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            case 2688: // iPhone Xs Max
                titleLabel.frame = CGRect(x: 20, y: 44, width: 374, height: 60)
                creditsLabel.frame = CGRect(x: 38, y: 144, width: 55, height: 55)
                privacyPolicyLabel.frame = CGRect(x: 320, y: 144, width: 55, height: 55)
                background.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                backButton.frame = CGRect(x: 63, y: 812, width: 288, height: 50)
                gymImage.frame = CGRect(x: 20, y: 334, width: 374, height: 470)
                musicButton.frame = CGRect(x: 180, y: 144, width: 55, height: 55)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            default:
                print("unknown")
            }
        }
    }
    
    @IBAction func privacyTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.freeprivacypolicy.com/privacy/view/3d524cf4933bce5381d496fe7f88e3af")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func creditsTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.vecteezy.com")! as URL, options: [:], completionHandler: nil)
    }
}
