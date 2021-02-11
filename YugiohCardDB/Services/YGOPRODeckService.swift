//
//  YGOPRODeckService.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import Foundation

enum YGOPRODeckError: Error {
    case noError
    case buildUrlFailure
    case noData
    case decodingError
}

class YGOPRODeckService {
    typealias CardDataCompletion = (_ cardData: CardData?, _ error: Error?) -> ()
    typealias CardsDataCompletion = (_ cardData: CardsData?, _ error: Error?) -> ()
    
    private static let host = "db.ygoprodeck.com"
    
    static func fuzzySearch(with search: String, completion: @escaping CardsDataCompletion) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = "/api/v7/cardinfo.php"
        urlBuilder.queryItems = [URLQueryItem(name: "fname", value: search)]
        
        guard let url = urlBuilder.url else {
            completion(nil, YGOPRODeckError.buildUrlFailure)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
              completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, YGOPRODeckError.noData)
              return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let decoder = JSONDecoder()
                    let cardsData: CardsData = try decoder.decode(CardsData.self, from: data)
                    completion(cardsData, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }

    /*/
     Currently unused. This will be leveraged in future implementations
     */
    static func getRandomCard(completion: @escaping CardDataCompletion) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = "/api/v7/randomcard.php"
        
        let url = urlBuilder.url!
        print("URL - \(url)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
              completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, YGOPRODeckError.noData)
              return
            }

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let decoder = JSONDecoder()
                    let cardData: CardData = try decoder.decode(CardData.self, from: data)
                    completion(cardData, nil)
                } catch {
                    completion(nil, YGOPRODeckError.noData)
                }
            }
        }.resume()
    }
}
