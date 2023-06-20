//
//  LoginViewController.swift
//  
//
//  Created by AL-TVO163 on 19/06/2023.
//

import UIKit
import Reusable
import URLNavigator
import tf_ios_app_flows

public class LoginViewController: UIViewController, ViewModelBased {
    
    public var viewModel: LoginViewModel!
    
    typealias ViewModelType = LoginViewModel
    private(set) var navigator: NavigatorProtocol?
    
    public static func instantiate(navigator: NavigatorProtocol) -> LoginViewController {
        let vc = LoginViewController.init(nibName: "LoginViewController", bundle: .module)
        vc.viewModel = LoginViewModel()
        vc.navigator = navigator
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
//        navigator?.push(ModuleARoutes.loginResult.rawValue, context: ["message": "Success"], from: .none, animated: true)
        navigator?.push(ModuleBRoutes.profile.rawValue, context: nil, from: .none, animated: true)
    }
    
    @IBAction private func btnLoginFail(_ data : Any) {
        navigator?.push(ModuleARoutes.loginResult.rawValue, context: ["message": "Failed"], from: .none, animated: true)
    }
}
