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

public struct CardsData: Decodable {
    public let data: [CardData]
}

public struct CardData: Decodable {
    @DecodableDefault.EmptyInt public var id: Int
    @DecodableDefault.EmptyString public var name: String
    @DecodableDefault.EmptyString public var type: String
    @DecodableDefault.EmptyString public var desc: String
    @DecodableDefault.EmptyInt public var atk: Int
    @DecodableDefault.EmptyInt public var def: Int
    @DecodableDefault.EmptyInt public var level: Int
    @DecodableDefault.EmptyString public var race: String
    @DecodableDefault.EmptyString public var attribute: String
    @DecodableDefault.EmptyList public var card_sets: [cardSet]
    @DecodableDefault.EmptyList public var card_images: [cardImage]
    @DecodableDefault.EmptyList public var card_prices: [cardPrice]


    public struct cardSet: Decodable {
        @DecodableDefault.EmptyString public var set_name: String
        @DecodableDefault.EmptyString public var set_code: String
        @DecodableDefault.EmptyString public var set_rarity: String
        @DecodableDefault.EmptyString public var set_rarity_code: String
        @DecodableDefault.EmptyString public var set_price: String
    }

    public struct cardImage: Decodable {
        @DecodableDefault.EmptyInt public var id: Int
        @DecodableDefault.EmptyString public var image_url: String
        @DecodableDefault.EmptyString public var image_url_small: String
    }

    public struct cardPrice: Decodable {
        @DecodableDefault.EmptyString public var cardmarket_price: String
        @DecodableDefault.EmptyString public var tcgplayer_price: String
        @DecodableDefault.EmptyString public var ebay_price: String
        @DecodableDefault.EmptyString public var amazon_price: String
        @DecodableDefault.EmptyString public var coolstuffinc_price: String
    }
    
}


//TODO: Move to seperate folder/file
public protocol DecodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

public enum DecodableDefault {}

extension DecodableDefault {
    @propertyWrapper
    public struct Wrapper<Source: DecodableDefaultSource> {
        public init() {}
        typealias Value = Source.Value
        public var wrappedValue = Source.defaultValue
    }
}


extension DecodableDefault.Wrapper: Decodable {
    public init(from decoder: Decoder) throws {
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
    public typealias Source = DecodableDefaultSource
    public typealias List = Decodable & ExpressibleByArrayLiteral
    public typealias Map = Decodable & ExpressibleByDictionaryLiteral

    public enum Sources {
        public enum True: Source {
            public static var defaultValue: Bool { true }
        }

        public enum False: Source {
            public static var defaultValue: Bool { false }
        }

        public enum EmptyString: Source {
            public static var defaultValue: String { "" }
        }
        
        public enum EmptyInt: Source {
            public static var defaultValue: Int { 0 }
        }

        public enum EmptyList<T: List>: Source {
            public static var defaultValue: T { [] }
        }

        public enum EmptyMap<T: Map>: Source {
            public static var defaultValue: T { [:] }
        }
    }
}

extension DecodableDefault {
    public typealias True = Wrapper<Sources.True>
    public typealias False = Wrapper<Sources.False>
    public typealias EmptyString = Wrapper<Sources.EmptyString>
    public typealias EmptyInt = Wrapper<Sources.EmptyInt>
    public typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
    public typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
}
