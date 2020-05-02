//
//  MarvelService.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import Foundation
import Combine

enum ServiceError: Error {
	case invalidURL
	case url(error: URLError)
	case decoder(error: Error)
}

protocol MarvelFetchable {
	func fetch(offset: Int) -> AnyPublisher<[MarvelCharacter], ServiceError>
}

struct MarvelService: MarvelFetchable {
	
	struct MarvelServiceConstants {
		fileprivate static let publicApiKey = "f971fc5cb921036c6c40587d679b85ad"
		fileprivate static let privateApiKey = "4aef6aeeb34bc46d828766d915931467aead6d6c"
		static let limit = 30
	}
	
	let session: URLSession
	let decoder: JSONDecoder
	
	func fetch(offset: Int) -> AnyPublisher<[MarvelCharacter], ServiceError> {
		var components = URLComponents()
		
		components.scheme = "https"
		components.host = "gateway.marvel.com"
		components.path = "/v1/public/characters"
		
		let timeStamp = Int(Date().timeIntervalSince1970)
		let hash = "\(timeStamp)\(MarvelServiceConstants.privateApiKey)\(MarvelServiceConstants.publicApiKey)".md5()

		components.queryItems = [
			.init(name: "limit", value: String(MarvelServiceConstants.limit)),
			.init(name: "offset", value: String(offset)),
			.init(name: "apikey", value: MarvelServiceConstants.publicApiKey),
			.init(name: "ts", value: String(timeStamp)),
			.init(name: "hash", value: hash)
		]
		
		guard let url = components.url else {
			return Fail<[MarvelCharacter], ServiceError>(error: .invalidURL)
				.eraseToAnyPublisher()
		}
		
		return session
			.dataTaskPublisher(for: URLRequest(url: url))
			.mapError { ServiceError.url(error: $0) }
			.map { $0.data }
			.decode(type: CharactersResponse.self, decoder: decoder)
			.mapError { rr in
				print(rr.localizedDescription)
				return ServiceError.decoder(error: rr)
		}
			.map { $0.data.results }
			.eraseToAnyPublisher()
	}
}

