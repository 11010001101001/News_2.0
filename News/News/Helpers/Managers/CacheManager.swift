//
//  CacheManager.swift
//  News
//
//  Created by Ярослав Куприянов on 04.07.2024.
//

import Foundation
import SwiftUI

struct CacheManager {
    static let shared = CacheManager()

    private let cache = NSCache<AnyObject, AnyObject>()

    func save(object: AnyObject, key: AnyObject) {
        cache.setObject(object, forKey: key)
    }

    func get(key: AnyObject) -> AnyObject? {
        cache.object(forKey: key)
    }
}
