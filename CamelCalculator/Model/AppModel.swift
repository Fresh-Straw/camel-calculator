//
//  AppModel.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 11.01.21.
//

import Foundation

final class CamelAppModel : ObservableObject {
    @Published var persons: [Person] = [.example1, .example2, .example3, .example4]
    @Published var computationNavigationActive = false
    @Published var resultNavigationActive = false
    @Published var personSortOrder: PersonSortOrder = .byResultDown
    
    func finishPersonComputation(for person: Person) {
        persons.append(person)
        computationNavigationActive = false
    }
    
    func getNextSortOrder() -> PersonSortOrder {
        let currentIndex = PersonSortOrder.allCases.firstIndex(of: personSortOrder)!
        let newIndex = (currentIndex + 1) % PersonSortOrder.allCases.count
        return PersonSortOrder.allCases[newIndex]
    }
    
    func delete(person: Person) {
        // TODO
        self.resultNavigationActive = false
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

