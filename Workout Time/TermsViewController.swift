//
//  TermsViewController.swift
//  Workout Time
//
//  Created by Marko Šplajt on 02/01/2019.
//  Copyright © 2019 MarkoSplajt. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var policyImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var byClickingOn: UILabel!
    @IBOutlet weak var continueButtonYouAccept: UILabel!
    @IBOutlet weak var termsAndConditions: UIButton!
    @IBOutlet weak var andUnderstand: UILabel!
    @IBOutlet weak var privacyAndCookiePolicyApplies: UIButton!
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch  (deviceIdiom){
            
        case .phone:
            switch screenWidth {
                
            case 0...320: // iPhone 5, SE
                policyImage.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
                titleLabel.frame = CGRect(x: 20, y: 20, width: 284, height: 44)
                byClickingOn.frame = CGRect(x: 20, y: 226, width: 284, height: 20)
                continueButtonYouAccept.frame = CGRect(x: 20, y: 254, width: 284, height: 15)
                termsAndConditions.frame = CGRect(x: 20, y: 277, width: 284, height: 15)
                andUnderstand.frame = CGRect(x: 20, y: 300, width: 284, height: 15)
                privacyAndCookiePolicyApplies.frame = CGRect(x: 20, y: 323, width: 284, height: 15)
                continueButton.frame = CGRect(x: 20, y: 508, width: 284, height: 40)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 25)
                
            case 321...375: // iPhone 6, 7, 8
                policyImage.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                titleLabel.frame = CGRect(x: 43, y: 20, width: 288, height: 44)
                byClickingOn.frame = CGRect(x: 47, y: 275, width: 284, height: 20)
                continueButtonYouAccept.frame = CGRect(x: 47, y: 303, width: 284, height: 15)
                termsAndConditions.frame = CGRect(x: 47, y: 326, width: 284, height: 15)
                andUnderstand.frame = CGRect(x: 47, y: 349, width: 284, height: 15)
                privacyAndCookiePolicyApplies.frame = CGRect(x: 47, y: 372, width: 284, height: 15)
                continueButton.frame = CGRect(x: 45, y: 607, width: 284, height: 40)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 26)
                
            case 376...414: // iPhone 6+, 7+, 8+
                policyImage.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                titleLabel.frame = CGRect(x: 37, y: 20, width: 340, height: 44)
                byClickingOn.frame = CGRect(x: 65, y: 310, width: 284, height: 20)
                continueButtonYouAccept.frame = CGRect(x: 65, y: 338, width: 284, height: 15)
                termsAndConditions.frame = CGRect(x: 65, y: 361, width: 284, height: 15)
                andUnderstand.frame = CGRect(x: 65, y: 384, width: 284, height: 15)
                privacyAndCookiePolicyApplies.frame = CGRect(x: 65, y: 407, width: 284, height: 15)
                continueButton.frame = CGRect(x: 65, y: 676, width: 284, height: 40)
                
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
                policyImage.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                titleLabel.frame = CGRect(x: 37, y: 44, width: 340, height: 44)
                byClickingOn.frame = CGRect(x: 65, y: 390, width: 284, height: 20)
                continueButtonYouAccept.frame = CGRect(x: 65, y: 418, width: 284, height: 15)
                termsAndConditions.frame = CGRect(x: 65, y: 441, width: 284, height: 15)
                andUnderstand.frame = CGRect(x: 65, y: 464, width: 284, height: 15)
                privacyAndCookiePolicyApplies.frame = CGRect(x: 65, y: 487, width: 284, height: 15)
                continueButton.frame = CGRect(x: 65, y: 822, width: 284, height: 40)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            case 2436: // iPhone X, Xs
                policyImage.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                titleLabel.frame = CGRect(x: 16, y: 44, width: 343, height: 44)
                byClickingOn.frame = CGRect(x: 45, y: 348, width: 284, height: 20)
                continueButtonYouAccept.frame = CGRect(x: 45, y: 376, width: 284, height: 15)
                termsAndConditions.frame = CGRect(x: 45, y: 399, width: 284, height: 15)
                andUnderstand.frame = CGRect(x: 45, y: 422, width: 284, height: 15)
                privacyAndCookiePolicyApplies.frame = CGRect(x: 45, y: 445, width: 284, height: 15)
                continueButton.frame = CGRect(x: 45, y: 738, width: 284, height: 40)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            case 2688: // iPhone Xs Max
                policyImage.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
                titleLabel.frame = CGRect(x: 20, y: 44, width: 374, height: 60)
                byClickingOn.frame = CGRect(x: 20, y: 390, width: 374, height: 20)
                continueButtonYouAccept.frame = CGRect(x: 20, y: 418, width: 374, height: 15)
                termsAndConditions.frame = CGRect(x: 20, y: 441, width: 374, height: 15)
                andUnderstand.frame = CGRect(x: 20, y: 464, width: 374, height: 15)
                privacyAndCookiePolicyApplies.frame = CGRect(x: 20, y: 487, width: 374, height: 15)
                continueButton.frame = CGRect(x: 63, y: 812, width: 288, height: 50)
                
                titleLabel.font = UIFont(name: "Chalkduster", size: 30)
                
            default:
                print("unknown")
            }
        }

    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        UserDefaults.standard.set("name", forKey: "name")
        self.dismiss(animated: true, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.6,
                       options: .curveEaseOut, animations: {
                        self.view.alpha = 0
        }) {(_) in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @IBAction func privacyTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.freeprivacypolicy.com/privacy/view/3d524cf4933bce5381d496fe7f88e3af")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func termsTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.freeprivacypolicy.com/privacy/view/3d524cf4933bce5381d496fe7f88e3af")! as URL, options: [:], completionHandler: nil)
    }
}
