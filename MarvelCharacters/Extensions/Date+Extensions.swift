//
//  Date+Extensions.swift
//  MarvelCharacters
//
//  Created by Myki on 5/3/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import Foundation

extension Date {
	var differenceInDaysFromNow: Int {
		return Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
	}
}
