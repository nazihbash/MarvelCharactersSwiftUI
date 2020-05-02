//
//  CharacterDetailView.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct CharacterDetailView: View {
	let character: MarvelCharacter
	@State private var wikiShown = false
	@State private var shareShwon = false

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				KFImage(character.imageUrl)
					.placeholder{ ImagePlaceHolderView() }
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: 300)
					.clipped()
				
				VStack(alignment: .leading, spacing: 16) {
					VStack(alignment: .leading, spacing: 8) {
						Text(character.name)
							.font(.title)
						
						Text(character.details)
							.font(.subheadline)
						
					}
					
					if character.wikiUrl != nil {
						Button(action: { self.wikiShown = true }) {
							Text("Show Wiki")
						}.buttonStyle(FilledButtonStyle())
					}
				}.padding(.horizontal)
			}
		}
		.navigationBarItems(
			trailing: HStack(spacing: 16) {
				if character.wikiUrl != nil {
					Button(action: { self.shareShwon = true }) {
						Image(systemName: "square.and.arrow.up")
							.font(.headline)
					}.sheet(isPresented: $shareShwon) {
						ShareView(items: [self.character.wikiUrl!])
					}
				}
			})
		.sheet(isPresented: $wikiShown) {
			SafariView(
				url: self.character.wikiUrl!,
				readerMode: true
			)
				.navigationBarTitle(Text(self.character.name), displayMode: .inline)
		}
		.navigationBarTitle(Text(character.name), displayMode: .inline)
	}
}
