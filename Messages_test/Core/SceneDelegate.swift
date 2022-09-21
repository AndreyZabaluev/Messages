//
//  SceneDelegate.swift
//  Messages_test
//
//  Created by Andrey Zabaluev  on 08.09.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let messagesService = MessagesServiceImpl()
        let presenter = MessagesPresenter(messagesService: messagesService)
        let viewController = MessagesViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
}
