//
//  CardData.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//


/*
 https://www.swiftbysundell.com/tips/default-decoding-values/
 */

import Foundation

struct CardsData: Decodable {
    let data: [CardData]
}

struct CardData: Decodable {

    @DecodableDefault.EmptyInt var id: Int
    @DecodableDefault.EmptyString var name: String
    @DecodableDefault.EmptyString var type: String
    @DecodableDefault.EmptyString var desc: String
    @DecodableDefault.EmptyInt var atk: Int
    @DecodableDefault.EmptyInt var def: Int
    @DecodableDefault.EmptyInt var level: Int
    @DecodableDefault.EmptyString var race: String
    @DecodableDefault.EmptyString var attribute: String
    @DecodableDefault.EmptyList var card_sets: [cardSet]
    @DecodableDefault.EmptyList var card_images: [cardImage]
    @DecodableDefault.EmptyList var card_prices: [cardPrice]


    struct cardSet: Decodable {
        @DecodableDefault.EmptyString var set_name: String
        @DecodableDefault.EmptyString var set_code: String
        @DecodableDefault.EmptyString var set_rarity: String
        @DecodableDefault.EmptyString var set_rarity_code: String
        @DecodableDefault.EmptyString var set_price: String
    }

    struct cardImage: Decodable {
        @DecodableDefault.EmptyInt var id: Int
        @DecodableDefault.EmptyString var image_url: String
        @DecodableDefault.EmptyString var image_url_small: String
    }

    struct cardPrice: Decodable {
        @DecodableDefault.EmptyString var cardmarket_price: String
        @DecodableDefault.EmptyString var tcgplayer_price: String
        @DecodableDefault.EmptyString var ebay_price: String
        @DecodableDefault.EmptyString var amazon_price: String
        @DecodableDefault.EmptyString var coolstuffinc_price: String
    }
    
}


//TODO: Move to seperate folder/file
protocol DecodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

enum DecodableDefault {}

extension DecodableDefault {
    @propertyWrapper
    struct Wrapper<Source: DecodableDefaultSource> {
        typealias Value = Source.Value
        var wrappedValue = Source.defaultValue
    }
}


extension DecodableDefault.Wrapper: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Value.self)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type,
                   forKey key: Key) throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

extension DecodableDefault {
    typealias Source = DecodableDefaultSource
    typealias List = Decodable & ExpressibleByArrayLiteral
    typealias Map = Decodable & ExpressibleByDictionaryLiteral

    enum Sources {
        enum True: Source {
            static var defaultValue: Bool { true }
        }

        enum False: Source {
            static var defaultValue: Bool { false }
        }

        enum EmptyString: Source {
            static var defaultValue: String { "" }
        }
        
        enum EmptyInt: Source {
            static var defaultValue: Int { 0 }
        }

        enum EmptyList<T: List>: Source {
            static var defaultValue: T { [] }
        }

        enum EmptyMap<T: Map>: Source {
            static var defaultValue: T { [:] }
        }
    }
}

extension DecodableDefault {
    typealias True = Wrapper<Sources.True>
    typealias False = Wrapper<Sources.False>
    typealias EmptyString = Wrapper<Sources.EmptyString>
    typealias EmptyInt = Wrapper<Sources.EmptyInt>
    typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
    typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
}
