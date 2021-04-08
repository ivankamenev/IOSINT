//
//  LoginViewController.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 27.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func checkLogin(_: String) -> Bool
    func checkPassword(_: String) -> Bool
}

class LoginViewController: UIViewController {
    
    weak var coordinator: ProfileFlowCoordinator?
    var delegate: LoginViewControllerDelegate?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    private let wrapperView: UIView = {
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        return wrapper
    }()

    private let logoView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo.png")
        return imageView
    }()

    private let logInButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.clipsToBounds = true
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logInButtomTaped), for: .touchUpInside)
        return button
    }()

    @objc func logInButtomTaped() {
        if loginCheck() {
            coordinator?.showProfileVC()
        } else {
            let alert = UIAlertController(title: "Error", message: "Wrong login or password", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

    func loginCheck() -> Bool {
        guard delegate != nil else { return false}
        guard (delegate?.checkLogin(self.emailOrPhoneTextFielf.text ?? ""))! && ((delegate?.checkPassword(self.passwordTextFielf.text ?? "")) != nil) else { return true }
        return false
    }

    private let emailAndPasswordView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 11
        return view
    }()

    private let line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        return line
    }()

    private let emailOrPhoneTextFielf: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = true
        textField.placeholder = "Email or Phone number"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor.init(named: "accentColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray
        textField.layer.cornerRadius = 10
        return textField
    }()

    private let passwordTextFielf: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray
        textField.isSecureTextEntry = true
        textField.isEnabled = true
        textField.placeholder = "Enter your password"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor.init(named: "accentColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray
        textField.layer.cornerRadius = 10
        return textField

    }()

    /// Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        wrapperView.addSubviews(logoView, logInButton, emailAndPasswordView)
        emailAndPasswordView.addSubviews(line, emailOrPhoneTextFielf, passwordTextFielf)

        delegate = LoginValidator()


        //MARK: - Add constraints
        let constraints = [

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),

            wrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wrapperView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 120),
            logoView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),

            emailAndPasswordView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            emailAndPasswordView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            emailAndPasswordView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            emailAndPasswordView.heightAnchor.constraint(equalToConstant: 100),

            line.leadingAnchor.constraint(equalTo: emailAndPasswordView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: emailAndPasswordView.trailingAnchor),
            line.centerYAnchor.constraint(equalTo: emailAndPasswordView.centerYAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5),

            emailOrPhoneTextFielf.leadingAnchor.constraint(equalTo: emailAndPasswordView.leadingAnchor, constant: 10),
            emailOrPhoneTextFielf.trailingAnchor.constraint(equalTo: emailAndPasswordView.trailingAnchor),
            emailOrPhoneTextFielf.topAnchor.constraint(equalTo: emailAndPasswordView.topAnchor),
            emailOrPhoneTextFielf.bottomAnchor.constraint(equalTo: line.topAnchor),

            passwordTextFielf.leadingAnchor.constraint(equalTo: emailAndPasswordView.leadingAnchor, constant: 10),
            passwordTextFielf.trailingAnchor.constraint(equalTo: emailAndPasswordView.trailingAnchor),
            passwordTextFielf.bottomAnchor.constraint(equalTo: emailAndPasswordView.bottomAnchor),
            passwordTextFielf.topAnchor.constraint(equalTo: line.bottomAnchor),

            logInButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: emailAndPasswordView.bottomAnchor, constant: 16),
            logInButton.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)


        ]

        NSLayoutConstraint.activate(constraints)
    }

}

extension UIView {

    func addSubviews(_ subview: UIView...) {
        subview.forEach {addSubview(_:$0)}
    }
}

class LoginValidator: LoginViewControllerDelegate {

    func checkLogin(_ login: String) -> Bool {
        guard login == Checker.shared.login else { return true}
        return false
    }

    func checkPassword(_ password: String) -> Bool {
        guard password == Checker.shared.password else { return true}
        return false
    }
}

class Checker {
    static let shared = Checker()
    let login = "Ivan"
    let password = "Kamenev"
    private init() {}
}




