//
//  CamelModel.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

var ageRange = 0.0...120.0
var heightRange = 120.0...220.0

// var persons: [Person] = []

struct Person: Identifiable {
    static var example1 = Person(name: "Tarzan", sex: .male, age: 23, height: 175, hairColor: .black, hairLength: .shoulder, eyeColor: .green, boobSize: BoobSize.c, beard: nil, figure: .sporty)
    static var example2 = Person(name: "Jane", sex: .female, age: 23, height: 169, hairColor: .blond, hairLength: .long, eyeColor: .brown, boobSize: BoobSize.c, beard: nil, figure: .sporty)
    static var example3 = Person(name: "Claire", sex: .female, age: 30, height: 172, hairColor: .blond, hairLength: .long, eyeColor: .blue, boobSize: BoobSize.c, beard: nil, figure: .normal)
    static var example4 = Person(name: "Phil", sex: .male, age: 34, height: 184, hairColor: .blond, hairLength: .short, eyeColor: .blue, boobSize: nil, beard: .threeDay, figure: .thin)
    static var `default` = example2
    static var empty = Person(name: "", sex: nil, age: 20, height: 160, hairColor: nil, hairLength: nil, eyeColor: nil, boobSize: nil, beard: nil, figure: nil)
    
    var id: String { name }
    
    // TODO check for null values
    var name: String
    var sex: Sex?
    var age: Double
    var height: Double
    var hairColor: HairColor?
    var hairLength: HairLength?
    var eyeColor: EyeColor?
    var boobSize: BoobSize?
    var beard: Beard?
    var figure: Figure?
    
    var camelValue: CamelValue {
        return CamelValue(person: self)
    }
}


enum Sex: String, CaseIterable, Codable, Identifiable {
    case male = "male"
    case female = "female"
    
    var id: String { self.rawValue }
}

enum HairColor: String, Codable, CaseIterable, Identifiable {
    case blond = "blond"
    case brown = "brown"
    case black = "black"
    case red = "red"
    case grey = "grey"
    
    var id: String { self.rawValue }
}

enum HairLength: String, Codable, CaseIterable, Identifiable {
    case noHair = "noHair"
    case short = "short"
    case shoulder = "shoulder"
    case long = "long"
    
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
