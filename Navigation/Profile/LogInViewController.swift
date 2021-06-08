//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ivan Kamenev on 26.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    var coordinator: ProfileCoordinator?
    private let scrollView = UIScrollView()
    private let wrapperView = UIView()
    var delegate: LoginViewControllerDelegate?
    var handle: AuthStateDidChangeListenerHandle?
    
    var count = 0
    let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = "Email or phone"
        textField.isUserInteractionEnabled = true
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let textViews: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let deviderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var pickUpPassword: UIButton = {
        let button = UIButton()
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pickUpPass), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        navigationController?.navigationBar.isHidden = true
        
        startTimer()
    }
    
    private func startTimer() {
        let timer = Timer(timeInterval: 1, repeats: true) { (_) in
            self.timerLabel.text = "Вы находитесь на этом экране \(self.count) секунд(ы)"
            self.count += 1
            if self.count > 30 {
                self.timerLabel.textColor = .red
            }
        }
        
        RunLoop.main.add(timer, forMode: .common)
    }
    
    /// Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                    print("USERS EMAIL: \(user?.email)")

                    if user != nil {
                        self.coordinator?.loginButtonPressed()
                    }
                }
            }

            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                Auth.auth().removeStateDidChangeListener(handle!)
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
    
    @objc private func loginButtonPressed() {
        delegate?.signIn(email: emailTextField.text!, pass: passwordTextField.text!, failure: coordinator!.showAlert)
    }
    
    @objc private func pickUpPass() {
        spinner.startAnimating()
        
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .background
        let operation = BruteForceOperation(passField: passwordTextField, spinner: spinner)
        operationQueue.addOperation(operation)
    }
    
    
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .automatic
        
        view.addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        wrapperView.addSubviews(logoImageView, textViews, loginButton, pickUpPassword, spinner, timerLabel)
        textViews.addSubviews(emailTextField, deviderView, passwordTextField)
        
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            wrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            timerLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            timerLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
            timerLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
            timerLabel.heightAnchor.constraint(equalToConstant: 50),
            
            textViews.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            textViews.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            textViews.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor , constant: -16),
            textViews.heightAnchor.constraint(equalToConstant: 100),
            
            emailTextField.topAnchor.constraint(equalTo: textViews.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: textViews.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: textViews.trailingAnchor, constant: -12),
            emailTextField.heightAnchor.constraint(equalToConstant: 49.75),
            
            deviderView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            deviderView.leadingAnchor.constraint(equalTo: textViews.leadingAnchor),
            deviderView.trailingAnchor.constraint(equalTo: textViews.trailingAnchor),
            deviderView.heightAnchor.constraint(equalToConstant: 0.5),
            
            passwordTextField.topAnchor.constraint(equalTo: deviderView.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: textViews.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: textViews.trailingAnchor, constant: 12),
            passwordTextField.heightAnchor.constraint(equalToConstant: 49.75),
            
            loginButton.topAnchor.constraint(equalTo: textViews.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            pickUpPassword.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            pickUpPassword.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            pickUpPassword.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            pickUpPassword.heightAnchor.constraint(equalToConstant: 50),
            
            spinner.topAnchor.constraint(equalTo: pickUpPassword.bottomAnchor, constant: 16),
            spinner.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            spinner.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

protocol LoginViewControllerDelegate {
    func checkLogin(userLogin: String) -> Bool
    func checkPass(userPass: String) -> Bool
    func signIn(email: String, pass: String, failure: @escaping (Errors) -> Void)
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
