//
//  RootCoordinator.swift
//  IssueTracker
//
//  Created by 김영렬 on 2020/10/27.
//

import UIKit

protocol Coordinator: class {
    func start()
}

class RootCoordinator: Coordinator {
    private var window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signViewController = storyBoard.instantiateViewController(withIdentifier: "Signin") as? SignInViewController
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar") as? TabBarViewController
        //window?.rootViewController = signViewController
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
    }
}
