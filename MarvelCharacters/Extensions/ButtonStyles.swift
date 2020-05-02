//
//  ButtonStyles.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration
			.label
			.multilineTextAlignment(.center)
			.fixedSize()
			.padding()
			.foregroundColor(configuration.isPressed ? .gray : .white)
			.background(Color.accentColor)
			.cornerRadius(8)
	}
}
