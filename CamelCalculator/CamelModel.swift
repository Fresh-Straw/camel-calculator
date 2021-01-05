//
//  CamelModel.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

import Foundation


var ageRange = 0.0...120.0
var heightRange = 120.0...220.0


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
    
    var camelValue: CamelValue {
        let specific: Valuable = sex.getFittingValuable(male: beard, female: boobSize)
        return CamelValue(capping: sex.ageCapping(Int(age)), age: ageValue(age: age, sex: sex), height: computeValue(forheight: Int(height), andSex: sex), hairColor: hairColor.camelValue, hairLength: hairLength.camelValue, eyeColor: eyeColor.camelValue, extra: specific.camelValue, figure: figure.camelValue)
    }
    
    private func ageValue(age: Double, sex: Sex) -> Int {
        // https://www.desmos.com/
        // If 19 is the preferred age, then maximum of:
        // * 20-((x)-19)^2/100
        // * (12-(x-19)^2/1000)
        // plus
        // * cos((x-19)/3)/2
        
        let preferredAge = Double(sex.preferredAge)
        let val1 = 20.0 - pow(age - preferredAge, 2.0) / 100.0
        let val2 = 12.0 - pow(age - preferredAge, 2.0) / 1000.0
        let cosinus = cos((age - preferredAge) / 3.0) / 2.0
        
        return Int(max(val1, val2) + cosinus)
    }
    
    private func computeValue(forAge age: Int, andSex sex: Sex) -> Int {
        return max(0, computeValue(Double(age), max: 20.5, preferred: Double(sex.preferredAge), divisor: 15))
    }

    private func computeValue(forheight height: Int, andSex sex: Sex) -> Int {
        return max(0, computeValue(Double(height), max: 18.5, preferred: Double(sex.preferredHeight), divisor: 12))
    }

    private func computeValue(_ value: Double, max: Double, preferred preferredValue: Double, divisor: Double) -> Int {
        let xOffset = Double(value) - Double(preferredValue)
        let adjustedOffset = pow(xOffset / Double(divisor), 2)
        return Int(Double(max) - adjustedOffset)
    }
    
    // http://fooplot.com/
    // Age: 20-((x)-19)^2/40 - cos(x/2)
    // 10-((x)-19)^2/100 - cos(x/2)/2 +
    // 10-((x)-19)^2/100 - cos(x/2)/2 + (10-(x-29)^2/1000)
}

struct CamelValue {
    var capping: Int
    var age: Int
    var height: Int
    var hairColor: Int
    var hairLength: Int
    var eyeColor: Int
    var extra: Int
    var figure: Int
    
    var sum: Int {
        return age + height + hairColor + hairLength + eyeColor + extra + figure
    }
    
    var result: Int {
        return min(sum, capping)
    }
}



protocol Valuable {
    var camelValue: Int { get }
}


enum Sex: String, CaseIterable, Codable, Identifiable {
    case male = "male"
    case female = "female"
    
    var id: String { self.rawValue }
    
    private static var femaleAgeCapping: [Double] = [0,10,40,53,76,110,90,85,70,45,34,26,23,19,16,14,12,10,8,6,5,4,3,2,1]
    private static var maleAgeCapping: [Double] = [0,13,28,53,98,109,111,87,70,52,38,29,23,19,16,14,12,10,8,6,5,4,3,2,1]
    
    var preferredAge: Int {
        return getFittingValuable(male: 25, female: 19)
    }
    
    var preferredHeight: Int {
        return getFittingValuable(male: 187, female: 172)
    }
    
    func getFittingValuable<T>(male: T, female: T) -> T {
        switch self {
        case .male: return male
        case .female: return female
        }
    }
    
    private var ageCapping: [Double] {
        return getFittingValuable(male: Sex.maleAgeCapping, female: Sex.femaleAgeCapping)
    }
    
    func ageCapping(_ age: Int) -> Int {
        return Int(ceil(Sex.getSpline(ageCapping, forAge: age)))
    }
    
    private static func getSpline(_ values: [Double], forAge age: Int) -> Double {
        let t = Double(age % 5) / 5.0
        let index = min(Int(age / 5), values.count - 4)
        let pt0 = values[index]
        let pt1 = values[index + 1]
        let pt2 = values[index + 2]
        let pt3 = values[index + 3]
        
        return Sex.catmullRomSpline(p0: pt0, p1: pt1, p2: pt2, p3: pt3, time: t)
    }
    
    private static func catmullRomSpline(p0: Double, p1: Double, p2: Double, p3: Double, time: Double) -> Double {
        return 0.5 * ((2.0 * p1) + (-p0 + p2) * time + (2.0 * p0 - 5.0 * p1 + 4 * p2 - p3) * time * time + (-p0 + 3.0 * p1 - 3.0 * p2 + p3) * time * time * time)
    }
}

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
