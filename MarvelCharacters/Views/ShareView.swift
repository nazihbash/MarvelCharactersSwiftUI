//
//  ShareView.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import SwiftUI

struct ShareView: UIViewControllerRepresentable {
	typealias UIViewControllerType = UIActivityViewController
	
	let items: [Any]
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ShareView>) -> UIActivityViewController {
		UIActivityViewController(activityItems: items, applicationActivities: nil)
	}
	
	func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareView>) {
	}
}
