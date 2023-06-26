//
//  TokenModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation

struct TokenModel: Codable {
    let token_type: String
    let expires_in: Int
    let access_token: String
    let refresh_token: String
}
