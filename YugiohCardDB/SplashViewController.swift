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
        YGOPRODeckService.getAllCards(completion: cacheCardData)
    }
    
    func navigateToSeachCard() {
        DispatchQueue.main.async {
            let searchViewControllerVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            searchViewControllerVC.modalPresentationStyle = .overFullScreen
            searchViewControllerVC.modalTransitionStyle = .crossDissolve
            self.present(searchViewControllerVC, animated: true, completion: nil)
        }
    }
    
    func cacheCardData(_ cardsViewModels: [CardViewModel]?, _ error: Error?) {
        if error == nil, let cards = cardsViewModels {
            CacheManager.cacheAllCards(cards)
            navigateToSeachCard()
        } else {
            print("Error 🍒")
        }
        
    }

}

