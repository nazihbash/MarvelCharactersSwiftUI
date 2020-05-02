//
//  FileManager+Extensions.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import Foundation
import Combine

extension FileManager {
	func read(name: String, in directory: SearchPathDirectory) -> AnyPublisher<Data, Error> {
		return Deferred {
			return Future { promise in
				do {
					let documentsURL = try self.url(
						for: .applicationSupportDirectory,
						in: .userDomainMask,
						appropriateFor: nil,
						create: true
					)
					
					let fileURL = documentsURL.appendingPathComponent(name)
					promise(.success(try Data(contentsOf: fileURL)))
				} catch {
					promise(.failure(error))
				}
			}
		}.eraseToAnyPublisher()
	}
	
	func write(data: Data, name: String, in directory: SearchPathDirectory) -> AnyPublisher<URL, Error> {
		return Deferred {
			return Future { promise in
				do {
					let documentsURL = try self.url(
						for: .applicationSupportDirectory,
						in: .userDomainMask,
						appropriateFor: nil,
						create: true
					)
					
					let url = documentsURL.appendingPathComponent(name)
					try data.write(to: url, options: .atomic)
					
					promise(.success(url))
				} catch {
					promise(.failure(error))
				}
			}
		}.eraseToAnyPublisher()
	}
}
