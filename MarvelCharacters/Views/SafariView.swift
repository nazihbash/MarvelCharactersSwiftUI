//
//  SafariView.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
	typealias UIViewControllerType = SFSafariViewController
	
	let url: URL
	let readerMode: Bool
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
		let configuration = SFSafariViewController.Configuration()
		configuration.entersReaderIfAvailable = readerMode
		return SFSafariViewController(url: url, configuration: configuration)
	}
	
	func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
	}
}
