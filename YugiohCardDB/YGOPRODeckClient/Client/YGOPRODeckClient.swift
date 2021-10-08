//
//  YGOPRODeckClient.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import Foundation

public class YGOPRODeckClient {
    public typealias CardsDataCompletion = (_ cardData: [CardData]?, _ error: Error?) -> ()
    
    public static func getAllCards(completion: @escaping CardsDataCompletion) {
        do {
            if let filePath = Bundle.main.path(forResource: Strings.allCardDataV7, ofType: Strings.jsonFileExtension) {
                let fileUrl = URL(fileURLWithPath: filePath)
                let cardData = try Data(contentsOf: fileUrl)
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let decoder = JSONDecoder()
                        let cards: CardsData = try decoder.decode(CardsData.self, from: cardData)
                        completion(cards.data, nil)
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
