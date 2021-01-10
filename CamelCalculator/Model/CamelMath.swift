//
//  CamelMath.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import Foundation

struct CamelValue {
    private let person: Person
    var capping: Int
    var age: Int
    var height: Int
    var hairColor: Int
    var hairLength: Int
    var eyeColor: Int
    var extra: Int
    var figure: Int
    
    init(person: Person) {
        // the original person data
        self.person = person
        
        // main capping value - it is not possible to get a score higher than this
        capping = computeAgeCapping(forAge: person.age, andSex: person.sex)
        
        // compute the other values
        age = getValueFor(age: person.age, sex: person.sex)
        height = getValueFor(height: person.height, sex: person.sex)
        hairColor = getValueFor(hairColor: person.hairColor)
        hairLength = getValueFor(hairLength: person.hairLength)
        eyeColor = getValueFor(eyeColor: person.eyeColor)
        figure = getValueFor(figure: person.figure)
        switch person.sex {
        case .female: extra = getValueFor(boobSize: person.boobSize)
        case .male: extra = getValueFor(beard: person.beard)
        }
    }
    
    var uncappedSum: Int {
        return age + height + hairColor + hairLength + eyeColor + extra + figure
    }
    
    var result: Int {
        return min(uncappedSum, capping)
    }
}

func getFittingValuable<T>(sex: Sex, male: T, female: T) -> T {
    switch sex {
    case .male: return male
    case .female: return female
    }
}

// MARK: Value Computation

private func getValueFor(age: Double, sex: Sex) -> Int {
    // https://www.desmos.com/
    // If 19 is the preferred age, then maximum of:
    // * 20-((x)-19)^2/100
    // * (12-(x-19)^2/1000)
    // plus
    // * cos((x-19)/3)/2
    
    let preferredAge: Double = getFittingValuable(sex: sex, male: 23, female: 19)
    let val1 = 20.0 - pow(age - preferredAge, 2.0) / 100.0
    let val2 = 12.0 - pow(age - preferredAge, 2.0) / 1000.0
    let cosinus = cos((age - preferredAge) / 3.0) / 2.0
    
    return Int(max(val1, val2) + cosinus)
}

private func getValueFor(height: Double, sex: Sex) -> Int {
    let preferredHeight: Double = getFittingValuable(sex: sex, male: 186, female: 172)
    return max(0, computeValue(height, max: 18.5, preferred: preferredHeight, divisor: 12))
}

// TODO remove
private func computeValue(_ value: Double, max: Double, preferred preferredValue: Double, divisor: Double) -> Int {
    let xOffset = Double(value) - Double(preferredValue)
    let adjustedOffset = pow(xOffset / Double(divisor), 2)
    return Int(Double(max) - adjustedOffset)
}

private func getValueFor(hairColor: HairColor) -> Int {
    switch hairColor {
    case .blond: return 20
    case .brown: return 16
    case .black: return 10
    case .red: return 17
    case .grey: return 5
    }
}

private func getValueFor(hairLength: HairLength) -> Int {
    switch hairLength {
    case .noHair: return 2
    case .short: return 5
    case .shoulder: return 8
    case .long: return 13
    case .veryLong: return 17
    }
}

private func getValueFor(eyeColor: EyeColor) -> Int {
    switch eyeColor {
    case .blue: return 16
    case .green: return 14
    case .brown: return 10
    case .grey: return 4
    }
}

private func getValueFor(boobSize: BoobSize) -> Int {
    switch boobSize {
    case .a: return 9
    case .b: return 13
    case .c: return 16
    case .d: return 15
    }
}

private func getValueFor(figure: Figure) -> Int {
    switch figure {
    case .thin: return 8
    case .sporty: return 16
    case .normal: return 15
    case .chubby: return 6
    case .fat: return 4
    }
}

private func getValueFor(beard: Beard) -> Int {
    switch beard {
    case .noBeard: return 7
    case .mustache: return 9
    case .threeDay: return 14
    case .full: return 12
    }
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
