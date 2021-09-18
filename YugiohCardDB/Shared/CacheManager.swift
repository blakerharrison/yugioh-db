//
//  CacheManager.swift
//  YugiohCardDB
//
//  Created by bhrs on 9/18/21.
//

import Foundation

class CacheManager {
    private static let cache = NSCache<NSString, NSArray>()
    private static let allCardsKey: NSString = "allCardsKey"
    
    static func loadAllCards(completionHandler: @escaping (Error?) -> ()) {
        var cardsViewModels: [CardViewModel] = []
        do {
            if let filePath = Bundle.main.path(forResource: Strings.allCardDataV7, ofType: Strings.jsonFileExtension) {
                let fileUrl = URL(fileURLWithPath: filePath)
                let cardData = try Data(contentsOf: fileUrl)
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let decoder = JSONDecoder()
                        let cards: CardsData = try decoder.decode(CardsData.self, from: cardData)
                        let result = cards.data
                        for cards in result {
                            cardsViewModels.append(CardViewModel(cards))
                        }
                        cacheAllCards(cards: cardsViewModels)
                        completionHandler(nil)
                    } catch {
                        //TODO: Pass Error
                        completionHandler(nil)
                    }
                }
            }
        } catch {
            //TODO: Pass Error
            completionHandler(nil)
        }
    }
    
    static private func cacheAllCards(cards: [CardViewModel]) {
        cache.setObject(cards as NSArray, forKey: allCardsKey)
    }

    static func getAllCards() -> [CardViewModel] {
        return cache.object(forKey: allCardsKey) as? [CardViewModel] ?? []
    }
}
