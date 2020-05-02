//
//  ImagePlaceHolderView.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import SwiftUI

struct ImagePlaceHolderView: View {
	var body: some View {
		ActivityIndicator(isAnimating: .constant(true), style: .medium)
	}
}
