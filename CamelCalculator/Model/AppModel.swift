//
//  AppModel.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 11.01.21.
//

import Foundation

final class CamelAppModel : ObservableObject {
    private static var example1 = Person(id: CamelAppModel.getNextId(), name: "Tarzan", sex: .male, age: 23, height: 175, hairColor: .black, hairLength: .shoulder, eyeColor: .green, boobSize: BoobSize.c, beard: nil, figure: .sporty)
    private static var example2 = Person(id: CamelAppModel.getNextId(), name: "Jane", sex: .female, age: 23, height: 169, hairColor: .blond, hairLength: .long, eyeColor: .brown, boobSize: BoobSize.c, beard: nil, figure: .sporty)
    private static var example3 = Person(id: CamelAppModel.getNextId(), name: "Claire", sex: .female, age: 30, height: 172, hairColor: .blond, hairLength: .long, eyeColor: .blue, boobSize: BoobSize.c, beard: nil, figure: .normal)
    private static var example4 = Person(id: CamelAppModel.getNextId(), name: "Phil", sex: .male, age: 34, height: 184, hairColor: .blond, hairLength: .short, eyeColor: .blue, boobSize: nil, beard: .threeDay, figure: .thin)
    
    private static var currentId: Int = 0
    
    fileprivate static func getNextId() -> Int {
        currentId += 1
        return currentId
    }
    
    @Published var persons: [Person] = [CamelAppModel.example1, CamelAppModel.example2, CamelAppModel.example3, CamelAppModel.example4]
    @Published var computationNavigationActive = false
    @Published var personSortOrder: PersonSortOrder = .byResultDown
   
    func finishPersonComputation(for person: Person) {
        persons.append(Person(id: CamelAppModel.getNextId(), person: person))
        computationNavigationActive = false
    }
    
    func getNextSortOrder() -> PersonSortOrder {
        let currentIndex = PersonSortOrder.allCases.firstIndex(of: personSortOrder)!
        let newIndex = (currentIndex + 1) % PersonSortOrder.allCases.count
        return PersonSortOrder.allCases[newIndex]
    }
    
    func delete(person: Person) {
        persons.removeAll(where: { $0.id == person.id })
    }
}

struct Person: Identifiable {
    static var `default` = Person(name: "Jane", sex: .female, age: 23, height: 169, hairColor: .blond, hairLength: .long, eyeColor: .brown, boobSize: BoobSize.c, beard: nil, figure: .sporty)
    static var empty = Person(name: "", sex: nil, age: 20, height: 160, hairColor: nil, hairLength: nil, eyeColor: nil, boobSize: nil, beard: nil, figure: nil)
    
    fileprivate init(id: Int, person: Person) {
        self.init(id: id, name: person.name, sex: person.sex, age: person.age, height: person.height, hairColor: person.hairColor, hairLength: person.hairLength, eyeColor: person.eyeColor, boobSize: person.boobSize, beard: person.beard, figure: person.figure)
    }
    
    fileprivate init(id: Int = CamelAppModel.getNextId(), name: String, sex: Sex?, age: Double, height: Double, hairColor: HairColor?, hairLength: HairLength?, eyeColor: EyeColor?, boobSize: BoobSize?, beard: Beard?, figure: Figure?) {
        self.id = id
        self.name = name
        self.sex = sex
        self.age = age
        self.height = height
        self.hairColor = hairColor
        self.hairLength = hairLength
        self.eyeColor = eyeColor
        self.boobSize = boobSize
        self.beard = beard
        self.figure = figure
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

