//
//  SceneDelegate.swift
//  MarvelCharacters
//
//  Created by Myki on 5/2/20.
//  Copyright © 2020 nazih. All rights reserved.
//

import UIKit
import SwiftUI
import StoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	
	private let appEnvironment = AppEnvironment()
	private lazy var store = AppStore(initialState: .init(), reducer: appReducer, environment: appEnvironment)

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		if let windowScene = scene as? UIWindowScene {
			UITableView.appearance().separatorColor = .clear
			
		    let window = UIWindow(windowScene: windowScene)
			
			let contentView = CharactersView().environmentObject(store)
		    window.rootViewController = UIHostingController(rootView: contentView)
		    self.window = window
		    window.makeKeyAndVisible()
		}
		
		store.send(.load)
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		store.send(.save)
	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
		appEnvironment.counter.launch()
		
		if appEnvironment.counter.isReadyToRate {
      if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
          SKStoreReviewController.requestReview(in: scene)
      }
		}
	}
}

