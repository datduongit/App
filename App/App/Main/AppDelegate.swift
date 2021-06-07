//
//  AppDelegate.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import UIKit
import Core
import Swinject
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
    internal var deviceToken: String?
    
    internal let container = Container()
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        // APNs
        registerForAPNs()
        
        // DI
        DIContainer.inject(container)
        
        // Coordinator
        appCoordinator = makeAppCoordinator()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = .white
        window?.rootViewController = appCoordinator.toPresentable()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func makeAppCoordinator() -> AppCoordinator {
        let navigation = UINavigationController()
        let router = Router(navigationController: navigation)
        return AppCoordinator(router: router, container: container)
    }


}

