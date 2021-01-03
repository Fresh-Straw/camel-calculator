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
    
    var computeValue: Int {
        return computeValue(forAge: Int(age), andSex: sex) + computeValue(forheight: Int(height), andSex: sex) + hairColor.camelValue + hairLength.camelValue + eyeColor.camelValue + sex.getFittingValuable(male: beard, female: boobSize).camelValue + figure.camelValue
    }
    
    private func computeValue(forAge age: Int, andSex sex: Sex) -> Int {
        return computeValue(age, max: 20, preferred: sex.preferredAge, divisor: 16)
    }

    private func computeValue(forheight height: Int, andSex sex: Sex) -> Int {
        return computeValue(height, max: 18, preferred: sex.preferredHeight, divisor: 14)
    }

    private func computeValue(_ value: Int, max: Int, preferred preferredValue: Int, divisor: Int) -> Int {
        let xOffset = Double(value) - Double(preferredValue)
        let adjustedOffset = pow(xOffset / Double(divisor), 2)
        return Int(Double(max) - adjustedOffset)
    }

}



protocol Valuable {
    var camelValue: Int { get }
}


enum Sex: String, CaseIterable, Codable, Identifiable {
    case male = "male"
    case female = "female"
    
    var id: String { self.rawValue }
    
    var preferredAge: Int {
        switch self {
        case .female: return 19
        case .male: return 25
        }
    }
    
    var preferredHeight: Int {
        switch self {
        case .female: return 172
        case .male: return 187
        }
    }
    
    func getFittingValuable(male: Valuable, female: Valuable) -> Valuable {
        switch self {
        case .male: return male
        case .female: return female
        }
    }
}

var ageRange = 0.0...120.0

var heightRange = 120.0...220.0

enum HairColor: String, Codable, CaseIterable, Identifiable, Valuable {
    case blond = "blond"
    case brown = "brown"
    case black = "black"
    case red = "red"
    case grey = "grey"
    
    var id: String { self.rawValue }
    
    var camelValue: Int {
        switch self {
        case .blond: return 20
        case .brown: return 16
        case .black: return 10
        case .red: return 17
        case .grey: return 5
        }
    }
}

enum HairLength: String, Codable, CaseIterable, Identifiable, Valuable {
    case noHair = "noHair"
    case short = "short"
    case shoulder = "shoulder"
    case long = "long"
    case veryLong = "veryLong"
    
    var id: String { self.rawValue }
    
    var camelValue: Int {
        switch self {
        case .noHair: return 2
        case .short: return 5
        case .shoulder: return 8
        case .long: return 13
        case .veryLong: return 17
        }
    }
}

enum EyeColor: String, Codable, CaseIterable, Identifiable, Valuable {
    case blue = "blue"
    case green = "green"
    case grey = "grey"
    case brown = "brown"
    
    var id: String { self.rawValue }
    
    var camelValue: Int {
        switch self {
        case .blue: return 16
        case .green: return 14
        case .brown: return 10
        case .grey: return 4
        }
    }
}

enum BoobSize: String, Codable, CaseIterable, Identifiable, Valuable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
    
    var id: String { self.rawValue }
    
    var camelValue: Int {
        switch self {
        case .a: return 9
        case .b: return 13
        case .c: return 16
        case .d: return 15
        }
    }
}

enum Figure: String, Codable, CaseIterable, Identifiable, Valuable {
    case thin = "thin"
    case sporty = "sporty"
    case normal = "normal"
    case chubby = "chubby"
    case fat = "fat"
    
    var id: String { self.rawValue }
    
    var camelValue: Int {
        switch self {
        case .thin: return 8
        case .sporty: return 16
        case .normal: return 15
        case .chubby: return 6
        case .fat: return 4
        }
    }
}

enum Beard: String, Codable, CaseIterable, Identifiable, Valuable {
    case noBeard = "no"
    case mustache = "mustache"
    case threeDay = "threeDay"
    case full = "full"
    
    var id: String { self.rawValue }
    
    var camelValue: Int {
        switch self {
        case .noBeard: return 7
        case .mustache: return 9
        case .threeDay: return 14
        case .full: return 12
        }
    }
}
