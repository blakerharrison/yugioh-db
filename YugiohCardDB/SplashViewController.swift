//
//  SplashViewController.swift
//  YugiohCardDB
//
//  Created by bhrs on 9/18/21.
//

import UIKit
import YGOPRODeckClient

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        YGOPRODeckClient.getAllCards(completion: fetchCardsCompletionHandler)
    }
    
    func navigateToSeachCard() {
        DispatchQueue.main.async {
            let searchViewControllerVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            searchViewControllerVC.modalPresentationStyle = .overFullScreen
            searchViewControllerVC.modalTransitionStyle = .crossDissolve
            self.present(searchViewControllerVC, animated: true, completion: nil)
        }
    }
    
    private func fetchCardsCompletionHandler(_ cardData: [CardData]?, _ error: Error?) {
        if error == nil, let cardData = cardData, !cardData.isEmpty {
            cacheCardData(getCardsViewModels(cardData))
        } else {
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("Unknown Error")
            }
        }
    }
    
    private func getCardsViewModels(_ cardsData: [CardData]?)-> [CardViewModel] {
        var cardsViewModels: [CardViewModel] = []
        if let cardsData = cardsData {
            for card in cardsData {
                cardsViewModels.append(CardViewModel(card))
            }
        }
        return cardsViewModels
    }
    
    private func cacheCardData(_ cardViewModels: [CardViewModel]) {
        CacheManager.cacheAllCards(cardViewModels)
        navigateToSeachCard()
    }
}

