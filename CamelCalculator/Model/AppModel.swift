//
//  AppModel.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 11.01.21.
//

import Foundation
import SwiftUI
import Combine

final class CamelAppModel : ObservableObject {
    static var example1 = Person(id: CamelAppModel.getNextId(), name: "Tarzan", sex: .male, age: 23, height: 175, hairColor: .black, hairLength: .shoulder, eyeColor: .green, boobSize: BoobSize.c, beard: nil, figure: .normal, humor: .meeeh, intellgence: .dumb, loyalty: .AlwaysOnMySide, bloodPressure: .bp140to85, lungVolume: 2)
    private static var example2 = Person(id: CamelAppModel.getNextId(), name: "Jane", sex: .female, age: 23, height: 169, hairColor: .blond, hairLength: .long, eyeColor: .brown, boobSize: BoobSize.c, beard: nil, figure: .thin, humor: .veryFunny, intellgence: .Einstein, loyalty: .kindOfOk, bloodPressure: .bp130to80, lungVolume: 4)
    private static var example3 = Person(id: CamelAppModel.getNextId(), name: "Claire", sex: .female, age: 30, height: 172, hairColor: .blond, hairLength: .long, eyeColor: .blue, boobSize: BoobSize.c, beard: nil, figure: .normal, humor: .okish, intellgence: .mediocre, loyalty: .LikeTheWind, bloodPressure: .bp140to85, lungVolume: 8)
    private static var example4 = Person(id: CamelAppModel.getNextId(), name: "Phil", sex: .male, age: 34, height: 184, hairColor: .blond, hairLength: .short, eyeColor: .blue, boobSize: nil, beard: .threeDay, figure: .thin, humor: .notAtAll, intellgence: .quiteSmart, loyalty: .LikeTheWind, bloodPressure: .bp110to80, lungVolume: 6)
    
    private static var currentId: Int = 0
    private static let currentIdLock = NSLock()
    
    fileprivate static func getNextId() -> Int {
        currentIdLock.lock()
        defer { currentIdLock.unlock() }
        currentId += 1
        return currentId
    }
    
    @Published var persons: [Person] = [CamelAppModel.example1, CamelAppModel.example2, CamelAppModel.example3, CamelAppModel.example4]
    @Published var personSortOrder: PersonSortOrder = .byResultDown
    
    @Published var appState: CamelState = .Home
    @Published var currentPerson: Person = .empty
    var transition: AnyTransition = AnyTransition.opacity.combined(with: .scale) //AnyTransition.asymmetric(insertion: AnyTransition.move(edge: .trailing), removal: AnyTransition.move(edge: .leading))
    
    
    init() {
        let defaults = UserDefaults.standard
        let abc = defaults.integer(forKey: "person.id")
        CamelAppModel.currentId = abc
        personSortOrder = PersonSortOrder(rawValue: defaults.string(forKey: "person.sortOrder") ?? PersonSortOrder.byResultDown.rawValue)!
        do {
            let json = defaults.string(forKey: "person.list") ?? "[]"
            try persons = JSONDecoder().decode([Person].self, from: json.data(using: .utf8)!)
        } catch {
            // doesn't matter... just implicitly reset app to default
            // fatalError("Unable to load settings: \n\(error)")
        }
    }
    
    func finishPersonComputation(for personToCopy: Person) {
        let newPerson = Person(id: CamelAppModel.getNextId(), person: personToCopy)
        persons.append(newPerson)
        saveData()
        appState = .Home
    }
    
    func delete(person: Person) {
        persons.removeAll(where: { $0.id == person.id })
        saveData()
        appState = .Home
    }
    
    func saveData() {
        // https://stackoverflow.com/questions/28628225/how-to-save-local-data-in-a-swift-app
        let defaults = UserDefaults.standard
        defaults.set(CamelAppModel.currentId, forKey: "person.id")
        defaults.set(personSortOrder.rawValue, forKey: "person.sortOrder")
        do {
            let json = String(data: try JSONEncoder().encode(persons), encoding: .utf8)
            defaults.set(json, forKey: "person.list")
        } catch {
            fatalError("Unable to save settings: \n\(error)")
        }
    }
    
    func getNextSortOrder() -> PersonSortOrder {
        let currentIndex = PersonSortOrder.allCases.firstIndex(of: personSortOrder)!
        let newIndex = (currentIndex + 1) % PersonSortOrder.allCases.count
        return PersonSortOrder.allCases[newIndex]
    }
}

enum CamelState: Int, Equatable {
    case Home, NameAndAge, OuterValues, InnerValues, ComputeResult, ShowResult
}

struct Person: Identifiable, Codable, Equatable {
    static var `default` = Person(name: "Jane", sex: .female, age: 23, height: 169, hairColor: .blond, hairLength: .long, eyeColor: .brown, boobSize: BoobSize.c, beard: nil, figure: .normal, humor: .veryFunny, intellgence: .quiteSmart, loyalty: .AlwaysOnMySide, bloodPressure: .bp110to80, lungVolume: 3.4)
    static var empty = Person(name: "", sex: nil, age: 20, height: 160, hairColor: nil, hairLength: nil, eyeColor: nil, boobSize: nil, beard: nil, figure: nil, humor: nil, intellgence: nil, loyalty: nil, bloodPressure: nil, lungVolume: 3)
    
    fileprivate init(id: Int, person: Person) {
        self.init(id: id, name: person.name, sex: person.sex, age: person.age, height: person.height, hairColor: person.hairColor, hairLength: person.hairLength, eyeColor: person.eyeColor, boobSize: person.boobSize, beard: person.beard, figure: person.figure, humor: person.humor, intellgence: person.intelligence, loyalty: person.loyalty, bloodPressure: person.bloodPressure, lungVolume: person.lungVolume)
    }
    
    fileprivate init(id: Int = CamelAppModel.getNextId(), name: String, sex: Sex?, age: Double, height: Double, hairColor: HairColor?, hairLength: HairLength?, eyeColor: EyeColor?, boobSize: BoobSize?, beard: Beard?, figure: Figure?, humor: Humor?, intellgence: Intelligence?, loyalty: Loyalty?, bloodPressure: BloodPressure?, lungVolume: Double?) {
        self.id = id
        self.name = name.trimName()
        self.sex = sex
        self.age = age
        self.height = height
        self.hairColor = hairColor
        self.hairLength = hairLength
        self.eyeColor = eyeColor
        self.boobSize = boobSize
        self.beard = beard
        self.figure = figure
        
        self.humor = humor
        self.intelligence = intellgence
        self.loyalty = loyalty
        self.bloodPressure = bloodPressure
        self.lungVolume = lungVolume
    }
    
    var id: Int
    
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
    
    var humor: Humor?
    var intelligence: Intelligence?
    var loyalty: Loyalty?
    var bloodPressure: BloodPressure?
    var lungVolume: Double?
    
    var camelValue: CamelValue {
        return CamelValue(person: self)
    }
}


enum PersonSortOrder: String, Codable, CaseIterable, Identifiable {
    case byNameUp = "byNameUp"
    case byNameDown = "byNameDown"
    case byResultUp = "byResultUp"
    case byResultDown = "byResultDown"
    
    var id: String { self.rawValue }
}

struct PersonResult {
    let name: String
    let date: Date
    let sex: Sex
    let camelResult: Int
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

