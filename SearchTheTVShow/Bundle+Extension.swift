//
//  Bundle+Extension.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import Foundation

extension Bundle {
    var tmdb: String {
        return fetchKey(.tmdb)
    }
    
    enum Targets: String {
        case tmdb
    }
    
    enum BundleError: Error {
        case unknownFilePath, invalidFormat, unknownAPIKey
    }
    
    func fetchKey(_ target: Targets) -> String {
        guard let path = path(forResource: "APIKeys", ofType: "plist") else { fatalError(BundleError.unknownFilePath.localizedDescription)
        }
        guard let file = NSDictionary(contentsOfFile: path) else { fatalError(BundleError.invalidFormat.localizedDescription)
        }
        guard let key = file[target.rawValue] as? String else {
            fatalError(BundleError.unknownAPIKey.localizedDescription)
        }
        return key
    }
}
