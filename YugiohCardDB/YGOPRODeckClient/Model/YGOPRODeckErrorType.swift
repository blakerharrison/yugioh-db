//
//  YGOPRODeckErrorType.swift
//  YugiohCardDB
//
//  Created by bhrs on 9/18/21.
//

import Foundation

public enum YGOPRODeckError: Error {
    case noError
    case buildUrlFailure
    case noData
    case decodingError
}

