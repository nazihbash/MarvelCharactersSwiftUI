//
//  Storage.swift
//  MarvelCharacters
//
//  Created by Myki on 5/3/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T: PropertyListValue> {
	let key: Key
	
	var wrappedValue: T? {
		get { UserDefaults.standard.value(forKey: key.rawValue) as? T }
		set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
	}
}

protocol PropertyListValue {}

extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

struct Key: RawRepresentable {
	let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
	init(stringLiteral: String) {
		rawValue = stringLiteral
	}
}

extension Key {
	static let firstLaunchDate: Key = "firstLaunchDate"
	static let launchCount: Key = "launchCount"
	static let charactersLastUpdatedTime: Key = "charactersLastUpdatedTime"
}

struct Storage {
	@UserDefault(key: .firstLaunchDate)
	static var firstLaunchDate: Date?
	
	@UserDefault(key: .launchCount)
	static var launchCount: Int?
	
	@UserDefault(key: .charactersLastUpdatedTime)
	static var charactersLastUpdatedTime: Date?
}
