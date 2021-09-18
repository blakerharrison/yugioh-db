//
//  YGOPRODeckService.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import Foundation

class YGOPRODeckService {
    typealias CardDataCompletion = (_ cardData: CardData?, _ error: Error?) -> ()
    typealias CardsDataCompletion = (_ cardData: CardsData?, _ error: Error?) -> ()
    
    static func getAllCards(completion: @escaping CardsDataCompletion) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = Strings.host
        urlBuilder.path = "/api/v7/cardinfo.php"
        
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
    
    static func searchCards(with search: String, completion: @escaping CardsDataCompletion) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = Strings.host
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
    
}
