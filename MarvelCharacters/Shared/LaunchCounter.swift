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
		static let minLaunchCount = 7
		static let minDays = 3
	}
	
	var isReadyToRate: Bool {
		let launchCount = Storage.launchCount ?? 0
		let firstLaunchDate = Storage.firstLaunchDate ?? Date()
		return firstLaunchDate.differenceInDaysFromNow > Launcher.minDays
			&& launchCount > Launcher.minLaunchCount
	}
	
	@discardableResult
	func launch() -> Int {
		if Storage.firstLaunchDate == nil {
			Storage.firstLaunchDate = Date()
		}
		
		var launchCount = Storage.launchCount ?? 0
		launchCount += 1
		Storage.launchCount = launchCount
		return launchCount
	}
}
