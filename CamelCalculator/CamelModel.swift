//
//  CamelModel.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

import Foundation

struct Person {
    static var `default` = Person(name: "Jane", sex: .female, age: 23, height: 169, hairColor: .blond, hairLength: .long, eyeColor: .blue, boobSize: BoobSize.c, beard: .mustache, figure: .sporty)
    
    var name: String
    var sex: Sex
    var age: Double
    var height: Double
    var hairColor: HairColor
    var hairLength: HairLength
    var eyeColor: EyeColor
    var boobSize: BoobSize
    var beard: Beard
    var figure: Figure
    
    func computeCamels() -> Int {
        return 0
    }
}


enum Sex: String, CaseIterable, Codable, Identifiable {
    case male = "male"
    case female = "female"
    
    var id: String { self.rawValue }
}

var ageRange = 0.0...120.0

var heightRange = 120.0...220.0

enum HairColor: String, Codable, CaseIterable, Identifiable {
    case blond = "blond"
    case brown = "brown"
    case black = "black"
    case red = "red"
    case drey = "grey"
    
    var id: String { self.rawValue }
}

enum HairLength: String, Codable, CaseIterable, Identifiable {
    case noHair = "noHair"
    case short = "short"
    case shoulder = "shoulder"
    case long = "long"
    case veryLong = "veryLong"
    
    var id: String { self.rawValue }
}

enum EyeColor: String, Codable, CaseIterable, Identifiable {
    case blue = "blue"
    case green = "green"
    case grey = "grey"
    case brown = "brown"
    
    var id: String { self.rawValue }
}

enum BoobSize: String, Codable, CaseIterable, Identifiable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
    
    var id: String { self.rawValue }
}

enum Figure: String, Codable, CaseIterable, Identifiable {
    case thin = "thin"
    case sporty = "sporty"
    case normal = "normal"
    case chubby = "chubby"
    case fat = "fat"
    
    var id: String { self.rawValue }
}

enum Beard: String, Codable, CaseIterable, Identifiable {
    case noBeard = "no"
    case mustache = "mustache"
    case threeDay = "threeDay"
    case full = "full"
    
    var id: String { self.rawValue }
}
