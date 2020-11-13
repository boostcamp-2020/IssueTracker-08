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
    @IBOutlet weak var guestIdTextfield: UITextField!
    @IBOutlet weak var guestPwdTextfield: UITextField!
    
    // MARK:- Properties
    var githubManager: GithubManager?
    let appleSignInButton = ASAuthorizationAppleIDButton()
    let githubSignInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        githubManager = OAuthGithubManager()
        githubManager?.viewController = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK:- IBActions
    @IBAction func onGuestLoginButtonPressed(_ sender: Any) {
        if guestIdTextfield.text == "test",
           guestPwdTextfield.text == "1234" {
            
            let request = SigninModel.Apple.Request(name: appleSignin(name: "test"))
            OAuthAppleManager().signInWithApple(request: request, completion:{ [self] userInfo in
                UserDefaults.standard.set(userInfo.jwtToken, forKey: "JWT")
                UserDefaults.standard.set(userInfo.userId, forKey: "ID")
                
                routeToIssueListViewController()
            })
        }
    }
    
    private func routeToIssueListViewController() {
        let destinationVC = storyboard?.instantiateViewController(identifier: "TabBar") as? UITabBarController
        view.window?.rootViewController = destinationVC
    }
    
}

//MARK:- Setup
extension SignInViewController {
    
    private func setup() {
        configureSignInButton()
        setupSocialSigninView()
        addTargets()
        addObservers()
    }
    
    private func configureSignInButton() {
        appleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        appleSignInButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        appleSignInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        githubSignInButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        githubSignInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        githubSignInButton.backgroundColor = UIColor.darkGray
        githubSignInButton.setTitle("Sign in Github", for: .normal)
        githubSignInButton.layer.cornerRadius = 5
    }
    
    private func setupSocialSigninView() {
        AuthSignInStackView.addArrangedSubview(githubSignInButton)
        AuthSignInStackView.addArrangedSubview(appleSignInButton)
    }
    
    private func addTargets() {
        appleSignInButton.addTarget(self, action: #selector(handleAppleSignInPress), for: .touchUpInside)
        githubSignInButton.addTarget(self, action: #selector(handleGithubSignInPress), for: .touchUpInside)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

//MARK:- Handle Signin Press
extension SignInViewController {
    
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
            
            let name: String = (appleIDCredential.email?.components(separatedBy: "@")[0])!
            let request = SigninModel.Apple.Request(name: appleSignin(name: name))
            OAuthAppleManager().signInWithApple(request: request, completion:{ [self] userInfo in
                UserDefaults.standard.set(userInfo.jwtToken, forKey: "JWT")
                UserDefaults.standard.set(userInfo.userId, forKey: "ID")
                routeToIssueListViewController()
            })
            
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
        return self.view.window!// ?? ASPresentationAnchor()
    }
}

//MARK:- Handle Keyboard
extension SignInViewController {
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if guestIdTextfield.isFirstResponder {
            view.frame.origin.y = -guestIdTextfield.frame.minY + 100
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
}

