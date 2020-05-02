//
//  World.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import Foundation
import Combine

final class AppEnvironment {
	let session = URLSession.shared
	let decoder = JSONDecoder()
	let encoder = JSONEncoder()
	let files = FileManager.default
	let counter = LaunchCounter()
	lazy var service: MarvelService =
		MarvelService(session: session, decoder: decoder)
}

struct AppState: Codable {
	var characters: [MarvelCharacter] = []
	var isLoading = false
	var isRestoringState = false
}

enum AppAction {
	case append(characters: [MarvelCharacter])
	case fetch
	case set(state: AppState)
	case resetState
	case load
	case save
}

func appReducer( state: inout AppState, action: AppAction, environment: AppEnvironment) -> AnyPublisher<AppAction, Never>? {
	switch action {
	case let .append(characters):
		Storage.charactersLastUpdatedTime = Date()
		state.isLoading = false
		state.characters.append(contentsOf: characters)
	case .fetch:
		let offset = state.characters.count
		state.isLoading = true
		return environment.service
			.fetch(offset: offset)
			.replaceError(with: [])
			.map { .append(characters: $0)}
			.eraseToAnyPublisher()
	case .resetState:
		state.characters.removeAll()
		state.isLoading = false
		state.isRestoringState = false
	case let .set(newState):
		state.isRestoringState = false
		state = newState
		
		if state.characters.isEmpty {
			return Just(.fetch)
				.eraseToAnyPublisher()
			
		} else if let lastUpdated = Storage.charactersLastUpdatedTime,
			lastUpdated.differenceInDaysFromNow < 2 {
			state.characters.removeAll()
			return Just(.fetch)
				.eraseToAnyPublisher()
		}
	case .load:
		state.isRestoringState = true
		return environment.files
			.read(name: "state.json", in: .applicationSupportDirectory)
			.decode(type: AppState.self, decoder: environment.decoder)
			.replaceError(with: AppState())
			.map { AppAction.set(state: $0) }
			.eraseToAnyPublisher()
	case .save:
		return Just(state)
			.encode(encoder: environment.encoder)
			.flatMap { environment.files.write(data: $0, name: "state.json", in: .applicationSupportDirectory) }
			.map { _ in AppAction.resetState }
			.replaceError(with: .resetState)
			.eraseToAnyPublisher()
	}
	
	return Empty().eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction, AppEnvironment>
