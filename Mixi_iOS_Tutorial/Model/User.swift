//
//  User.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/04/24.
//

import Foundation

struct User: Decodable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "login"
    }
    
}
