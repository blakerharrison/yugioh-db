//
//  CardViewModel.swift
//  YugiohCardDB
//
//  Created by bhrs on 2/9/21.
//

import Foundation

struct CardViewModel {
    let id: String
    let name: String
    let imageUrl: String
    let imageUrlSmall: String
    let type: CardType
    let displayTypeName: String
    let description: String
    var attack: Int?
    var defense: Int?
    var level: Int? //
    var race: String?
    var attribute: String? //
    
    init(_ cardData: CardData? = nil) {
        id = String((cardData?.id ?? 0))
        name = cardData?.name ?? ""
        imageUrl = cardData?.card_images[0].image_url ?? ""
        imageUrlSmall = cardData?.card_images[0].image_url_small ?? ""
        displayTypeName = cardData?.type ?? ""
        description = cardData?.desc ?? ""
        attack = cardData?.atk
        defense = cardData?.def
        level = cardData?.level
        race = cardData?.race
        attribute = cardData?.attribute
        
        if let cardType = cardData?.type.lowercased() {
            type = cardType.contains("monster") ? CardType.monster : CardType.trapOrSpell
        } else {
            type = CardType.unknown
        }
    }
    
    lazy var hasAttackAndDefenseStatistics = attack == nil || defense == nil ? false : true
    
    lazy var attackString: String = {
        if let attack = attack { return String(attack) }
        return ""
    }()
    
    lazy var defenseString: String = {
        if let defense = defense { return String(defense) }
        return ""
    }()
}
