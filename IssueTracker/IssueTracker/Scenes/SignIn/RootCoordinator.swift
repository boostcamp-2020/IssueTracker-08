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
        if UserDefaults.standard.object(forKey: "JWT") == nil {
            let signViewController = storyBoard.instantiateViewController(withIdentifier: "Signin") as? SignInViewController
            window?.rootViewController = signViewController
        }
        else {
            let tabbarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController
            window?.rootViewController = tabbarViewController
        }
        
        window?.makeKeyAndVisible()
    }
}
