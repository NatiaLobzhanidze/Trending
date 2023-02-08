//
//  HomeSceneConfiguration.swift
//  Trending
//
//  Created by Natia's Mac on 08.02.23.
//

import Foundation

enum HomeSceneConfiguration {
    static func configure() -> HomeSceneViewController {
        let apiManager = APIManager.shared
        let worker = HomeSceneWorker(api: apiManager)
        let presenter = HomeScenePresenter()
        let interactor = HomeSceneInteractor(presenter: presenter, worker: worker)
        let router = HomeSceneRouter(dataStore: interactor)
        let viewController = HomeSceneViewController(interactor: interactor, router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
