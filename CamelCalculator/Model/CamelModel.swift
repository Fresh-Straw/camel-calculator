//
//  CamelModel.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

var ageRange = 14.0...75.0
var heightRange = 140.0...210.0
var lungVolumeRange = 2.0...9.0

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
    case brown = "brown"
    case grey = "grey"

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
    //case sporty = "sporty"
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

enum Humor: String, Codable, CaseIterable, Identifiable {
    case veryFunny = "verFunny"
    case okish = "okish"
    case meeeh = "meeeh"
    case notAtAll = "notAtAll"
    
    var id: String { self.rawValue }
}

enum Intelligence: String, Codable, CaseIterable, Identifiable {
    case dumb
    case mediocre
    case quiteSmart
    case Einstein
    
    var id: String { self.rawValue }
}

enum Loyalty: String, Codable, CaseIterable, Identifiable {
    case LikeTheWind
    case kindOfOk
    case AlwaysOnMySide
    
    var id: String { self.rawValue }
}

enum BloodPressure: String, Codable, CaseIterable, Identifiable {
    case bp110to80
    case bp120to80
    case bp130to80
    case bp140to85
    case bp160to100
    
    var id: String { self.rawValue }
}



// - [ ] Loyal
// - [ ] Zuverlässigkeit
// - [ ] Freundlichkeit
// - [ ] Ehrlich
// - [ ] Intelligenz
// - [ ] Humor
// - [ ] Schweigsam/ Quasselstrippe
// - [ ] Blutdruck
// - [ ] Lungenvolumen
