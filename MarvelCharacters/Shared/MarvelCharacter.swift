//
//  MarvelCharacter.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import Foundation

struct MarvelCharacter: Codable, Hashable, Identifiable {
	
	private static let wikiUrlType = "detail"
	
	let id: Int
	let name: String
	let details: String
	let thumbnail: CharacterThumbnail
	let urls: [CharacterUrl]

	var imageUrl: URL? {
		return thumbnail.completeURL
	}

	var wikiUrl: URL? {
		return urls.first(where: { $0.type == MarvelCharacter.wikiUrlType })?.url
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case details = "description"
		case thumbnail
		case urls
	}
}

struct CharacterUrl: Codable, Hashable {
	let type: String
	let url: URL
}

struct CharacterThumbnail: Codable, Hashable {
	let path: String
	let ext: String
	
	var completeURL: URL? {
		return URL(string: path + "." + self.ext)
	}
	
	enum CodingKeys: String, CodingKey {
		case path
		case ext = "extension"
	}
}

struct CharactersResponse: Decodable {
	
	let data: CharactersDataResponse
	
	struct CharactersDataResponse: Decodable {
		let results: [MarvelCharacter]
		let offset: Int
		let limit: Int
		let total: Int  //The total number of resources available given the current filter set.
	}
}
