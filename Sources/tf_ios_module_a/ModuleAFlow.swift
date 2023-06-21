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
    
    public var flowB: IFlowB?
    
    
    public init(service : String, coordinator : FlowCoordinator, moduleBFlow : IFlowB?, rootVC : UINavigationController) {
        appService = service
        rootCoordinator = coordinator
        flowB = moduleBFlow
        self.rootViewController = rootVC
    }
    
    public var root: Presentable {
        return self.rootViewController ?? UINavigationController()
    }
    
    private weak var rootViewController :UINavigationController?
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
        self.rootViewController?.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }
    
    private func navigateToLoginResultScreen(message : String) -> FlowContributors {
        print("navigateToLoginResultScreen")
        let vc = LoginSuccessViewController.init(nibName: "LoginSuccessViewController", bundle: Bundle.module)
        vc.viewModel = LoginnSuccessViewModel(message: message)
        vc.title = message
        self.rootViewController?.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }
    
    
    private func openModuleB() -> FlowContributors {
        let bValue = flowB != nil ? "Not null" : "null"
        print("flowB: \(bValue)")
        guard let flowB else { return .none }
        return flowB.presentProfileScreen()
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
