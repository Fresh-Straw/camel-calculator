//
//  CamelMath.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import Foundation

struct CamelValue {
    let person: Person
    var age: Change
    var height: Change
    var hairColor: Change
    var hairLength: Change
    var eyeColor: Change
    var extra: Change
    var figure: Change
    
    var humor: Change
    var intelligence: Change
    var loyalty: Change
    var bloodPressure: Change
    var lungVolume: Change
    
    var sum: Change
    
    init(person: Person) {
        // the original person data
        self.person = person
        
        guard person.sex != nil else {
            fatalError("No sex given.")
        }
        let sex: Sex = person.sex!
        
        // main capping value - it is not possible to get a score higher than this
        let capping = Int(computeAgeCapping(forAge: person.age, andSex: sex))
        
        // compute the other values
        age = Change(summand: Double(Int(Double(capping) * 0.4)), factor: 1.0)
        height = getValueFor(height: person.height, sex: sex)
        hairColor = getValueFor(hairColor: person.hairColor)
        hairLength = getValueFor(hairLength: person.hairLength, andSex: person.sex)
        eyeColor = getValueFor(eyeColor: person.eyeColor)
        figure = getValueFor(figure: person.figure)
        switch sex {
            case .female: extra = getValueFor(boobSize: person.boobSize)
            case .male: extra = getValueFor(beard: person.beard)
        }
        
        humor = getValueFor(humor: person.humor)
        intelligence = getValueFor(intelligence: person.intelligence)
        loyalty = getValueFor(loyalty: person.loyalty)
        bloodPressure = getValueFor(bloodPressure: person.bloodPressure)
        lungVolume = getValueFor(lungVolume: person.lungVolume)
        
        sum = Change(changes: [age, height, hairLength, hairColor, eyeColor, extra, figure, humor, intelligence, loyalty, bloodPressure, lungVolume])
    }
}

struct Change {
    static let Nothing = Change(summand: 0, factor: 1)
    
    var summand: Double
    var factor: Double
    
    init(summand: Double, factor: Double) {
        self.summand = summand
        self.factor = factor
    }
    
    init(changes: [Change]) {
        self.summand = changes.map {$0.summand}.reduce(0, +)
        self.factor = changes.map {$0.factor}.reduce(1, *)
    }
    
    var result: Int { Int(summand * factor) }
}

func getFittingValuable<T>(sex: Sex, male: T, female: T) -> T {
    switch sex {
    case .male: return male
    case .female: return female
    }
}

// MARK: Value Computation

// TODO remove
private func getValueFor(height: Double, sex: Sex) -> Change {
    let preferredHeight: Double = getFittingValuable(sex: sex, male: 186, female: 172)
    return Change(summand: Double(max(0, computeValue(height, max: 18.5, preferred: preferredHeight, divisor: 12))), factor: 1)
}

// TODO remove
private func computeValue(_ value: Double, max: Double, preferred preferredValue: Double, divisor: Double) -> Int {
    let xOffset = Double(value) - Double(preferredValue)
    let adjustedOffset = pow(xOffset / Double(divisor), 2)
    return Int(Double(max) - adjustedOffset)
}

private func getValueFor(hairColor: HairColor?) -> Change {
    switch hairColor {
    case .blond: return Change(summand: 6, factor: 1.06)
    case .brown: return Change(summand: 3, factor: 1.02)
    case .black: return Change(summand: 3, factor: 0.98)
    case .red: return Change(summand: 4, factor: 1.062)
    case .grey: return Change(summand: -1, factor: 0.982)
    default: return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(hairLength: HairLength?, andSex sex: Sex?) -> Change {
    switch sex {
    case .female:
        switch hairLength {
        case .noHair: return Change(summand: -5, factor: 0.92)
        case .short: return Change(summand: 1, factor: 0.95)
        case .shoulder: return Change(summand: 1, factor: 1)
        case .long: return Change(summand: 5, factor: 1.08)
        default: return Change(summand: 0, factor: 1)
        }
    case .male:
        switch hairLength {
        case .noHair: return Change(summand: 2, factor: 1.05)
        case .short: return Change(summand: 6, factor: 1.03)
        case .shoulder: return Change(summand: 5, factor: 1.025)
        case .long: return Change(summand: 4, factor: 1.035)
        default: return Change(summand: 0, factor: 1)
        }
    default: return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(eyeColor: EyeColor?) -> Change {
    switch eyeColor {
    case .blue: return Change(summand: 4, factor: 1.02)
    case .green: return Change(summand: 3, factor: 1.013)
    case .brown: return Change(summand: 2, factor: 1.007)
    case .grey: return Change(summand: -2, factor: 0.99)
    default: return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(boobSize: BoobSize?) -> Change {
    switch boobSize {
    case .a: return Change(summand: 5, factor: 1)
    case .b: return Change(summand: 5, factor: 1.05)
    case .c: return Change(summand: 7, factor: 1.04)
    case .d: return Change(summand: 6, factor: 1.03)
    default: return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(figure: Figure?) -> Change {
    switch figure {
    case .thin: return Change(summand: 4, factor: 1.001)
    //case .sporty: return Change(summand: 7, factor: 1.03)
    case .normal: return Change(summand: 5.5, factor: 1)
    case .chubby: return Change(summand: 1, factor: 1)
    case .fat: return Change(summand: -1, factor: 0.98)
    default: return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(beard: Beard?) -> Change {
    switch beard {
    case .noBeard: return Change(summand: 1, factor: 1.05)
    case .mustache: return Change(summand: 3, factor: 1.06)
    case .threeDay: return Change(summand: 5, factor: 1.07)
    case .full: return Change(summand: 3, factor: 1.08)
    default: return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(humor: Humor?) -> Change {
    guard let humor else { return Change.Nothing }
    
    switch humor {
    case .notAtAll:
        return Change(summand: 0, factor: 1)
    case .meeeh:
        return Change(summand: 0, factor: 1)
    case .okish:
        return Change(summand: 0, factor: 1)
    case .veryFunny:
        return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(intelligence: Intelligence?) -> Change {
    guard let intelligence else { return Change.Nothing }
    
    switch intelligence {
    case .Einstein:
        return Change(summand: 0, factor: 1)
    case .quiteSmart:
        return Change(summand: 0, factor: 1)
    case .mediocre:
        return Change(summand: 0, factor: 1)
    case .dumb:
        return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(loyalty: Loyalty?) -> Change {
    guard let loyalty else { return Change.Nothing }
    
    switch loyalty {
    case .AlwaysOnMySide:
        return Change(summand: 0, factor: 1)
    case .kindOfOk:
        return Change(summand: 0, factor: 1)
    case .LikeTheWind:
        return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(bloodPressure: BloodPressure?) -> Change {
    guard let bloodPressure else { return Change.Nothing }
    
    switch bloodPressure {
    case .bp110to80:
        return Change(summand: 0, factor: 1)
    case .bp120to80:
        return Change(summand: 0, factor: 1)
    case .bp130to80:
        return Change(summand: 0, factor: 1)
    case .bp140to85:
        return Change(summand: 0, factor: 1)
    case .bp160to100:
        return Change(summand: 0, factor: 1)
    }
}

private func getValueFor(lungVolume: Double?) -> Change {
    guard let lungVolume else { return Change.Nothing }
    
    return Change.Nothing
}



// MARK: Age capping
private var femaleAgeCapping: [Double] = [0,10,40,53,76,110,90,85,70,45,34,26,23,19,16,14,12,10,8,6,5,4,3,2,1]
private var maleAgeCapping: [Double] = [0,13,28,53,98,109,111,87,70,52,38,29,23,19,16,14,12,10,8,6,5,4,3,2,1]

private func computeAgeCapping(forAge age: Double, andSex sex: Sex) -> Int {
    let cappingRawValues = getFittingValuable(sex: sex, male: maleAgeCapping, female: femaleAgeCapping)
    return Int(ceil(getSpline(forValues: cappingRawValues, atPosition: age)))
}

// MARK: Freaky math
// the spline computation for the age capping

private func getSpline(forValues values: [Double], atPosition position: Double) -> Double {
    let intPosition = Int(position)
    let t = Double(intPosition % 5) / 5.0
    let index = min(intPosition / 5, values.count - 4)
    
    return catmullRomSpline(p0: values[index], p1: values[index + 1], p2: values[index + 2], p3: values[index + 3], time: t)
}

private func catmullRomSpline(p0: Double, p1: Double, p2: Double, p3: Double, time: Double) -> Double {
    return 0.5 * ((2.0 * p1) + (-p0 + p2) * time + (2.0 * p0 - 5.0 * p1 + 4 * p2 - p3) * time * time + (-p0 + 3.0 * p1 - 3.0 * p2 + p3) * time * time * time)
}
