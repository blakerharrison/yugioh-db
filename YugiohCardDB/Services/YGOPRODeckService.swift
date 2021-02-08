//
//  YGOPRODeckService.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import Foundation

enum YGOPRODeckError: Error {
    case noError
    case noData
    case decodingError
}

class YGOPRODeckService {
    typealias CardDataCompletion = () -> ()
    
    private static let host = "db.ygoprodeck.com"

    static func getCard(completion: @escaping CardDataCompletion, queryItems: [URLQueryItem] = []) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = "/api/v7/cardinfo.php"
        urlBuilder.queryItems = queryItems
        
        let url = urlBuilder.url!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Failed request from YGOPRODeck: \(error!.localizedDescription)")
                completion()
                return
            }
            
            guard let data = data else {
              print("No data returned from Weatherbit")
              completion()
              return
            }
            
            print("Data-X: \(data)")
            print("Response-X: \(response)")
            print("Error-X: \(error)")
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let cardData: CardData = try decoder.decode(CardData.self, from: data)
                    print(cardData)
                } catch {
                    print(YGOPRODeckError.decodingError)
                }
            }
        }.resume()
    }
    
}
