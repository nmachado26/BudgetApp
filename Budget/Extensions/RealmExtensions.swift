//
//  RealmExtensions.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import Foundation
import RealmSwift

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
