//
//  ViewController.swift
//  IssueTracker
//
//  Created by 김영렬 on 2020/10/26.
//
import UIKit
import OctoKit
import AuthenticationServices


class SignInViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet var AuthSignInStackView: UIStackView!
    
    // MARK:- Properties
    var githubManager: GithubManager?
    let appleSignInButton = ASAuthorizationAppleIDButton()
    let githubSignInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInButton()
        githubManager = OAuthGithubManager()
        githubManager?.viewController = self
    }

    private func setupSignInButton() {
        appleSignInButton.addTarget(self, action: #selector(handleAppleSignInPress), for: .touchUpInside)
        githubSignInButton.addTarget(self, action: #selector(handleGithubSignInPress), for: .touchUpInside)
        appleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        appleSignInButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        appleSignInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        githubSignInButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        githubSignInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        githubSignInButton.backgroundColor = UIColor.darkGray
        githubSignInButton.setTitle("Sign in Github", for: .normal)
        githubSignInButton.layer.cornerRadius = 5
        
        AuthSignInStackView.addArrangedSubview(githubSignInButton)
        AuthSignInStackView.addArrangedSubview(appleSignInButton)
    }
    
    @objc func handleAppleSignInPress() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @objc func handleGithubSignInPress() {
        githubManager?.signInWithGithub()
    }
    
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let userEmail = appleIDCredential.email
            print(userIdentifier)
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let username = passwordCredential.user
            print(username)
        }
    }
  
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //print("error")
    }
}

// Github
extension SignInViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

// Apple
extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

