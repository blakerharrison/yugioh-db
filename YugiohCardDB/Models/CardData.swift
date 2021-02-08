//
//  CardData.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import Foundation

struct CardData: Decodable {
    
    let data: [Data]
    
    struct Data: Decodable {
        let id: Int
        let name: String
        let type: String
        let desc: String
        let atk: Int
        let def: Int
        let level: Int
        let race: String
        let attribute: String
        let card_sets: [cardSet]
        let card_images: [cardImage]
        let card_prices: [cardPrice]
    }
    
    struct cardSet: Decodable {
        let set_name: String
        let set_code: String
        let set_rarity: String
        let set_rarity_code: String
        let set_price: String
    }
    
    struct cardImage: Decodable {
        let id: Int
        let image_url: String
        let image_url_small: String
    }
    
    struct cardPrice: Decodable {
        let cardmarket_price: String
        let tcgplayer_price: String
        let ebay_price: String
        let amazon_price: String
        let coolstuffinc_price: String
    }
    
}
