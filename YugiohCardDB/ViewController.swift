//
//  ViewController.swift
//  YugiohCardDB
//
//  Created by Blake Harrison on 1/25/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Started ⚠️")
        YGOPRODeckService.getCard(
            completion: updateView,
            queryItems: [URLQueryItem(name: "name", value: "Blue-Eyes White Dragon")]
        )
    }
    
    func updateView() {
        print("Completed 🔨")
    }

}


