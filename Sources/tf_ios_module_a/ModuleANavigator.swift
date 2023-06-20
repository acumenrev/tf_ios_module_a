//
//  File.swift
//  
//
//  Created by AL-TVO163 on 20/06/2023.
//

import Foundation
import URLNavigator
import tf_ios_app_flows

public struct ModuleANavigator {
    public static func initialize(navigator: NavigatorProtocol) {
        navigator.register(ModuleARoutes.login.rawValue) { url, values, context in
            return LoginViewController.instantiate(navigator: navigator)
        }
        
        navigator.register(ModuleARoutes.loginResult.rawValue) { url, values, context in
            
            var message = ""
            if let dContext = context as? [String: Any] {
                message = (dContext["message"] as? String) ?? ""
            }
            
    
            print("open login result \(message)")
            
            if message == "Success" {
                
                navigator.open(ModuleBRoutes.profile.rawValue, context: nil)
                return nil
            }
            
            let vc = LoginSuccessViewController.init(nibName: "LoginSuccessViewController", bundle: Bundle.module)
            vc.viewModel = LoginnSuccessViewModel(message: message)
            vc.title = message
            return vc
        }
    }
}
