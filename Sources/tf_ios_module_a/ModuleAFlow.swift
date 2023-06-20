//
//  File.swift
//  
//
//  Created by AL-TVO163 on 19/06/2023.
//

import Foundation
import tf_ios_app_flows
import UIKit
import RxFlow
import RxCocoa
import RxSwift


public class ModuleAFlow : IFlowA {
    public weak var rootCoordinator: RxFlow.FlowCoordinator?
    
    
    
    public init(service : String, coordinator : FlowCoordinator) {
        appService = service
        rootCoordinator = coordinator
    }
    
    public var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    public var appService: String
    
    
    public func navigate(to step: Step) -> FlowContributors {
        print("module A navigate to \(step)")
        guard let step = step as? FlowAStepper else { return .none }
        
        
        switch step {
        case .login:
            return navigateToLoginScreen()
        case .loginFailed(let message):
            return navigateToLoginResultScreen(message: message)
        case .loginSuccess(let message):
            return openModuleB()
        default:
            return .none
        }
    }
    
    /// Navigate To Loginn Screen
    private func navigateToLoginScreen() -> FlowContributors {
        let vc = LoginViewController.init(nibName: "LoginViewController", bundle: Bundle.module)
        vc.viewModel = LoginViewModel()
        vc.title = "Login"
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }
    
    private func navigateToLoginResultScreen(message : String) -> FlowContributors {
        print("navigateToLoginResultScreen")
        let vc = LoginSuccessViewController.init(nibName: "LoginSuccessViewController", bundle: Bundle.module)
        vc.viewModel = LoginnSuccessViewModel(message: message)
        vc.title = message
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }
    
    
    private func openModuleB() -> FlowContributors {
        self.rootCoordinator?.navigate(to: FlowBStepper.profile)
        return .none
    }
    
}

public class ModuleAStepper : Stepper {
    
    public let steps = PublishRelay<Step>()
    
    public init(){
        
    }
    
    public var initialStep: Step {
        return FlowAStepper.login
    }
}
