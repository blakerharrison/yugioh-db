//
//  YGOPRODeckService.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import Foundation

class YGOPRODeckService {
    typealias CardsDataCompletion = (_ cardsViewModels: [CardViewModel]?, _ error: Error?) -> ()
    
    static func getAllCards(completion: @escaping CardsDataCompletion) {
        do {
            if let filePath = Bundle.main.path(forResource: Strings.allCardDataV7, ofType: Strings.jsonFileExtension) {
                let fileUrl = URL(fileURLWithPath: filePath)
                let cardData = try Data(contentsOf: fileUrl)
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let decoder = JSONDecoder()
                        let cards: CardsData = try decoder.decode(CardsData.self, from: cardData)
                        let result = cards.data
                        var cardsViewModels: [CardViewModel] = []
                        for cards in result {
                            cardsViewModels.append(CardViewModel(cards))
                        }
                        completion(cardsViewModels, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
        } catch {
            completion(nil, error)
        }
    }
}
