//
//  Model.swift
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 16/11/2021.
//

import Foundation


typealias SensorsValuesModel = [String: Double]

typealias AddressModel = [String]


struct SidModel: Codable {
    let eid: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
}


struct UnitModel: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let nm: String
    let id: Int
    let pos: Pos
    let sens: [String: Sen]
}

// MARK: - Pos
struct Pos: Codable {
    let y, x: Double
    let s: Int
}

// MARK: - Sen
struct Sen: Codable {
    let id: Int
    let n, t, m: String
}


struct MyUnit{
    let name:String
    let address:String
    let speed:Float
    let engine_status:String
    let sensors:String
}
