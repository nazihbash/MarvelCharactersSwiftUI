//
//  LaunchCounter.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import Foundation

class LaunchCounter {
	private enum Launcher {
		static let first = "launcher_first"
		static let count = "launcher_count"
		static let minLaunchCount = 7
		static let minDays = 3
	}
	
	private let defaults: UserDefaults
	init(defaults: UserDefaults = .standard) {
		self.defaults = defaults
	}
	
	var isReadyToRate: Bool {
		let count = defaults.integer(forKey: Launcher.count)
		let first = defaults.object(forKey: Launcher.first) as? Date ?? Date(timeIntervalSince1970: 0)
		let days = Calendar.current.dateComponents([.day], from: first, to: Date()).day ?? 0
		return days > Launcher.minDays && count > Launcher.minLaunchCount
	}
	
	@discardableResult
	func launch() -> Int {
		if defaults.object(forKey: Launcher.first) == nil {
			defaults.set(Date(), forKey: Launcher.first)
		}
		
		var count = defaults.integer(forKey: Launcher.count)
		count += 1
		defaults.set(count, forKey: Launcher.count)
		return count
	}
}
