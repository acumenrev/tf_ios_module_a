//
//  LoginViewController.swift
//  
//
//  Created by AL-TVO163 on 19/06/2023.
//

import UIKit
import Reusable

public class LoginViewController: UIViewController, ViewModelBased {
    
    public var viewModel: LoginViewModel!
    
    typealias ViewModelType = LoginViewModel
    
    public static func instantiate() -> LoginViewController {
        let vc = LoginViewController.init(nibName: "LoginViewController", bundle: .module)
        vc.viewModel = LoginViewModel()
        vc.title = "Login"
        return vc
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("LogiViewController hello")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("LoginViewController viewWillAppear")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("LoginViewController viewDidAppear")
    }
    
    @IBAction private func btnLoginSuccess(_ data : Any) {
        viewModel.loginnSuccess()
    }
    
    @IBAction private func btnLoginFail(_ data : Any) {
        viewModel.loginnFailed()
    }
}
