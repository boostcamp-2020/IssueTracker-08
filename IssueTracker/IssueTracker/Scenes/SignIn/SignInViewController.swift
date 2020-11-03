//
//  ViewController.swift
//  IssueTracker
//
//  Created by 김영렬 on 2020/10/26.
//
import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {
    @IBOutlet var AuthSignInStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInButton()
    }

    private func setupSignInButton() {
        // view로 이동
        let appleSignInButton = ASAuthorizationAppleIDButton()
        let githubSignInButton = UIButton()
        appleSignInButton.addTarget(self, action: #selector(handleSignInPress), for: .touchUpInside)
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
    
    @objc func handleSignInPress() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
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
        print("error")
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
