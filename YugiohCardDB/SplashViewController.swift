//
//  SplashViewController.swift
//  YugiohCardDB
//
//  Created by bhrs on 9/18/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CacheManager.loadAllCards { (error) in
            if error == nil {
                self.navigateToSeachCard()
            } else {
                //TODO: Create full stop error screen
            }
        }
    }
    
    func navigateToSeachCard() {
        DispatchQueue.main.async {
            let searchViewControllerVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            searchViewControllerVC.modalPresentationStyle = .overFullScreen
            searchViewControllerVC.modalTransitionStyle = .crossDissolve
            self.present(searchViewControllerVC, animated: true, completion: nil)
        }
    }

}

