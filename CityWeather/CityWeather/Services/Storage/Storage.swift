//
//  Storage.swift
//  CityWeather
//
//  Created by Houcem Soued on 15/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation

extension StorageService {
    static let prod = StorageService(withPath: "cities")
}

final class StorageService {
    let path: String
    
    init(withPath path: String?) {
        let pathName = path ?? "documents"
        self.path = "/\(pathName).json"
    }
    
    func saveCities(_ cities: [City]) {
        guard let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            else { return }
        save(cities, to: documentsDir.appending(path))
    }

    func loadCities() -> [City] {
        guard let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        else { return [City]() }

        if let storedCities: [City] = load(from: documentsDir.appending(path)) {
             return storedCities
        } else {
            return [City]()
        }
    }
}

private extension StorageService {
    func load<T: Decodable>(from path: String, as type: T.Type = T.self) -> T? {
        let data: Data

        do {
            data = try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            debugPrint("Couldn't load from main bundle")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint("Couldn't parse Data")
            return nil
        }
    }

    func save<T: Encodable>(_ data: T, to path: String) {
        let url = URL(fileURLWithPath: path)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let JsonData = try encoder.encode(data)
            try JsonData.write(to: url)
        } catch {
            debugPrint("Couldn't save to \(path)")
        }
    }
}
