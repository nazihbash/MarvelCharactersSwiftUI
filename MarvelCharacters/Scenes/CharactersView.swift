//
//  CharactersView.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct CharactersView: View {
	@EnvironmentObject var store: AppStore
	
	fileprivate var isLoading: Bool {
		store.state.isLoading
	}
	
	fileprivate var isRestoringState: Bool {
		store.state.isRestoringState
	}
	
	fileprivate var characters: [MarvelCharacter] {
		store.state.characters
	}
	
	var body: some View {
		NavigationView {
            if characters.isEmpty {
                ZStack(alignment: .center) {
                    ActivityIndicator(isAnimating: .constant(true),
                                      style: .medium)
                }
            } else {
                list
                    .navigationBarTitle("Marvel Characters")
            }
		}
		.onAppear {
			if !self.isLoading && !self.isRestoringState && self.characters.isEmpty {
				self.store.send(.fetch)
			}
		}
		//onAppear is subscribed to NavigationView, so it will only be called once
	}
	
	private var list: some View {
		List {
			ForEach(characters) { character in
				CharacterRow(character: character)
					.onAppear { self.listItemAppears(character) }
			}
			if isLoading {
				footerActivityIndicator
			}
		}
	}
	
	private var footerActivityIndicator: some View {
		HStack {
			Spacer()
			ActivityIndicator(isAnimating: .constant(true), style: .medium)
				.frame(width: 30, height: 30, alignment: .center)
			Spacer()
		}
	}
}
fileprivate extension CharactersView {
	
	func listItemAppears<Item: Identifiable>(_ item: Item) {
		if characters.isLastItem(item) && !isLoading && !isRestoringState {
			store.send(.fetch)
		}
	}
}
struct CharacterRow: View {
	let character: MarvelCharacter
	
	var body: some View {
		NavigationLink(destination: CharacterDetailView(character: character)) {
			ZStack(alignment: .bottomLeading) {
				KFImage(character.imageUrl)
					.placeholder{ ImagePlaceHolderView() }
					.resizable()
					.aspectRatio(contentMode: .fill)
					.cornerRadius(10)
					.shadow(radius: 5)
				
				LinearGradient(
					gradient: .init(colors: [
                                        Color.clear,
                                        Color.black.opacity(0.7)
                    ]),
					startPoint: .center,
					endPoint: .bottom
				)
					.cornerRadius(10)
					.shadow(radius: 5)
				
				
				Text(character.name)
					.font(.title)
					.foregroundColor(.white)
					.padding()
			}
		}
	}
	
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		CharactersView()
	}
}


